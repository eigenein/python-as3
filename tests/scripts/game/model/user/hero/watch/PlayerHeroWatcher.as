package game.model.user.hero.watch
{
   import flash.utils.Dictionary;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.ArtifactLevel;
   import game.data.storage.enum.lib.SkillTier;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.rune.RuneLevelDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   import game.data.storage.titan.TitanGiftDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroSkill;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerHeroWatcher
   {
       
      
      var player:Player;
      
      private var _inited:Boolean;
      
      private var _playerInventoryState:PlayerInventoryWatcherState;
      
      var dict:Dictionary;
      
      private var _invalidated:Boolean;
      
      private var _invalidatedHero:Boolean;
      
      private var heroExpConsumables:Vector.<ConsumableDescription>;
      
      private var _signal_update:Signal;
      
      private var _hasAvailableHeroUpgrades:Boolean;
      
      private var _inventory:PlayerHeroWatchInventory;
      
      public function PlayerHeroWatcher()
      {
         _playerInventoryState = new PlayerInventoryWatcherState();
         _inventory = new PlayerHeroWatchInventory(this);
         super();
         _signal_update = new Signal();
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get hasAvailableHeroUpgrades() : Boolean
      {
         return _hasAvailableHeroUpgrades;
      }
      
      public function get inventory() : PlayerHeroWatchInventory
      {
         return _inventory;
      }
      
      public function initialize(param1:Player) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         this.player = param1;
         _inited = true;
         dict = new Dictionary();
         var _loc3_:Vector.<HeroDescription> = DataStorage.hero.getHeroList();
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc2_ = new PlayerHeroWatcherEntry(_loc6_);
            dict[_loc6_] = _loc2_;
            _loc5_++;
         }
         heroExpConsumables = DataStorage.consumable.getItemsByType("heroExperience");
         updateAvailableHeroUpgrades();
         param1.signal_spendCost.add(onPlayerSpendCost);
         param1.signal_takeReward.add(onPlayerTakeReward);
         param1.refillable.signal_update.add(onPlayerRefillableUpdate);
         GameTimer.instance.oneFrameTimer.add(invalidationCheck);
      }
      
      public function invalidate(param1:HeroDescription = null) : void
      {
         if(param1)
         {
            getHeroWatch(param1).invalidate();
            _invalidatedHero = true;
         }
         else
         {
            _invalidated = true;
         }
      }
      
      public function getHeroWatch(param1:HeroDescription) : PlayerHeroWatcherEntry
      {
         return dict[param1];
      }
      
      public function getUpdatedHeroWatch(param1:HeroDescription) : PlayerHeroWatcherEntry
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
         _playerInventoryState.invalidate();
         invalidate();
      }
      
      private function onPlayerTakeReward(param1:RewardData) : void
      {
         _playerInventoryState.invalidate();
         invalidate();
      }
      
      private function validate() : void
      {
         _invalidated = false;
         updateAvailableHeroUpgrades();
      }
      
      private function updateAvailableHeroUpgrades() : void
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
         _hasAvailableHeroUpgrades = _loc1_;
         _signal_update.dispatch();
         _inventory.validate();
      }
      
      private function updateWatch(param1:HeroDescription) : PlayerHeroWatcherEntry
      {
         var _loc2_:PlayerHeroEntry = player.heroes.getById(param1.id);
         var _loc3_:PlayerHeroWatcherEntry = dict[param1];
         _playerInventoryState.validate(player);
         if(_loc2_)
         {
            _loc3_.addPlayerEntry(_loc2_);
            _loc3_.checkSlots(_loc2_,player);
         }
         _loc3_.promotable = checkPromotable(_loc2_);
         _loc3_.skillUpgradeAvailable = checkUpgradableSkills(_loc2_);
         _loc3_.skinUpgradeAvailable = checkUpgradableSkins(_loc2_);
         _loc3_.expIncreasable = checkExpIncreasable(_loc2_);
         _loc3_._property_canEnchantRune.value = checkRuneEnchantable(_loc2_);
         _loc3_.titanGiftLevelUpAvaliable = checkTitanGiftLevelUp(_loc2_);
         _loc3_.artifactUpgradeAvaliable = checkArtifactUpgradeAvaliable(_loc2_);
         _loc3_.evolvable = checkEvolvable(_loc2_);
         _loc3_.summonable = !_loc2_ && checkSummonable(param1);
         _loc3_.validate();
         return _loc3_;
      }
      
      private function checkSeekableSlots(param1:PlayerHeroEntry) : Vector.<int>
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Vector.<int> = new Vector.<int>();
         if(!param1)
         {
            return _loc2_;
         }
         var _loc6_:Vector.<GearItemDescription> = param1.color.itemList;
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(!param1.isItemSlotBusy(_loc5_))
            {
               if(_loc6_[_loc5_].heroLevel <= param1.level.level)
               {
                  _loc3_ = _loc6_[_loc5_].craftRecipe;
                  if(!_loc3_)
                  {
                     _loc3_ = _loc6_[_loc5_].fragmentMergeCost;
                  }
                  if(_loc3_ && !_loc3_.isEmpty && player.unsafeCanSpendFast(_loc3_))
                  {
                     _loc2_.push(_loc5_);
                  }
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function checkCraftableSlots(param1:PlayerHeroEntry) : Vector.<int>
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Vector.<int> = new Vector.<int>();
         if(!param1)
         {
            return _loc2_;
         }
         var _loc6_:Vector.<GearItemDescription> = param1.color.itemList;
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(!param1.isItemSlotBusy(_loc5_))
            {
               if(_loc6_[_loc5_].heroLevel <= param1.level.level)
               {
                  _loc3_ = _loc6_[_loc5_].craftRecipe;
                  if(!_loc3_)
                  {
                     _loc3_ = _loc6_[_loc5_].fragmentMergeCost;
                  }
                  if(_loc3_ && !_loc3_.isEmpty && player.unsafeCanSpendFast(_loc3_))
                  {
                     _loc2_.push(_loc5_);
                  }
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function checkUpgradableSkills(param1:PlayerHeroEntry) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         if(player.levelData.level.level < MechanicStorage.SKILLS.teamLevel)
         {
            return false;
         }
         if(!param1)
         {
            return false;
         }
         if(player.refillable.skillpoints.value > 0)
         {
            _loc2_ = param1.skillData.getSkillList();
            _loc4_ = _loc2_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               if(param1.canUpgradeSkill(_loc2_[_loc6_].skill))
               {
                  _loc5_ = DataStorage.enum.getbyId_SkillTier(_loc2_[_loc6_].skill.tier);
                  if(!_loc2_[_loc6_].skill.tier)
                  {
                     return true;
                  }
                  _loc3_ = DataStorage.level.getSkillLevelCost(param1.skillData.getLevelByTier(_loc5_.id).level,_loc5_.id);
                  if(player.unsafeCanSpendFast(_loc3_))
                  {
                     return true;
                  }
               }
               _loc6_++;
            }
         }
         return false;
      }
      
      private function checkUpgradableSkins(param1:PlayerHeroEntry) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         var _loc5_:* = null;
         if(!param1)
         {
            return false;
         }
         var _loc2_:Vector.<SkinDescription> = DataStorage.skin.getSkinsByHeroId(param1.hero.id);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_ && _loc3_.enabled)
            {
               _loc6_ = uint(param1.skinData.getSkinLevelByID(_loc3_.id));
               if(_loc6_ < _loc3_.levels.length)
               {
                  _loc5_ = _loc3_.levels[_loc6_];
                  if(player.unsafeCanSpendFast(_loc5_.cost))
                  {
                     return true;
                  }
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      private function checkExpIncreasable(param1:PlayerHeroEntry) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc4_:PlayerTeamLevel = player.levelData.level;
         if(_loc4_.level > DataStorage.rule.showHeroExpIncreasableMarkerUpToTeamLevel)
         {
            return false;
         }
         if(param1.level.level >= _loc4_.maxHeroLevel)
         {
            return false;
         }
         var _loc5_:int = param1.level.nextLevel.exp - param1.experience;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = heroExpConsumables;
         for each(var _loc3_ in heroExpConsumables)
         {
            _loc2_ = _loc2_ + player.inventory.getItemCount(_loc3_) * _loc3_.rewardAmount;
            if(_loc2_ >= _loc5_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkFillableSlots(param1:PlayerHeroEntry) : Vector.<int>
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Vector.<int> = new Vector.<int>();
         if(!param1)
         {
            return _loc2_;
         }
         var _loc6_:Vector.<GearItemDescription> = param1.color.itemList;
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(!param1.isItemSlotBusy(_loc5_))
            {
               _loc3_ = new CostData();
               _loc3_.addInventoryItem(_loc6_[_loc5_],1);
               if(player.unsafeCanSpendFast(_loc3_))
               {
                  if(_loc6_[_loc5_].heroLevel <= param1.level.level)
                  {
                     _loc2_.push(_loc5_);
                  }
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function checkUnFillableByLevelSlots(param1:PlayerHeroEntry) : Vector.<int>
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Vector.<int> = new Vector.<int>();
         if(!param1)
         {
            return _loc2_;
         }
         var _loc6_:Vector.<GearItemDescription> = param1.color.itemList;
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(!param1.isItemSlotBusy(_loc5_))
            {
               _loc3_ = new CostData();
               _loc3_.addInventoryItem(_loc6_[_loc5_],1);
               if(player.unsafeCanSpendFast(_loc3_))
               {
                  if(_loc6_[_loc5_].heroLevel > param1.level.level)
                  {
                     _loc2_.push(_loc5_);
                  }
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function checkPromotable(param1:PlayerHeroEntry) : Boolean
      {
         var _loc4_:int = 0;
         if(!param1)
         {
            return false;
         }
         var _loc5_:Vector.<GearItemDescription> = param1.color.itemList;
         var _loc3_:int = _loc5_.length;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.isItemSlotBusy(_loc4_))
            {
               _loc2_++;
            }
            _loc4_++;
         }
         return param1.color.next && _loc2_ == _loc3_;
      }
      
      private function checkEvolvable(param1:PlayerHeroEntry) : Boolean
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         if(param1.star.next)
         {
            _loc2_ = param1.star.next.star.evolveFragmentCost;
            if(player.inventory.getFragmentCount(param1.hero) >= _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkSummonable(param1:HeroDescription) : Boolean
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
      
      private function invalidationCheck() : void
      {
         var _loc1_:* = null;
         if(_invalidated)
         {
            _invalidated = false;
            _invalidatedHero = false;
            updateAvailableHeroUpgrades();
         }
         else if(_invalidatedHero)
         {
            _invalidatedHero = false;
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
      
      private function checkRuneEnchantable(param1:PlayerHeroEntry) : Boolean
      {
         var _loc11_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:* = 0;
         if(!param1)
         {
            return false;
         }
         var _loc13_:int = param1.level.level;
         var _loc5_:int = param1.color.color.id;
         _loc11_ = 0;
         while(_loc11_ < 5)
         {
            _loc4_ = param1.runes.getRuneLevel(_loc11_);
            _loc2_ = DataStorage.rune.getMaxLevelByHeroLevel(_loc13_);
            if(_loc4_ < _loc2_ && _loc5_ >= DataStorage.rune.getTier(_loc11_).color.id)
            {
               _loc10_ = DataStorage.rune.getLevel(_loc4_);
               _loc7_ = DataStorage.rune.getLevel(_loc4_ + 1);
               _loc9_ = _loc7_.enchantValue - param1.runes.getRuneEnchantment(_loc11_);
               _loc12_ = _loc9_ * _loc10_.goldPerEnchantPoint;
               _loc6_ = player.gold;
               if(_loc6_ >= _loc12_ && _playerInventoryState.runeEnchantPointsAvailable >= _loc9_)
               {
                  _loc8_ = getMinPointsOvercapForExpDelta(_loc9_);
                  while(_loc8_ > 0)
                  {
                     _loc10_ = _loc7_;
                     _loc7_ = _loc7_.nextLevel;
                     if(_loc7_ != null)
                     {
                        if(_loc8_ > _loc7_.enchantValue - _loc10_.enchantValue)
                        {
                           _loc3_ = int(_loc7_.enchantValue - _loc10_.enchantValue);
                           _loc8_ = _loc8_ - _loc3_;
                        }
                        else
                        {
                           _loc3_ = _loc8_;
                           _loc8_ = 0;
                        }
                     }
                     else
                     {
                        _loc3_ = 0;
                        _loc8_ = 0;
                     }
                     _loc12_ = _loc12_ + _loc3_ * _loc10_.goldPerEnchantPoint;
                  }
                  if(_loc6_ >= _loc12_)
                  {
                     return true;
                  }
               }
            }
            _loc11_++;
         }
         return false;
      }
      
      protected function getMinPointsOvercapForExpDelta(param1:int) : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function removeOvercap(param1:int, param2:Array) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Vector.<InventoryItem> = _playerInventoryState.runeEnchantConsumables;
         var _loc8_:int = _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ <= _loc8_)
         {
            _loc3_ = param2[_loc5_];
            if(_loc3_ > 0)
            {
               _loc7_ = (_loc4_[_loc5_].item as ConsumableDescription).rewardAmount;
               if(_loc7_ <= param1)
               {
                  _loc9_ = Math.floor(param1 / _loc7_);
                  _loc6_ = Math.min(_loc3_,_loc9_);
                  param2[_loc5_] = _loc3_ - _loc6_;
                  param1 = param1 - _loc6_ * _loc7_;
               }
            }
            _loc5_++;
         }
         return param1;
      }
      
      private function checkTitanGiftLevelUp(param1:PlayerHeroEntry) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.titanGiftLevel == DataStorage.titanGift.maxGiftLevel)
         {
            return false;
         }
         var _loc2_:TitanGiftDescription = DataStorage.titanGift.getTitanGiftByLevel(param1.titanGiftLevel + 1);
         if(_loc2_)
         {
            return player.canSpend(_loc2_.cost);
         }
         return false;
      }
      
      private function checkArtifactUpgradeAvaliable(param1:PlayerHeroEntry) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         if(!param1)
         {
            return false;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.artifacts.list.length)
         {
            _loc2_ = param1.artifacts.list[_loc5_];
            if(_loc2_ && _loc2_.desc.artifactTypeData.minHeroLevel <= param1.level.level)
            {
               _loc4_ = _loc2_.nextEvolutionStar;
               if(_loc4_)
               {
                  _loc3_ = new CostData();
                  _loc3_.fragmentCollection.addItem(_loc2_.desc,_loc4_.costFragmentsAmount);
                  _loc3_.add(_loc4_.costBase);
                  if(player.canSpend(_loc3_))
                  {
                     return true;
                  }
               }
               _loc6_ = _loc2_.nextLevelData;
               if(_loc6_ && _loc2_.awakened)
               {
                  _loc3_ = new CostData();
                  _loc3_.add(_loc6_.cost);
                  if(player.canSpend(_loc3_))
                  {
                     return true;
                  }
               }
            }
            _loc5_++;
         }
         return false;
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
   }
}
