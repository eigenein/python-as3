package battle.timeline
{
   import flash.Boot;
   
   public class Timeline extends TimeObject
   {
      
      public static var __meta__ = {
         "statics":{"roundTimeStatic":{
            "IgnoreCover":null,
            "IgnoreLogging":null
         }},
         "fields":{"roundTime":{
            "IgnoreCover":null,
            "IgnoreLogging":null
         }}
      };
      
      public static var INFINITY_TIME_INLINE:Number = 1.0e100;
      
      public static var INFINITY_TIME:Number = 1.0e100;
      
      public static var TIME_NEVER:Number = -1;
       
      
      public var timeAdvancementInterrupted:Boolean;
      
      public var eventIndex:int;
      
      public function Timeline()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         timeAdvancementInterrupted = false;
      }
      
      public static function roundTimeStatic(param1:Number) : Number
      {
         return Math.round(param1 * 10000000000) / 10000000000;
      }
      
      public static function timeToString(param1:Number) : String
      {
         var _loc3_:int = 0;
         if(param1 == Timeline.INFINITY_TIME)
         {
            return "inf";
         }
         var _loc2_:String = param1;
         if(int(_loc2_.indexOf(".")) == -1)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = 1;
         }
         if(_loc2_.length - _loc3_ > 13)
         {
            return _loc2_.substr(0,_loc3_ + 13);
         }
         return _loc2_;
      }
      
      public static function stableRound(param1:Number) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:String = "";
         if(param1 < 0)
         {
            _loc2_ = "-";
            param1 = -param1;
         }
         else if(param1 <= 0)
         {
            return "0";
         }
         if(param1 == Number(Math.POSITIVE_INFINITY))
         {
            return "Infinity";
         }
         if(param1 == Number(Math.NEGATIVE_INFINITY))
         {
            return "-Infinity";
         }
         _loc4_ = Math.log(param1) / Math.log(10);
         var _loc3_:int = _loc4_;
         if(param1 < 0.0001 || param1 > 1000000000)
         {
            param1 = param1 / Math.pow(10,_loc3_);
            _loc4_ = Math.pow(10,12);
            return _loc2_ + Math.round(param1 * _loc4_) / _loc4_ + (_loc3_ > 0?"e+" + _loc3_:"e" + _loc3_);
         }
         _loc4_ = Math.pow(10,12 - _loc3_);
         return _loc2_ + Math.round(param1 * _loc4_) / _loc4_;
      }
      
      public function update(param1:TimelineObject, param2:Number) : void
      {
      }
      
      public function timestamp() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "i" + eventIndex + " " + time;
         if(int(_loc1_.indexOf(".")) == -1)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = 1;
         }
         if(_loc1_.length - _loc2_ > 13)
         {
            return _loc1_.substr(0,_loc2_ + 13);
         }
         return _loc1_;
      }
      
      public function setupTime(param1:Number) : void
      {
      }
      
      public function roundTime(param1:Number) : Number
      {
         return Math.round((time + param1) * 1000000000000) / 1000000000000;
      }
      
      public function reset() : void
      {
         clear();
         time = 0;
      }
      
      public function remove(param1:TimelineObject) : void
      {
      }
      
      public function interruptTimeAdvancement() : void
      {
      }
      
      public function inifiniteBattle() : void
      {
         throw "infinite battle";
      }
      
      public function clear() : void
      {
      }
      
      public function cancel(param1:TimelineObject) : void
      {
      }
      
      public function advanceTime(param1:Number, param2:int = 999000000) : void
      {
      }
      
      public function add(param1:TimelineObject) : void
      {
      }
   }
}
