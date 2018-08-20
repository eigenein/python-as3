package battle.data
{
   public class InputParser
   {
       
      
      public function InputParser()
      {
      }
      
      public static function parse(param1:*, param2:Vector.<InputEventDescription>) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:int = param1.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = param1[_loc4_ + 1];
            _loc7_ = param1[_loc4_ + 2];
            _loc8_ = _loc5_;
            if(_loc8_ == "auto")
            {
               param2.push(new InputEventDescription(_loc7_,_loc5_,-1,_loc6_));
               _loc4_ = _loc4_ + 3;
               continue;
            }
            if(_loc8_ == "cast")
            {
               _loc9_ = param1[_loc4_ + 3];
               param2.push(new InputEventDescription(_loc7_,_loc5_,_loc9_,_loc6_));
               _loc4_ = _loc4_ + 4;
               continue;
            }
            if(_loc8_ == "custom")
            {
               _loc9_ = param1[_loc4_ + 3];
               _loc10_ = param1[_loc4_ + 4];
               param2.push(new InputEventDescription(_loc7_,_loc5_,_loc9_,_loc6_,_loc10_));
               _loc4_ = _loc4_ + 5;
               continue;
            }
            if(_loc8_ == "teamCustom")
            {
               _loc9_ = param1[_loc4_ + 3];
               param2.push(new InputEventDescription(_loc7_,_loc5_,-1,_loc6_,_loc9_));
               _loc4_ = _loc4_ + 4;
               continue;
            }
            return Boolean(InputParser.parseInputObjects(param1,param2));
         }
         return true;
      }
      
      public static function encode(param1:Vector.<InputEventDescription>) : *
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as InputEventDescription;
         var _loc2_:Vector.<Object> = Vector.<Object>([]);
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = param1[_loc6_];
            if(_loc7_.act == "auto")
            {
               _loc2_[_loc3_] = _loc7_.act;
               _loc2_[_loc3_ + 1] = _loc7_.i;
               _loc2_[_loc3_ + 2] = _loc7_.time;
               _loc3_ = _loc3_ + 3;
            }
            else if(_loc7_.act == "cast")
            {
               _loc2_[_loc3_] = _loc7_.act;
               _loc2_[_loc3_ + 1] = _loc7_.i;
               _loc2_[_loc3_ + 2] = _loc7_.time;
               _loc2_[_loc3_ + 3] = _loc7_.hero;
               _loc3_ = _loc3_ + 4;
            }
            else if(_loc7_.act == "custom")
            {
               _loc2_[_loc3_] = _loc7_.act;
               _loc2_[_loc3_ + 1] = _loc7_.i;
               _loc2_[_loc3_ + 2] = _loc7_.time;
               _loc2_[_loc3_ + 3] = _loc7_.hero;
               _loc2_[_loc3_ + 4] = _loc7_.id;
               _loc3_ = _loc3_ + 5;
            }
            else if(_loc7_.act == "teamCustom")
            {
               _loc2_[_loc3_] = _loc7_.act;
               _loc2_[_loc3_ + 1] = _loc7_.i;
               _loc2_[_loc3_ + 2] = _loc7_.time;
               _loc2_[_loc3_ + 3] = _loc7_.id;
               _loc3_ = _loc3_ + 4;
            }
         }
         return _loc2_;
      }
      
      public static function parseInputObjects(param1:*, param2:Vector.<InputEventDescription>) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc4_++;
            _loc5_ = _loc4_;
            _loc6_ = param1[_loc5_];
            if(_loc6_.act == null)
            {
               return false;
            }
            if(!(_loc6_.time >= 0 && _loc6_.time < Number(Math.POSITIVE_INFINITY)))
            {
               return false;
            }
            param2.push(new InputEventDescription(_loc6_.time,_loc6_.act,_loc6_.hero));
         }
         return true;
      }
      
      public static function encodeInternal(param1:*, param2:Vector.<InputEventDescription>) : *
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as InputEventDescription;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param2.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = param2[_loc6_];
            if(_loc7_.act == "auto")
            {
               param1[_loc3_] = _loc7_.act;
               param1[_loc3_ + 1] = _loc7_.i;
               param1[_loc3_ + 2] = _loc7_.time;
               _loc3_ = _loc3_ + 3;
            }
            else if(_loc7_.act == "cast")
            {
               param1[_loc3_] = _loc7_.act;
               param1[_loc3_ + 1] = _loc7_.i;
               param1[_loc3_ + 2] = _loc7_.time;
               param1[_loc3_ + 3] = _loc7_.hero;
               _loc3_ = _loc3_ + 4;
            }
            else if(_loc7_.act == "custom")
            {
               param1[_loc3_] = _loc7_.act;
               param1[_loc3_ + 1] = _loc7_.i;
               param1[_loc3_ + 2] = _loc7_.time;
               param1[_loc3_ + 3] = _loc7_.hero;
               param1[_loc3_ + 4] = _loc7_.id;
               _loc3_ = _loc3_ + 5;
            }
            else if(_loc7_.act == "teamCustom")
            {
               param1[_loc3_] = _loc7_.act;
               param1[_loc3_ + 1] = _loc7_.i;
               param1[_loc3_ + 2] = _loc7_.time;
               param1[_loc3_ + 3] = _loc7_.id;
               _loc3_ = _loc3_ + 4;
            }
         }
         return param1;
      }
   }
}
