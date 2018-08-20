package org.osflash.signals
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SignalWatcher
   {
      
      private static var map:Dictionary = new Dictionary(true);
      
      private static var creationTime:Dictionary = new Dictionary(true);
      
      private static var contextCreationTime:Dictionary = new Dictionary(true);
      
      private static var lastContextCreationTime:Number;
      
      private static var listenersCount:Dictionary = new Dictionary(true);
      
      private static var contextName:String = "";
       
      
      public function SignalWatcher()
      {
         super();
      }
      
      public static function nameContext(param1:String) : void
      {
         contextName = param1;
      }
      
      public static function rename(param1:*, param2:String) : void
      {
         map[param1] = param2 + " " + creationTime[param1];
      }
      
      public static function registerSignal(param1:*, param2:String) : void
      {
         creationTime[param1] = getTimer();
         map[param1] = contextName + ":" + param2 + " " + creationTime[param1];
      }
      
      public static function createPopup(param1:*) : void
      {
         lastContextCreationTime = getTimer();
         contextCreationTime[param1] = lastContextCreationTime;
         var _loc4_:int = 0;
         var _loc3_:* = listenersCount;
         for(var _loc2_ in listenersCount)
         {
            listenersCount[_loc2_] = 0;
         }
      }
      
      public static function disposePopup(param1:*) : void
      {
      }
      
      public static function add(param1:*, param2:*) : void
      {
         var _loc3_:* = listenersCount;
         var _loc4_:* = param1;
         var _loc5_:* = Number(_loc3_[_loc4_]) + 1;
         _loc3_[_loc4_] = _loc5_;
      }
      
      public static function remove(param1:*, param2:*) : void
      {
         var _loc3_:* = listenersCount;
         var _loc4_:* = param1;
         var _loc5_:* = Number(_loc3_[_loc4_]) - 1;
         _loc3_[_loc4_] = _loc5_;
      }
      
      public static function removeAll(param1:*) : void
      {
         listenersCount[param1] = 0;
      }
      
      public static function report() : void
      {
         lastContextCreationTime = getTimer();
         trace(lastContextCreationTime);
         var _loc4_:int = 0;
         var _loc3_:* = map;
         for(var _loc1_ in map)
         {
            if(creationTime[_loc1_] < lastContextCreationTime)
            {
               if(listenersCount[_loc1_] > 0)
               {
                  trace(map[_loc1_]);
               }
            }
         }
         var _loc6_:int = 0;
         var _loc5_:* = listenersCount;
         for(var _loc2_ in listenersCount)
         {
            listenersCount[_loc2_] = 0;
         }
      }
   }
}
