package game.model.user.hero.watch
{
   import flash.utils.Dictionary;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.ArtifactLevel;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.refillable.PlayerRefillableEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTitanWatcher
   {
       
      
      var player:Player;
      
      private var _inited:Boolean;
      
      var dict:Dictionary;
      
      private var _invalidated:Boolean;
      
      private var _invalidatedTitan:Boolean;
      
      private var titanExpConsumables:Vector.<ConsumableDescription>;
      
      private var _signal_update:Signal;
      
      private var _hasAvailableTitanUpgrades:Boolean;
      
      public function PlayerTitanWatcher()
      {
         super();
         _signal_update = new Signal();
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get hasAvailableTitanUpgrades() : Boolean
      {
         return _hasAvailableTitanUpgrades;
      }
      
      public function initialize(param1:Player) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         this.player = param1;
         _inited = true;
         dict = new Dictionary();
         var _loc4_:Vector.<TitanDescription> = DataStorage.titan.getList();
         var _loc3_:int = _loc4_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc2_ = new PlayerTitanWatcherEntry(_loc5_);
            dict[_loc5_] = _loc2_;
            _loc6_++;
         }
         titanExpConsumables = DataStorage.consumable.getItemsByType("titanExperience");
         updateAvailableTitanUpgrades();
         param1.signal_spendCost.add(onPlayerSpendCost);
         param1.signal_takeReward.add(onPlayerTakeReward);
         param1.refillable.signal_update.add(onPlayerRefillableUpdate);
         GameTimer.instance.oneFrameTimer.add(invalidationCheck);
      }
      
      public function invalidate(param1:TitanDescription = null) : void
      {
         if(param1)
         {
            getTitanWatch(param1).invalidate();
            _invalidatedTitan = true;
         }
         else
         {
            _invalidated = true;
         }
      }
      
      public function getTitanWatch(param1:TitanDescription) : PlayerTitanWatcherEntry
      {
         return dict[param1];
      }
      
      public function getUpdatedTitanWatch(param1:TitanDescription) : PlayerTitanWatcherEntry
      {
         return updateWatch(param1);
      }
      
      private function onPlayerRefillableUpdate(param1:PlayerRefillableEntry) : void
      {
         if(param1 == player.refillable.skillpoints)
         {
            invalidate();
         }
      }
      
      private function onPlayerSpendCost(param1:CostData) : void
      {
         invalidate();
      }
      
      private function onPlayerTakeReward(param1:RewardData) : void
      {
         invalidate();
      }
      
      private function validate() : void
      {
         _invalidated = false;
         updateAvailableTitanUpgrades();
      }
      
      private function updateAvailableTitanUpgrades() : void
      {
         var _loc2_:* = null;
         if(!_inited)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = dict;
         for(var _loc3_ in dict)
         {
            _loc2_ = updateWatch(_loc3_);
            _loc1_ = _loc1_ || _loc2_.actionAvailable;
         }
         _hasAvailableTitanUpgrades = _loc1_;
         _signal_update.dispatch();
      }
      
      private function updateWatch(param1:TitanDescription) : PlayerTitanWatcherEntry
      {
         var _loc2_:PlayerTitanEntry = player.titans.getById(param1.id);
         var _loc3_:PlayerTitanWatcherEntry = dict[param1];
         if(_loc2_)
         {
            _loc3_.addPlayerEntry(_loc2_);
         }
         _loc3_.expIncreasable = checkExpIncreasable(_loc2_);
         _loc3_.evolvable = checkEvolvable(_loc2_);
         _loc3_.summonable = !_loc2_ && checkSummonable(param1);
         _loc3_.artifactUpgradeAvaliable = checkArtifactsUpgradeAvaliable(_loc2_);
         _loc3_.spiritArtifactUpgradeAvaliable = checkSpiritArtifactUpgradeAvaliable(_loc2_);
         _loc3_.validate();
         return _loc3_;
      }
      
      private function checkExpIncreasable(param1:PlayerTitanEntry) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc2_:int = Math.min(param1.levelMax.level,player.levelData.level.maxTitanLevel);
         var _loc5_:PlayerTeamLevel = player.levelData.level;
         while(_loc5_.nextLevel)
         {
            _loc5_ = _loc5_.nextLevel as PlayerTeamLevel;
         }
         if(_loc5_)
         {
            _loc2_ = Math.min(_loc2_,_loc5_.maxTitanLevel);
         }
         if(param1.level.level >= _loc2_)
         {
            return false;
         }
         var _loc6_:int = param1.level.nextLevel.exp - param1.experience;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = titanExpConsumables;
         for each(var _loc4_ in titanExpConsumables)
         {
            _loc3_ = _loc3_ + player.inventory.getItemCount(_loc4_) * _loc4_.rewardAmount;
            if(_loc3_ >= _loc6_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkEvolvable(param1:PlayerTitanEntry) : Boolean
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         if(param1.star.next)
         {
            _loc2_ = param1.star.next.star.evolveFragmentCost;
            if(player.inventory.getFragmentCount(param1.titan) >= _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkSummonable(param1:TitanDescription) : Boolean
      {
         var _loc2_:int = param1.startingStar.star.summonFragmentCost;
         if(player.inventory.getFragmentCount(param1) >= _loc2_)
         {
            if(player.unsafeCanSpendFast(param1.startingStar.star.evolveGoldCost))
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkArtifactsUpgradeAvaliable(param1:PlayerTitanEntry) : Boolean
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.artifacts.list.length)
         {
            if(checkArtifactUpgradeAvaliable(param1,param1.artifacts.list[_loc2_]))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function checkSpiritArtifactUpgradeAvaliable(param1:PlayerTitanEntry) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return checkArtifactUpgradeAvaliable(param1,param1.artifacts.spirit);
      }
      
      private function checkArtifactUpgradeAvaliable(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param2 && param2.desc.artifactTypeData.minHeroLevel <= param1.level.level)
         {
            _loc4_ = param2.nextEvolutionStar;
            if(_loc4_)
            {
               _loc3_ = new CostData();
               _loc3_.fragmentCollection.addItem(param2.desc,_loc4_.costFragmentsAmount);
               _loc3_.add(_loc4_.costBase);
               if(player.canSpend(_loc3_))
               {
                  return true;
               }
            }
            _loc5_ = param2.nextLevelData;
            if(_loc5_ && param2.awakened)
            {
               _loc3_ = new CostData();
               _loc3_.add(_loc5_.cost);
               if(player.canSpend(_loc3_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function invalidationCheck() : void
      {
         var _loc1_:* = null;
         if(_invalidated)
         {
            _invalidated = false;
            _invalidatedTitan = false;
            updateAvailableTitanUpgrades();
         }
         else if(_invalidatedTitan)
         {
            _invalidatedTitan = false;
            var _loc4_:int = 0;
            var _loc3_:* = dict;
            for(var _loc2_ in dict)
            {
               _loc1_ = updateWatch(_loc2_);
               if(_loc1_.invalidated)
               {
                  updateWatch(_loc2_);
               }
            }
         }
      }
      
      public function checkAvailableArtifactUpdates() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for each(var _loc1_ in dict)
         {
            if(_loc1_.artifactUpgradeAvaliable)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkAvailableSpiritArtifactUpdates() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for each(var _loc1_ in dict)
         {
            if(_loc1_.spiritArtifactUpgradeAvaliable)
            {
               return true;
            }
         }
         return false;
      }
   }
}
