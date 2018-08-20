package game.mechanics.boss.model
{
   import avmplus.getQualifiedClassName;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.mechanics.boss.storage.BossChestDescription;
   import game.mechanics.boss.storage.BossLevelDescription;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.model.GameModel;
   import idv.cjcat.signals.Signal;
   
   public class PlayerBossEntry
   {
       
      
      private var _level:BossLevelDescription;
      
      private var _type:BossTypeDescription;
      
      private const _chestsAreSkipped:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _chestsOpenedCount:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _chestCost:ObjectPropertyWriteable = new ObjectPropertyWriteable(CostData);
      
      private const _chestId:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _possibleReward:ObjectPropertyWriteable = new ObjectPropertyWriteable(BossPossibleRewardValueObject);
      
      private const _mayRaid:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _obtainedRewards:Vector.<RewardData> = new Vector.<RewardData>();
      
      public const signal_chestOpened:Signal = new Signal(CommandBossOpenChest);
      
      public function PlayerBossEntry(param1:Object = null)
      {
         super();
         if(param1)
         {
            update(param1);
         }
      }
      
      public function get level() : BossLevelDescription
      {
         return _level;
      }
      
      public function get type() : BossTypeDescription
      {
         return _type;
      }
      
      public function get chestsAreSkipped() : BooleanProperty
      {
         return _chestsAreSkipped;
      }
      
      public function get chestsOpenedCount() : IntProperty
      {
         return _chestsOpenedCount;
      }
      
      public function get chestCost() : ObjectProperty
      {
         return _chestCost;
      }
      
      public function get chestId() : IntProperty
      {
         return _chestId;
      }
      
      public function get possibleReward() : ObjectProperty
      {
         return _possibleReward;
      }
      
      public function get mayRaid() : BooleanProperty
      {
         return _mayRaid;
      }
      
      public function get obtainedRewards() : Vector.<RewardData>
      {
         return _obtainedRewards;
      }
      
      public function update(param1:Object) : void
      {
         _type = DataStorage.boss.getByType(param1.id);
         _level = _type.getBossEntry(param1.bossLevel);
         _mayRaid.value = param1.mayRaid;
         _chestId.value = param1.chestId;
         var _loc2_:int = _chestsOpenedCount.value;
         if(param1.chestNum >= 1)
         {
            _loc2_ = param1.chestNum - 1;
         }
         else
         {
            _loc2_ = 0;
         }
         _chestsOpenedCount.value = _loc2_;
         updatePossibleReward(param1.chests);
         updateCost(param1.cost);
         _obtainedRewards.length = _loc2_;
         if(param1.lastChestReward && !(param1.lastChestReward is Array) && _loc2_ > 0)
         {
            _obtainedRewards[_loc2_ - 1] = new RewardData(param1.lastChestReward);
         }
      }
      
      public function getChestReward(param1:int) : RewardData
      {
         if(param1 < 1 || param1 > _obtainedRewards.length)
         {
            return null;
         }
         return _obtainedRewards[param1 - 1];
      }
      
      public function openChest(param1:int) : void
      {
         var _loc2_:BossChestDescription = DataStorage.boss.getChestByNum(chestsOpenedCount.value + 1);
         if(_loc2_)
         {
            GameModel.instance.actionManager.boss.bossOpenChest(this,_loc2_,param1);
         }
         else
         {
            trace(getQualifiedClassName(this),"Все сундуки открыты, двигайся дальше");
         }
      }
      
      public function skipChests() : void
      {
         _chestsAreSkipped.value = true;
      }
      
      public function setupChestsState() : void
      {
         _chestsAreSkipped.value = false;
      }
      
      function handleOpenedChest(param1:CommandBossOpenChest) : void
      {
         signal_chestOpened.dispatch(param1);
      }
      
      private function updatePossibleReward(param1:Array) : void
      {
         var _loc2_:BossPossibleRewardValueObject = _possibleReward.value as BossPossibleRewardValueObject;
         if(_loc2_ == null || !_loc2_.isEqual(param1))
         {
            _possibleReward.value = new BossPossibleRewardValueObject(param1);
         }
      }
      
      private function updateCost(param1:Object) : void
      {
         if(param1)
         {
            if(_chestCost.value == null || _chestCost.value.starmoney != param1.starmoney)
            {
               _chestCost.value = new CostData(param1);
            }
         }
         else if(_chestCost.value != null)
         {
            _chestCost.value = null;
         }
      }
   }
}
