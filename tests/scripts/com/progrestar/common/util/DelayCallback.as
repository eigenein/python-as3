package com.progrestar.common.util
{
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class DelayCallback
   {
      
      private static var keysByTimers:Dictionary = new Dictionary(true);
      
      private static var timersByKey:Object = {};
      
      private static var args:Object = {};
       
      
      public function DelayCallback()
      {
         super();
      }
      
      public static function call(param1:*, param2:Function, param3:String, param4:int, param5:Boolean = false, ... rest) : void
      {
         if(param5)
         {
            clear(param3);
         }
         else if(timersByKey[param3] != null)
         {
            return;
         }
         var _loc7_:Timer = new Timer(param4,0);
         _loc7_.addEventListener("timer",timerHandler);
         _loc7_.start();
         keysByTimers[_loc7_] = param3;
         timersByKey[param3] = _loc7_;
         rest.unshift(param1,param2);
         args[param3] = rest;
      }
      
      private static function timerHandler(param1:TimerEvent) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = undefined;
         var _loc3_:* = null;
         var _loc2_:Timer = param1.target as Timer;
         var _loc5_:String = keysByTimers[_loc2_];
         if(args[_loc5_] != null)
         {
            _loc4_ = args[_loc5_];
            _loc6_ = _loc4_.shift();
            _loc3_ = _loc4_.shift();
            clear(_loc5_);
            _loc3_.apply(_loc6_,_loc4_);
         }
      }
      
      public static function clear(param1:String) : void
      {
         var _loc2_:Timer = timersByKey[param1];
         if(_loc2_ != null)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",timerHandler);
         }
         delete keysByTimers[_loc2_];
         delete timersByKey[param1];
      }
   }
}
