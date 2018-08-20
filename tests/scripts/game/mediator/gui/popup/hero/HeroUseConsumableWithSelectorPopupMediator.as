package game.mediator.gui.popup.hero
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.rpc.hero.CommandHeroConsumableUseXP;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.component.ToggleGroupComponent;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.inventory.ToggleableInventoryItemValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.consumable.HeroUseConsumableWithSelectorPopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroUseConsumableWithSelectorPopupMediator extends PopupMediator
   {
       
      
      private var _preselectedHero:HeroDescription;
      
      private var _selectedConsumable:InventoryItemValueObject;
      
      private var _consumables:Vector.<ToggleableInventoryItemValueObject>;
      
      private var _heroes:Vector.<PlayerHeroListValueObject>;
      
      private var toggleGroup:ToggleGroupComponent;
      
      private const _property_hasConsumable:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      public const signal_itemAmountUpdate:Signal = new Signal();
      
      public var signal_consumeableChanged:Signal;
      
      public function HeroUseConsumableWithSelectorPopupMediator(param1:Player, param2:PlayerHeroEntry = null, param3:InventoryItem = null)
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         toggleGroup = new ToggleGroupComponent();
         signal_consumeableChanged = new Signal();
         super(param1);
         if(param2)
         {
            _preselectedHero = param2.hero;
         }
         var _loc6_:Vector.<ConsumableDescription> = DataStorage.consumable.getItemsByType("heroExperience");
         _consumables = new Vector.<ToggleableInventoryItemValueObject>();
         _loc6_.sort(sort_consumableByValue);
         var _loc9_:int = 0;
         var _loc8_:* = _loc6_;
         for each(var _loc7_ in _loc6_)
         {
            _loc4_ = param1.inventory.getItemCollection().getItem(_loc7_);
            if(!_loc4_)
            {
               _loc4_ = new InventoryItem(_loc7_,0);
            }
            _loc5_ = new ToggleableInventoryItemValueObject(param1,_loc4_);
            _loc5_.signal_amountUpdate.add(handler_someConsumableAmountUpdate);
            toggleGroup.addToggle(_loc5_.toggle);
            _consumables.push(_loc5_);
         }
         toggleGroup.signal_changed.add(handler_selectedConsumableChanged);
         if(param3)
         {
            trySelectConsumable(param3);
         }
         else
         {
            selectAvailableConsumable();
         }
         _heroes = createHeroesList();
      }
      
      override protected function dispose() : void
      {
         if(_selectedConsumable)
         {
            _selectedConsumable.signal_amountUpdate.remove(handler_selectedConsumableAmountUpdate);
         }
         GameModel.instance.actionManager.hero.heroConsumableUseXP_flush();
         super.dispose();
      }
      
      public function get property_hasConsumable() : BooleanProperty
      {
         return _property_hasConsumable;
      }
      
      public function get preselectedHero() : HeroDescription
      {
         return _preselectedHero;
      }
      
      public function get hasConsumable() : Boolean
      {
         return _selectedConsumable != null;
      }
      
      public function get consumables() : Vector.<ToggleableInventoryItemValueObject>
      {
         return _consumables;
      }
      
      public function get heroes() : Vector.<PlayerHeroListValueObject>
      {
         return _heroes;
      }
      
      public function get name() : String
      {
         return _selectedConsumable.item.name;
      }
      
      public function get amount() : int
      {
         return _selectedConsumable.ownedAmount;
      }
      
      public function get nameFontColorIndex() : uint
      {
         return _selectedConsumable.item.color.id - 1;
      }
      
      public function get maxLevel() : int
      {
         return player.levelData.level.maxHeroLevel;
      }
      
      override public function createPopup() : PopupBase
      {
         if(_selectedConsumable)
         {
            _popup = new HeroUseConsumableWithSelectorPopup(this);
            return _popup;
         }
         PopupList.instance.dialog_hero_add_exp_not_enough();
         dispose();
         return null;
      }
      
      public function action_useItem(param1:PlayerHeroListValueObject) : void
      {
         if(param1.exp < param1.maxExperience && _selectedConsumable.ownedAmount > 0)
         {
            Tutorial.events.triggerEvent_heroUseConsumable();
            GameModel.instance.actionManager.hero.heroConsumableUseXP_add(player,param1.playerEntry,_selectedConsumable.item as ConsumableDescription,1);
            if(_selectedConsumable.ownedAmount == 0)
            {
               selectAvailableConsumable();
            }
         }
      }
      
      public function action_oneLevel(param1:PlayerHeroListValueObject) : void
      {
         var _loc10_:* = 0;
         var _loc2_:Boolean = false;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         if(param1.exp >= param1.maxExperience)
         {
            return;
         }
         var _loc9_:PlayerHeroEntry = param1.playerEntry;
         Tutorial.events.triggerEvent_heroUseConsumable();
         var _loc11_:int = _loc9_.level.nextLevel.exp - _loc9_.experience;
         var _loc4_:Array = [];
         var _loc6_:int = _consumables.indexOf(_selectedConsumable as ToggleableInventoryItemValueObject);
         var _loc7_:int = _consumables.length;
         _loc10_ = _loc6_;
         while(_loc10_ < _loc7_)
         {
            _loc2_ = getPotionAmountsForExpDelta(_loc11_,_loc10_,_loc4_);
            if(!_loc2_)
            {
               _loc10_++;
               continue;
            }
            break;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            if(_loc4_[_loc8_] > 0)
            {
               _loc5_ = _consumables[_loc8_].item as ConsumableDescription;
               _loc3_ = _loc4_[_loc8_];
               GameModel.instance.actionManager.hero.heroConsumableUseXP_add(player,_loc9_,_loc5_,_loc3_);
            }
            _loc8_++;
         }
         if(_selectedConsumable.ownedAmount == 0)
         {
            selectAvailableConsumable();
         }
      }
      
      protected function getPotionAmountsForExpDelta(param1:int, param2:int, param3:Array) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function action_toMissions() : void
      {
         GameModel.instance.actionManager.hero.heroConsumableUseXP_flush();
         Game.instance.navigator.navigateToMechanic(MechanicStorage.MISSION,Stash.click("campaign",popup.stashParams));
      }
      
      public function action_toShop() : void
      {
         GameModel.instance.actionManager.hero.heroConsumableUseXP_flush();
         var _loc1_:ShopDescription = DataStorage.shop.getShopById(1);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,popup.stashParams));
      }
      
      protected function trySelectConsumable(param1:InventoryItem) : void
      {
         var _loc3_:InventoryItemDescription = param1.item;
         var _loc5_:int = 0;
         var _loc4_:* = _consumables;
         for each(var _loc2_ in _consumables)
         {
            if(_loc2_.item == _loc3_)
            {
               if(_loc2_.ownedAmount <= 0)
               {
                  selectAvailableConsumable();
               }
               else
               {
                  toggleGroup.selectValue(_loc2_);
                  _property_hasConsumable.value = true;
               }
               return;
            }
         }
      }
      
      protected function removeOvercap(param1:int, param2:int, param3:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ <= param1)
         {
            _loc4_ = param3[_loc5_];
            if(_loc4_ > 0)
            {
               _loc7_ = (_consumables[_loc5_].item as ConsumableDescription).rewardAmount;
               if(_loc7_ <= param2)
               {
                  _loc8_ = Math.floor(param2 / _loc7_);
                  _loc6_ = Math.min(_loc4_,_loc8_);
                  param3[_loc5_] = _loc4_ - _loc6_;
                  param2 = param2 - _loc6_ * _loc7_;
               }
            }
            _loc5_++;
         }
      }
      
      protected function selectAvailableConsumable() : void
      {
         var _loc1_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:* = _consumables;
         for each(var _loc2_ in _consumables)
         {
            if(_loc2_.ownedAmount > 0)
            {
               _loc1_ = true;
               toggleGroup.selectValue(_loc2_);
               break;
            }
         }
         _property_hasConsumable.value = _loc1_;
      }
      
      protected function createHeroesList() : Vector.<PlayerHeroListValueObject>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<PlayerHeroListValueObject> = new Vector.<PlayerHeroListValueObject>();
         var _loc3_:Vector.<PlayerHeroEntry> = player.heroes.getList();
         var _loc4_:int = _loc3_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_.push(new PlayerHeroListValueObject(_loc3_[_loc1_].hero,player));
            _loc1_++;
         }
         _loc2_.sort(_sortHeroes);
         return _loc2_;
      }
      
      private function _sortHeroes(param1:PlayerHeroListValueObject, param2:PlayerHeroListValueObject) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = player.levelData.level.maxHeroLevel;
         var _loc6_:* = param1.level >= _loc3_;
         var _loc5_:* = param2.level >= _loc3_;
         if(_loc6_ == _loc5_)
         {
            _loc4_ = param2.exp - param1.exp;
            if(_loc4_ == 0)
            {
               return param2.heroEntry.getSortPower() - param1.heroEntry.getSortPower();
            }
            if(_loc6_)
            {
               return -_loc4_;
            }
            return _loc4_;
         }
         return _loc6_ == true?1:-1;
      }
      
      private function sort_consumableByValue(param1:ConsumableDescription, param2:ConsumableDescription) : int
      {
         return param1.rewardAmount - param2.rewardAmount;
      }
      
      private function handler_selectedConsumableChanged() : void
      {
         if(_selectedConsumable)
         {
            _selectedConsumable.signal_amountUpdate.remove(handler_selectedConsumableAmountUpdate);
         }
         _selectedConsumable = toggleGroup.selection.data as InventoryItemValueObject;
         if(_selectedConsumable)
         {
            _selectedConsumable.signal_amountUpdate.add(handler_selectedConsumableAmountUpdate);
         }
         signal_consumeableChanged.dispatch();
      }
      
      private function handler_selectedConsumableAmountUpdate() : void
      {
         signal_itemAmountUpdate.dispatch();
      }
      
      private function handler_someConsumableAmountUpdate() : void
      {
         var _loc1_:Boolean = _property_hasConsumable.value;
         var _loc4_:int = 0;
         var _loc3_:* = _consumables;
         for each(var _loc2_ in _consumables)
         {
            if(_loc2_.ownedAmount > 0)
            {
               if(!_loc1_)
               {
                  _property_hasConsumable.value = true;
                  selectAvailableConsumable();
               }
               return;
            }
         }
         _property_hasConsumable.value = false;
      }
      
      private function onItemUsed(param1:CommandHeroConsumableUseXP) : void
      {
      }
   }
}
