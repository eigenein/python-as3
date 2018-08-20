package game.command.timer
{
   import flash.utils.getTimer;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class ClientTimeSpeedAdjustment implements IAnimatable
   {
      
      private static const ONE_FRAME_TIME_DELTA_ERROR_THRESHOLD_SECONDS:int = 100;
       
      
      public var initialTimeDelta:Number = NaN;
      
      public var startDate:Number = NaN;
      
      public var startTime:Number = NaN;
      
      public var startServerTime:Number = NaN;
      
      public var maxStartServerTime:Number = NaN;
      
      public var clientRelativeTimeOffset:Number = NaN;
      
      public var clientRelativeTimeSpeed:Number = NaN;
      
      private var previousGetTimer:int;
      
      private var previousDate:int;
      
      private var clientTimeHasBeenInterrupted:Boolean;
      
      private var temporaryTimeFix:int = 0;
      
      private var totalInterruptsSum:int = 0;
      
      public function ClientTimeSpeedAdjustment()
      {
         previousGetTimer = getTimer();
         previousDate = new Date().time;
         super();
      }
      
      public function get time() : Number
      {
         return currentServerTime / 1000;
      }
      
      public function get currentServerTime() : Number
      {
         return startServerTime + (new Date().time - startDate) / clientRelativeTimeSpeed + temporaryTimeFix;
      }
      
      public function get isInitialized() : Boolean
      {
         return startServerTime == startServerTime;
      }
      
      protected function calculateCurrentServerTimeByDate() : Number
      {
         return startServerTime + (new Date().time - startDate);
      }
      
      protected function calculateCurrentServerTimeByTimer() : Number
      {
         return startServerTime + (getTimer() - startTime);
      }
      
      public function advanceTime(param1:Number) : void
      {
         verifyClientTime();
      }
      
      public function updateServerTime(param1:Number, param2:Number) : void
      {
         var _loc4_:* = NaN;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = this.currentServerTime;
         if(_loc7_ != _loc7_)
         {
            initServerTime(param1,param2);
            initEnterFrame();
         }
         else if(clientTimeHasBeenInterrupted)
         {
            initServerTime(param1,param2);
            temporaryTimeFix = 0;
            clientTimeHasBeenInterrupted = false;
         }
         else
         {
            _loc4_ = _loc7_;
            _loc8_ = new Date().time - startDate;
            _loc9_ = Math.abs(_loc4_ - (param1 + clientRelativeTimeOffset)) - param2;
            if(_loc9_ > 0)
            {
               _loc12_ = param1 - _loc8_ / clientRelativeTimeSpeed;
               _loc10_ = param1 - _loc8_ / clientRelativeTimeSpeed + param2;
               _loc13_ = Math.max(startServerTime,_loc12_);
               _loc6_ = Math.min(maxStartServerTime,_loc10_);
               if(_loc12_ < maxStartServerTime && startServerTime < _loc10_)
               {
                  _loc5_ = startServerTime - _loc12_;
                  clientRelativeTimeOffset = _loc5_;
                  trace("clientTimeFix",_loc5_,"initRequestLatency",initialTimeDelta);
               }
               else
               {
                  _loc11_ = calculateCurrentServerTimeByDate();
                  _loc14_ = param1 - startServerTime;
                  _loc3_ = _loc11_ - startServerTime;
                  clientRelativeTimeSpeed = _loc3_ / _loc14_;
                  trace("updateServerTime","error:",_loc9_,"clientTimeSpeed:",clientRelativeTimeSpeed,"requestLatency:",param2);
               }
            }
         }
      }
      
      protected function verifyClientTime() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = getTimer();
         var _loc1_:int = new Date().time;
         var _loc3_:int = _loc2_ - previousGetTimer;
         var _loc5_:int = _loc1_ - previousDate;
         if(Math.abs(_loc3_ - _loc5_) > 100)
         {
            _loc4_ = _loc5_ - _loc3_;
            totalInterruptsSum = totalInterruptsSum + _loc4_;
            temporaryTimeFix = temporaryTimeFix - _loc4_;
            clientTimeHasBeenInterrupted = true;
         }
         previousGetTimer = _loc2_;
         previousDate = _loc1_;
      }
      
      protected function initEnterFrame() : void
      {
         Starling.juggler.add(this);
      }
      
      protected function initServerTime(param1:Number, param2:Number) : void
      {
         startServerTime = param1;
         maxStartServerTime = param1 + param2;
         startDate = new Date().time;
         startTime = getTimer();
         trace("initServerTime",param1,startDate,param2);
         initialTimeDelta = param2;
         clientRelativeTimeOffset = 0;
         clientRelativeTimeSpeed = 1;
      }
      
      public function toString() : String
      {
         return JSON.stringify({
            "currentServerTime":time,
            "startDate":startDate,
            "startServerTime":startServerTime,
            "clientRelativeTimeOffset":clientRelativeTimeOffset,
            "clientRelativeTimeSpeed":clientRelativeTimeSpeed,
            "temporaryTimeFix":temporaryTimeFix,
            "totalInterruptsSum":totalInterruptsSum
         });
      }
   }
}
