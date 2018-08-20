package game.command.timer
{
   import com.progrestar.common.Logger;
   import flash.display.Stage;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import org.osflash.signals.Signal;
   
   public class GameTimer
   {
      
      public static const instance:GameTimer = new GameTimer();
      
      public static var artificialOffset:int = 0;
      
      private static const logger:Logger = Logger.getLogger(Logger);
      
      public static var cacheDelta:uint = 3600;
      
      public static var localTimeOffset:uint = 75600;
      
      public static const ONE_DAY:uint = 86400;
      
      public static const THREE_DAYS:uint = 259200;
      
      public static const THREE_HOURS:uint = 10800;
      
      private static var _initTime:Number = Math.floor(new Date().time / 1000);
       
      
      private var _currentFrame:uint = 0;
      
      private var _stage:Stage;
      
      public const oneFrameTimer:Signal = new Signal();
      
      public const oneSecTimer:Signal = new Signal();
      
      public const fiveSecTimer:Signal = new Signal();
      
      public const tenSecTimer:Signal = new Signal();
      
      public const oneMinTimer:Signal = new Signal();
      
      public const onMidnightTimer:Signal = new Signal();
      
      private var _startTimeMS:Number;
      
      private var _undistortedStartTimeMS:Number;
      
      private var _startGetTimer:Number;
      
      private var _controlTimeMS:Number;
      
      private var _initedServerTimeS:Number;
      
      private var _nextDayTimestamp:Number;
      
      private var _lastTime:uint;
      
      private var _loginTime:Number;
      
      private var _scheduledEvents:Array;
      
      private var _scheduledEventsByKey:Dictionary;
      
      public var useAdaptiveTimer:Boolean = false;
      
      public const serverTime:ClientTimeSpeedAdjustment = new ClientTimeSpeedAdjustment();
      
      public function GameTimer()
      {
         _scheduledEvents = [];
         _scheduledEventsByKey = new Dictionary();
         super();
      }
      
      public static function getPlayerTime(param1:Boolean = false) : String
      {
         var _loc2_:Date = new Date(instance.currentServerTime + getTimer());
         var _loc3_:int = _loc2_.getHours();
         var _loc6_:int = _loc2_.getMinutes();
         var _loc4_:int = _loc2_.getSeconds();
         var _loc7_:String = String(_loc3_ < 10?"0" + _loc3_:_loc3_);
         var _loc8_:String = String(_loc6_ < 10?"0" + _loc6_:_loc6_);
         var _loc5_:String = String(_loc4_ < 10?"0" + _loc4_:_loc4_);
         return _loc7_ + ":" + _loc8_ + (!!param1?":" + _loc5_:"");
      }
      
      public function getNextServerMidnight() : int
      {
         return getNextRelativeMidnight(currentServerTime);
      }
      
      public function getPreviousRelativeMidnight(param1:uint) : uint
      {
         return getNextRelativeMidnight(param1) - 86400;
      }
      
      public function getNextRelativeMidnight(param1:uint) : uint
      {
         return param1 % 86400 < localTimeOffset?param1 - param1 % 86400 + localTimeOffset:Number(param1 - param1 % 86400 + localTimeOffset + 86400);
      }
      
      public function get currentFrame() : uint
      {
         return _currentFrame;
      }
      
      public function nextFrame() : void
      {
         _currentFrame = Number(_currentFrame) + 1;
         if(_currentFrame % (5 * _stage.frameRate) < 1)
         {
            fiveSecTimer.dispatch();
         }
         if(_currentFrame % (60 * _stage.frameRate) < 1)
         {
            oneMinTimer.dispatch();
         }
         oneFrameTimer.dispatch();
      }
      
      public function isToday(param1:uint) : Boolean
      {
         return getNextServerMidnight() - param1 <= 86400;
      }
      
      public function getDaysFromTime(param1:uint) : uint
      {
         return Math.floor((currentServerTime - param1) / 86400);
      }
      
      public function addAlarm(param1:AlarmEvent) : Boolean
      {
         if(param1.time < currentServerTime || param1.key != null && param1.key in _scheduledEventsByKey)
         {
            return false;
         }
         _scheduledEvents.push(param1);
         if(param1.key != null)
         {
            _scheduledEventsByKey[param1.key] = param1;
         }
         _scheduledEvents.sort(AlarmEvent.sortByTime);
         return true;
      }
      
      public function removeAlarm(param1:AlarmEvent) : void
      {
         var _loc2_:int = _scheduledEvents.indexOf(param1);
         if(_loc2_ > -1)
         {
            _scheduledEvents.splice(_loc2_,1);
         }
         if(param1.key != null)
         {
            delete _scheduledEventsByKey[param1.key];
         }
      }
      
      public function calcLocalTimeOffset() : int
      {
         var _loc1_:Date = new Date();
         var _loc3_:int = _loc1_.hoursUTC;
         var _loc2_:int = _loc1_.hours;
         return (_loc3_ - _loc2_ + 24) % 24 * 3600 % 86400;
      }
      
      public function init(param1:Stage) : void
      {
         _stage = param1;
         oneFrameTimer.add(checkScheduledEvents);
         oneSecTimer.add(checkMidnight);
         var _loc2_:Timer = new Timer(1000);
         _loc2_.addEventListener("timer",handler_oneSecTimer);
         _loc2_.start();
      }
      
      public function initServerTime(param1:Number, param2:int, param3:uint) : void
      {
         localTimeOffset = param3 % 86400;
         _nextDayTimestamp = param2;
         if(_initedServerTimeS == param1)
         {
            return;
         }
         _initedServerTimeS = param1;
         _loginTime = new Date().time / 1000;
         _lastTime = _initedServerTimeS;
         _controlTimeMS = param1 * 1000;
         _undistortedStartTimeMS = new Date().time;
         _startTimeMS = new Date().time;
         _startGetTimer = getTimer();
      }
      
      public function testUpdateServerTime(param1:Number, param2:Number = 0.01) : void
      {
         param1 = param1 + artificialOffset * 1000;
         if(param2 > 0)
         {
            serverTime.updateServerTime(param1,param2);
         }
      }
      
      public function adjustServerTime(param1:Number, param2:Number = 0.01) : void
      {
         _controlTimeMS = param1;
         var _loc5_:Number = _initedServerTimeS + (new Date().time - _startTimeMS) / 1000;
         var _loc4_:Number = _loc5_ - param1 / 1000;
         if(Math.abs(param1 / 1000 - _loc5_) < param2)
         {
            return;
         }
         var _loc3_:Number = _initedServerTimeS + (new Date().time - _undistortedStartTimeMS) / 1000 - param1 / 1000;
         _startTimeMS = _startTimeMS + _loc4_ * 1000;
         logger.error("adj time: " + param1 / 1000 + "(" + _loc4_.toFixed(3) + "|" + _loc3_.toFixed(3) + ")");
      }
      
      public function get timeFromLogin() : Number
      {
         return currentServerTime - _initedServerTimeS;
      }
      
      public function get timeFromLoginUndistorted() : Number
      {
         return (new Date().time - _undistortedStartTimeMS) / 1000;
      }
      
      public function get loginTime() : Number
      {
         return _loginTime;
      }
      
      public function get initTime() : Number
      {
         return _initTime;
      }
      
      public function get timeFromLoginGetTimer() : Number
      {
         return (getTimer() - _startGetTimer) / 1000;
      }
      
      public function get currentServerTime() : Number
      {
         var _loc1_:uint = Math.floor(currentServerTimeFrac);
         return _loc1_;
      }
      
      public function get nextDayTimestamp() : Number
      {
         return _nextDayTimestamp;
      }
      
      public function set nextDayTimestamp(param1:Number) : void
      {
         _nextDayTimestamp = param1;
      }
      
      public function get currentServerTimeFrac() : Number
      {
         if(useAdaptiveTimer)
         {
            return serverTime.time;
         }
         var _loc1_:Number = _initedServerTimeS + (new Date().time - _startTimeMS) / 1000;
         var _loc2_:Number = _controlTimeMS / 1000 - 1.0e-6 - _loc1_;
         if(_loc2_ > 0)
         {
            adjustServerTime(_controlTimeMS,0);
            logger.error("strange time change: " + _loc1_ + " (" + (_loc1_ - _controlTimeMS / 1000) + "), adjust to control");
            return _controlTimeMS / 1000;
         }
         _controlTimeMS = _loc1_ * 1000;
         return _loc1_;
      }
      
      private function checkScheduledEvents() : void
      {
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _scheduledEvents;
         for each(_loc3_ in _scheduledEvents)
         {
            if(currentServerTimeFrac >= _loc3_.time)
            {
               _loc2_.push(_loc3_);
               if(_loc3_.key != null)
               {
                  delete _scheduledEventsByKey[_loc3_.key];
               }
               _loc1_++;
               continue;
            }
            break;
         }
         if(_loc1_)
         {
            _scheduledEvents.splice(0,_loc1_);
         }
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.data)
            {
               _loc3_.callback(_loc3_.data);
            }
            else
            {
               _loc3_.callback();
            }
         }
      }
      
      private function checkMidnight() : void
      {
         if(!isToday(_lastTime))
         {
            onMidnightTimer.dispatch();
         }
         _lastTime = uint(currentServerTime);
      }
      
      protected function handler_oneSecTimer(param1:TimerEvent) : void
      {
         if(useAdaptiveTimer == false || serverTime.isInitialized)
         {
            oneSecTimer.dispatch();
         }
      }
   }
}
