package game.model.user.hero.watch
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.cost.CostData;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import org.osflash.signals.Signal;
   
   public class PlayerHeroWatcherEntry
   {
       
      
      var hero:HeroDescription;
      
      var playerEntry:PlayerHeroEntry;
      
      private var _inventorySlots:Vector.<int>;
      
      private var _summonable:Boolean;
      
      private var _evolvable:Boolean;
      
      private var _skillUpgradeAvailable:Boolean;
      
      private var _expIncreasable:Boolean;
      
      private var _skinUpgradeAvailable:Boolean;
      
      private var _promotable:Boolean;
      
      private var _inventorySlotActionAvailable:Boolean;
      
      private var _inventorySlotEquipAvailable:Boolean;
      
      private var _artifactUpgradeAvaliable:Boolean;
      
      private var _titanGiftLevelUpAvaliable:Boolean;
      
      private var _signal_updateActionAvailable:Signal;
      
      private var _signal_equipActionAvailable:Signal;
      
      private var _signal_updateInventorySlotActionAvailable:Signal;
      
      private var _signal_updateSkillsAvailable:Signal;
      
      private var _signal_updateSkinsAvailable:Signal;
      
      private var _signal_updateExpIncreasable:Signal;
      
      private var _signal_updatePromotableStatus:Signal;
      
      private var _signal_updateEvolvableStatus:Signal;
      
      private var _signal_updateTitanGiftLevelUpAvaliable:Signal;
      
      private var _signal_updateArtifactUpgradeAvaliable:Signal;
      
      var _property_canEnchantRune:BooleanPropertyWriteable;
      
      private var _invalidated:Boolean;
      
      private var _itemsNeeded:Vector.<GearItemDescription>;
      
      public function PlayerHeroWatcherEntry(param1:HeroDescription)
      {
         _property_canEnchantRune = new BooleanPropertyWriteable(false);
         _itemsNeeded = new Vector.<GearItemDescription>();
         super();
         this.hero = param1;
         _signal_updateActionAvailable = new Signal(PlayerHeroWatcherEntry);
         _signal_updateSkillsAvailable = new Signal(PlayerHeroWatcherEntry);
         _signal_updateSkinsAvailable = new Signal(PlayerHeroWatcherEntry);
         _signal_updateExpIncreasable = new Signal(PlayerHeroWatcherEntry);
         _signal_updatePromotableStatus = new Signal(PlayerHeroWatcherEntry);
         _signal_updateEvolvableStatus = new Signal(PlayerHeroWatcherEntry);
         _signal_updateInventorySlotActionAvailable = new Signal(PlayerHeroWatcherEntry);
         _signal_updateTitanGiftLevelUpAvaliable = new Signal(PlayerHeroWatcherEntry);
         _signal_updateArtifactUpgradeAvaliable = new Signal(PlayerHeroWatcherEntry);
      }
      
      public function get summonable() : Boolean
      {
         return _summonable;
      }
      
      public function set summonable(param1:Boolean) : void
      {
         if(_summonable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _summonable = param1;
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get evolvable() : Boolean
      {
         return _evolvable;
      }
      
      public function set evolvable(param1:Boolean) : void
      {
         if(_evolvable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _evolvable = param1;
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
         _signal_updateEvolvableStatus.dispatch(this);
      }
      
      public function get skillUpgradeAvailable() : Boolean
      {
         return _skillUpgradeAvailable;
      }
      
      public function set skillUpgradeAvailable(param1:Boolean) : void
      {
         if(_skillUpgradeAvailable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _skillUpgradeAvailable = param1;
         _signal_updateSkillsAvailable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get expIncreasable() : Boolean
      {
         return _expIncreasable;
      }
      
      public function set expIncreasable(param1:Boolean) : void
      {
         if(_expIncreasable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _expIncreasable = param1;
         _signal_updateExpIncreasable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get skinUpgradeAvailable() : Boolean
      {
         return _skinUpgradeAvailable;
      }
      
      public function set skinUpgradeAvailable(param1:Boolean) : void
      {
         if(_skinUpgradeAvailable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _skinUpgradeAvailable = param1;
         _signal_updateSkinsAvailable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get promotable() : Boolean
      {
         return _promotable;
      }
      
      public function set promotable(param1:Boolean) : void
      {
         if(_promotable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _promotable = param1;
         _signal_updatePromotableStatus.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get inventorySlotActionAvailable() : Boolean
      {
         return _inventorySlotActionAvailable;
      }
      
      public function set inventorySlotActionAvailable(param1:Boolean) : void
      {
         if(_inventorySlotActionAvailable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _inventorySlotActionAvailable = param1;
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get inventorySlotEquipAvailable() : Boolean
      {
         return _inventorySlotEquipAvailable;
      }
      
      public function set inventorySlotEquipAvailable(param1:Boolean) : void
      {
         if(_inventorySlotEquipAvailable == param1)
         {
            return;
         }
         _inventorySlotEquipAvailable = param1;
      }
      
      public function get artifactUpgradeAvaliable() : Boolean
      {
         return _artifactUpgradeAvaliable;
      }
      
      public function set artifactUpgradeAvaliable(param1:Boolean) : void
      {
         if(_artifactUpgradeAvaliable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _artifactUpgradeAvaliable = param1;
         _signal_updateArtifactUpgradeAvaliable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get titanGiftLevelUpAvaliable() : Boolean
      {
         return _titanGiftLevelUpAvaliable;
      }
      
      public function set titanGiftLevelUpAvaliable(param1:Boolean) : void
      {
         if(_titanGiftLevelUpAvaliable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _titanGiftLevelUpAvaliable = param1;
         _signal_updateTitanGiftLevelUpAvaliable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get actionAvailable() : Boolean
      {
         return _inventorySlotActionAvailable || _evolvable || _promotable || _skillUpgradeAvailable || _skinUpgradeAvailable || _expIncreasable || titanGiftLevelUpAvaliable || artifactUpgradeAvaliable;
      }
      
      public function get signal_updateActionAvailable() : Signal
      {
         return _signal_updateActionAvailable;
      }
      
      public function get signal_equipActionAvailable() : Signal
      {
         return _signal_equipActionAvailable;
      }
      
      public function get signal_updateInventorySlotActionAvailable() : Signal
      {
         return _signal_updateInventorySlotActionAvailable;
      }
      
      public function get signal_updateSkillsAvailable() : Signal
      {
         return _signal_updateSkillsAvailable;
      }
      
      public function get signal_updateSkinsAvailable() : Signal
      {
         return _signal_updateSkinsAvailable;
      }
      
      public function get signal_updateExpIncreasable() : Signal
      {
         return _signal_updateExpIncreasable;
      }
      
      public function get signal_updatePromotableStatus() : Signal
      {
         return _signal_updatePromotableStatus;
      }
      
      public function get signal_updateEvolvableStatus() : Signal
      {
         return _signal_updateEvolvableStatus;
      }
      
      public function get signal_updateTitanGiftLevelUpAvaliable() : Signal
      {
         return _signal_updateTitanGiftLevelUpAvaliable;
      }
      
      public function get signal_updateArtifactUpgradeAvaliable() : Signal
      {
         return _signal_updateArtifactUpgradeAvaliable;
      }
      
      public function get property_canEnchantRune() : BooleanProperty
      {
         return _property_canEnchantRune;
      }
      
      function get invalidated() : Boolean
      {
         return _invalidated;
      }
      
      public function get itemsNeeded() : Vector.<GearItemDescription>
      {
         return _itemsNeeded;
      }
      
      public function print() : void
      {
      }
      
      public function inventorySlotState(param1:int) : int
      {
         if(_inventorySlots)
         {
            return _inventorySlots[param1];
         }
         return 0;
      }
      
      function invalidate() : void
      {
         _invalidated = true;
      }
      
      function validate() : void
      {
         _invalidated = false;
      }
      
      function addPlayerEntry(param1:PlayerHeroEntry) : void
      {
         playerEntry = param1;
      }
      
      public function setInventorySlots(param1:Vector.<int>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(!_inventorySlots || _inventorySlots[_loc3_] != param1[_loc3_])
            {
               _loc6_ = true;
            }
            if(param1[_loc3_] == 1)
            {
               _loc4_ = true;
            }
            if(param1[_loc3_] == 4)
            {
               _loc5_ = true;
            }
            _loc3_++;
         }
         _inventorySlots = param1;
         inventorySlotActionAvailable = _loc4_ || _loc5_;
         inventorySlotEquipAvailable = _loc4_;
         if(_loc6_)
         {
            _signal_updateInventorySlotActionAvailable.dispatch(this);
         }
      }
      
      public function checkSlots(param1:PlayerHeroEntry, param2:Player) : void
      {
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc3_:Vector.<int> = new Vector.<int>();
         _itemsNeeded = new Vector.<GearItemDescription>();
         var _loc7_:Vector.<GearItemDescription> = param1.color.itemList;
         var _loc5_:int = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(!param1.isItemSlotBusy(_loc6_))
            {
               _loc8_ = _loc7_[_loc6_];
               _itemsNeeded.push(_loc8_);
               if(param2.inventory.getItemCount(_loc8_) > 0)
               {
                  if(_loc8_.heroLevel <= param1.level.level)
                  {
                     _loc3_.push(1);
                  }
                  else
                  {
                     _loc3_.push(5);
                  }
               }
               else
               {
                  _loc4_ = _loc8_.craftRecipe;
                  if(!_loc4_)
                  {
                     _loc4_ = _loc8_.fragmentMergeCost;
                  }
                  if(_loc4_ && !_loc4_.isEmpty && param2.unsafeCanSpendFast(_loc4_))
                  {
                     _loc3_.push(4);
                  }
                  else if(param2.missions.itemIsDropableRightNow(_loc8_))
                  {
                     _loc3_.push(3);
                  }
                  else if(_loc8_.obtainType != null)
                  {
                     _loc3_.push(3);
                  }
                  else
                  {
                     _loc3_.push(0);
                  }
               }
            }
            else
            {
               _loc3_.push(2);
            }
            _loc6_++;
         }
         setInventorySlots(_loc3_);
      }
   }
}
