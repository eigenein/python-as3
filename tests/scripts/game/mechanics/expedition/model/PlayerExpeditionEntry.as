package game.mechanics.expedition.model
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.data.reward.RewardData;
   import game.model.user.specialoffer.PlayerDeferredEvent;
   import game.util.Duration;
   
   public class PlayerExpeditionEntry
   {
      
      public static const NULL:PlayerExpeditionEntry = new PlayerExpeditionEntry({});
      
      public static const STATUS_LOCKED:int = 0;
      
      public static const STATUS_NEW:int = 1;
      
      public static const STATUS_RUNNING:int = 2;
      
      public static const STATUS_FARMED:int = 3;
       
      
      private var _id:int;
      
      private var _slotId:int;
      
      private var _status:IntPropertyWriteable;
      
      private var _duration:Duration;
      
      private var _endTime:PlayerDeferredEvent;
      
      private var _heroes:Vector.<int>;
      
      private var _rarity:int;
      
      private var _power:Number;
      
      private var _reward:RewardData;
      
      private var _day:String;
      
      private var _storyId:int;
      
      private var _readyToFarm:BooleanPropertyWriteable;
      
      private var _heroesAreLocked:BooleanPropertyWriteable;
      
      public function PlayerExpeditionEntry(param1:Object)
      {
         _status = new IntPropertyWriteable();
         _readyToFarm = new BooleanPropertyWriteable();
         _heroesAreLocked = new BooleanPropertyWriteable();
         super();
         _id = param1.id;
         _slotId = param1.slotId;
         _status.value = param1.status;
         _duration = new Duration(param1.duration);
         if(param1.endTime)
         {
            setEndTime(param1.endTime);
         }
         _heroes = !!param1.heroes?Vector.<int>(param1.heroes):new Vector.<int>();
         _rarity = param1.rarity;
         _power = param1.power;
         _reward = new RewardData(param1.reward);
         _day = param1.day;
         _storyId = param1.storyId;
      }
      
      public static function sort_bySlotId(param1:PlayerExpeditionEntry, param2:PlayerExpeditionEntry) : int
      {
         var _loc3_:int = param1._slotId - param2._slotId;
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         return param1.id - param2.id;
      }
      
      public function dispose() : void
      {
         _status.signal_update.clear();
      }
      
      public function get storyId() : int
      {
         return _storyId;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get slotId() : int
      {
         return _slotId;
      }
      
      public function get duration() : Duration
      {
         return _duration;
      }
      
      public function get endTime() : PlayerDeferredEvent
      {
         return _endTime;
      }
      
      public function get heroes() : Vector.<int>
      {
         return _heroes;
      }
      
      public function get rarity() : int
      {
         return _rarity;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get day() : String
      {
         return _day;
      }
      
      public function get isNull() : Boolean
      {
         return this == PlayerExpeditionEntry.NULL;
      }
      
      public function get isNew() : Boolean
      {
         return _status.value == 1 || _status.value == 0;
      }
      
      public function get isInProgress() : Boolean
      {
         return _status.value == 2 && !_readyToFarm.value;
      }
      
      public function get isFarmed() : Boolean
      {
         return _status.value == 3;
      }
      
      public function get isReadyToFarm() : Boolean
      {
         return _status.value == 2 && _readyToFarm.value;
      }
      
      public function get heroesAreLocked() : BooleanProperty
      {
         return _heroesAreLocked;
      }
      
      public function get readyToFarm() : BooleanProperty
      {
         return _readyToFarm;
      }
      
      public function get status() : IntProperty
      {
         return _status;
      }
      
      function setInProgress(param1:int, param2:Vector.<int>) : void
      {
         setEndTime(param1);
         _heroes = param2.concat();
         _status.value = 2;
         updateHeroesAreLocked();
      }
      
      function setReadyToFarm() : void
      {
         _readyToFarm.value = true;
         updateHeroesAreLocked();
      }
      
      function setFarmed() : void
      {
         _status.value = 3;
         if(_endTime)
         {
            _endTime.cancel();
         }
      }
      
      function locksHero(param1:int) : Boolean
      {
         return _heroes != null && _heroesAreLocked.value && _heroes.indexOf(param1) != -1;
      }
      
      protected function setEndTime(param1:int) : void
      {
         if(_endTime == null)
         {
            _endTime = new PlayerDeferredEvent();
            _endTime.signal_complete.add(handler_complete);
         }
         _endTime.setEndTime(param1);
         _readyToFarm.value = _endTime.hasPassed;
         updateHeroesAreLocked();
      }
      
      protected function updateHeroesAreLocked() : void
      {
         _heroesAreLocked.value = _status.value == 2 && !_readyToFarm.value;
      }
      
      private function handler_complete() : void
      {
         setReadyToFarm();
      }
   }
}
