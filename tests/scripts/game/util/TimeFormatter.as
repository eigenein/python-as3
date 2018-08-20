package game.util
{
   import com.progrestar.common.lang.Translate;
   
   public class TimeFormatter
   {
      
      private static const _target:Object = {};
      
      public static const DELIMITER:String = ":";
      
      public static const DELIMITER_REG:RegExp = /\:/g;
      
      public static const H:String = "{h}";
      
      public static const M:String = "{m}";
      
      public static const S:String = "{s}";
      
      public static const MS:String = "{m}:{s}";
      
      public static const HMS:String = "{h}:{m}:{s}";
      
      public static const HM:String = "{h}:{m}";
      
      public static const DHM:String = "{d} {h} {m}";
      
      public static const DH:String = "{d} {h}";
      
      public static const D:String = "{d}";
       
      
      public function TimeFormatter()
      {
         super();
         throw "static";
      }
      
      public static function process(param1:uint, param2:Object) : Object
      {
         var _loc3_:Object = toNumbers(param1);
         if(_loc3_.d > 0)
         {
            _loc3_.h = _loc3_.h + _loc3_.d * 24;
         }
         param2.s = (_loc3_.s < 10?"0":"") + _loc3_.s;
         param2.m = (_loc3_.m < 10 && _loc3_.h > 0?"0":"") + _loc3_.m;
         param2.h = (_loc3_.h < 10 && _loc3_.d > 0?"0":"") + _loc3_.h;
         param2.d = 0;
         return param2;
      }
      
      public static function toHMS(param1:uint, param2:String = ":") : String
      {
         var _loc3_:String = "{h}:{m}:{s}";
         if(param2 != ":")
         {
            _loc3_ = replaceTemplate(_loc3_,param2);
         }
         process(param1,_target);
         return StringUtils.sub(_loc3_,_target);
      }
      
      public static function toMS(param1:uint, param2:String = ":") : String
      {
         var _loc3_:String = "{m}:{s}";
         if(param2 != ":")
         {
            _loc3_ = replaceTemplate(_loc3_,param2);
         }
         process(param1,_target);
         return StringUtils.sub(_loc3_,_target);
      }
      
      public static function toMS2(param1:uint, param2:String = "{h}:{m}:{s}", param3:String = ":", param4:Boolean = false) : String
      {
         var _loc5_:* = param2;
         if(param3 != ":")
         {
            _loc5_ = replaceTemplate(_loc5_,param3);
         }
         var _loc6_:Object = toNumbers(param1);
         _loc6_.h = _loc6_.h + (!!_loc6_.d?_loc6_.d * 24:0);
         _target.s = (_loc6_.s < 10?"0":"") + _loc6_.s;
         _target.m = (_loc6_.m < 10?"0":"") + _loc6_.m;
         _target.h = (_loc6_.h < 10?"0":"") + _loc6_.h;
         _target.d = 0;
         if(param4)
         {
            localize(_target);
         }
         return StringUtils.sub(_loc5_,_target);
      }
      
      public static function toDH(param1:uint, param2:String = "{d} {h} {m}", param3:String = ":", param4:Boolean = false) : String
      {
         var _loc5_:* = param2;
         if(param3 != ":")
         {
            _loc5_ = replaceTemplate(_loc5_,param3);
         }
         var _loc6_:Object = toNumbers(param1);
         _target.s = (_loc6_.s < 10?"0":"") + _loc6_.s;
         _target.m = (_loc6_.m < 10?"0":"") + _loc6_.m;
         _target.h = _loc6_.h;
         _target.d = _loc6_.d;
         if(param4)
         {
            localize(_target);
         }
         return StringUtils.sub(_loc5_,_target);
      }
      
      public static function toD(param1:uint, param2:String = "{d} {h} {m}", param3:String = ":", param4:Boolean = false) : String
      {
         var _loc5_:* = param2;
         if(param3 != ":")
         {
            _loc5_ = replaceTemplate(_loc5_,param3);
         }
         var _loc6_:Object = toNumbers(param1);
         _target.s = _loc6_.s;
         _target.m = _loc6_.m;
         _target.h = _loc6_.h;
         _target.d = _loc6_.d;
         if(param4)
         {
            localize(_target);
         }
         return StringUtils.sub(_loc5_,_target);
      }
      
      private static function localize(param1:Object) : Object
      {
         param1.s = param1.s + Translate.translate("COMMON_UI_SEC_CHAR");
         param1.m = param1.m + Translate.translate("COMMON_UI_MIN_CHAR");
         param1.h = param1.h + Translate.translate("COMMON_UI_HOUR_CHAR");
         param1.d = param1.d + Translate.translate("COMMON_UI_DAY_CHAR");
         return param1;
      }
      
      private static function replaceTemplate(param1:String, param2:String) : String
      {
         while(param1.search(DELIMITER_REG) >= 0)
         {
            param1 = param1.replace(DELIMITER_REG,param2);
         }
         return param1;
      }
      
      public static function dateToMS(param1:Date) : String
      {
         var _loc2_:String = param1.hours < 10?"0" + param1.hours.toString():param1.hours.toString();
         var _loc3_:String = param1.minutes < 10?"0" + param1.minutes.toString():param1.minutes.toString();
         return _loc2_ + ":" + _loc3_;
      }
      
      public static function toNumbers(param1:uint, param2:Object = null) : Object
      {
         if(!param2)
         {
            param2 = {};
         }
         var _loc3_:uint = param1 % 60;
         var _loc6_:uint = (param1 - _loc3_) / 60 % 60;
         var _loc5_:uint = (param1 - _loc3_ - _loc6_ * 60) / 3600 % 24;
         var _loc4_:uint = (param1 - _loc3_ - _loc6_ * 60 - _loc5_ * 3600) / 86400;
         param2.s = _loc3_;
         param2.m = _loc6_;
         param2.h = _loc5_;
         param2.d = _loc4_;
         return param2;
      }
      
      public static function toString(param1:uint) : String
      {
         var _loc2_:Object = toNumbers(param1);
         return (_loc2_.h < 10?"0" + _loc2_.h:_loc2_.h) + ":" + (_loc2_.m < 10?"0" + _loc2_.m:_loc2_.m) + ":" + (_loc2_.s < 10?"0" + _loc2_.s:_loc2_.s);
      }
      
      public static function toStringHM(param1:uint, param2:String = ":") : String
      {
         var _loc3_:Object = toNumbers(param1);
         return (_loc3_.h < 10?"0" + _loc3_.h:_loc3_.h) + param2 + (_loc3_.m < 10?"0" + _loc3_.m:_loc3_.m);
      }
      
      public static function toStringMS(param1:uint) : String
      {
         var _loc2_:Object = toNumbers(param1);
         return (_loc2_.m < 10?"0" + _loc2_.m:_loc2_.m) + ":" + (_loc2_.s < 10?"0" + _loc2_.s:_loc2_.s);
      }
      
      public static function timeStampToDateStr(param1:int) : String
      {
         var _loc2_:Date = new Date(param1 * 1000);
         var _loc3_:int = _loc2_.getDate();
         var _loc4_:int = _loc2_.getMonth() + 1;
         return _loc3_ + "." + (_loc4_ < 10?"0" + _loc4_:_loc4_) + "." + _loc2_.getFullYear();
      }
   }
}
