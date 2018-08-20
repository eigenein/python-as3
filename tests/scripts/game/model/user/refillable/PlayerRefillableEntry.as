package game.model.user.refillable
{
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.storage.refillable.RefillableDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerRefillableEntry
   {
       
      
      private const CLIENT_REFILL_DELAY:int = 1;
      
      protected var vipSource:PlayerRefillableVIPSource;
      
      protected var alarm:AlarmEvent;
      
      protected var _signal_update:Signal;
      
      protected var _signal_timedRefill:Signal;
      
      protected var _refillCount:int;
      
      protected var _desc:RefillableDescription;
      
      protected var _lastRefill:int;
      
      protected var _value:int;
      
      protected var _id:int;
      
      public function PlayerRefillableEntry(param1:Object, param2:RefillableDescription, param3:PlayerRefillableVIPSource)
      {
         _signal_update = new Signal();
         super();
         this.vipSource = param3;
         if(param1)
         {
            init(param1);
            _signal_timedRefill = new Signal(PlayerRefillableEntry);
         }
         this._desc = param2;
      }
      
      public function init(param1:*) : void
      {
         _id = param1.id;
         _value = param1.amount;
         _lastRefill = param1.lastRefill + 1;
         _refillCount = param1.boughtToday;
         if(_desc)
         {
            _signal_update.dispatch();
         }
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      function get signal_timedRefill() : Signal
      {
         return _signal_timedRefill;
      }
      
      public function get refillCount() : int
      {
         return _refillCount;
      }
      
      public function get maxValue() : int
      {
         if(vipSource.vip < desc.maxValue.length)
         {
            return desc.maxValue[vipSource.vip];
         }
         return desc.maxValue[desc.maxValue.length - 1];
      }
      
      public function get refillAmount() : int
      {
         if(desc.refillAmount)
         {
            return desc.refillAmount;
         }
         return maxValue;
      }
      
      public function get maxRefillCount() : int
      {
         if(!desc.maxRefillCount)
         {
            return -1;
         }
         if(desc.maxRefillCount.length > vipSource.vip)
         {
            return desc.maxRefillCount[vipSource.vip];
         }
         return desc.maxRefillCount[desc.maxRefillCount.length - 1];
      }
      
      public function get refillCost() : CostData
      {
         if(desc.refillCost.length > refillCount)
         {
            return desc.refillCost[refillCount];
         }
         return desc.refillCost[desc.refillCost.length - 1];
      }
      
      public function get desc() : RefillableDescription
      {
         return _desc;
      }
      
      public function get lastRefill() : int
      {
         return _lastRefill;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get canRefill() : Boolean
      {
         return refillCount < maxRefillCount || maxRefillCount == -1;
      }
      
      public function get refillTimeLeft() : int
      {
         return _lastRefill + desc.refillSeconds - GameTimer.instance.currentServerTime;
      }
      
      public function getVipLevelToRefill(param1:int = -1) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(desc.maxRefillCount)
         {
            if(param1 == -1)
            {
               param1 = refillCount;
            }
            _loc3_ = desc.maxRefillCount.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(desc.maxRefillCount[_loc2_] >= param1)
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      public function getVipLevelRefillCount(param1:int) : int
      {
         if(!desc.maxRefillCount)
         {
            return -1;
         }
         var _loc2_:int = desc.maxRefillCount.length;
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 > _loc2_)
         {
            return desc.maxRefillCount[_loc2_ - 1];
         }
         return desc.maxRefillCount[param1];
      }
      
      public function get nextVipLevel() : int
      {
         var _loc1_:int = getVipLevelToRefill(refillCount + 1);
         return _loc1_;
      }
      
      function setRefillCount(param1:int) : void
      {
         _refillCount = param1;
      }
      
      function spend(param1:int) : void
      {
         _value = _value - param1;
         _signal_update.dispatch();
      }
      
      function add(param1:int) : void
      {
         _value = _value + param1;
         _signal_update.dispatch();
      }
      
      function setLastRefill(param1:Number) : void
      {
         _lastRefill = param1 + 1;
      }
      
      function updateAlarm() : void
      {
         if(alarm)
         {
            GameTimer.instance.removeAlarm(alarm);
            alarm.callback = null;
         }
         if(desc.refillSeconds == 0)
         {
            return;
         }
         var _loc2_:int = GameTimer.instance.currentServerTime;
         var _loc1_:int = _lastRefill + desc.refillSeconds;
         if(_loc1_ > _loc2_ && _value < maxValue)
         {
            alarm = new AlarmEvent(_loc1_);
            alarm.callback = onAlarmCallback;
            GameTimer.instance.addAlarm(alarm);
         }
      }
      
      private function onAlarmCallback() : void
      {
         _signal_timedRefill.dispatch(this);
      }
   }
}
