package game.mediator.gui.popup.inventory
{
   import feathers.core.PopUpManager;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.command.intern.OpenTitanPopupCommand;
   import game.command.rpc.inventory.CommandConsumableUseLootBox;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.ConsumableEffectDescriptionLootBox;
   import game.data.storage.resource.ScrollItemDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.inventory.PlayerInventoryPopup;
   import game.view.popup.reward.multi.MultiRewardGroupedPopup;
   import idv.cjcat.signals.Signal;
   
   public class PlayerInventoryPopupMediator extends PopupMediator
   {
       
      
      private const TAB_ALL:String = "all";
      
      private const TAB_FRAGMENTS:String = "fragments";
      
      private const TAB_HERO_FRAGMENTS:String = "hero_fragments";
      
      private var _tabs:Vector.<String>;
      
      private var _currentFilter:String;
      
      private var _items:Vector.<InventoryItem>;
      
      private var _signal_updateItems:Signal;
      
      private var _signal_updateSelectedItem:Signal;
      
      private var _selectedItem:InventoryItem;
      
      public function PlayerInventoryPopupMediator(param1:Player)
      {
         var _loc3_:int = 0;
         super(param1);
         _signal_updateItems = new Signal();
         _signal_updateSelectedItem = new Signal();
         param1.inventory.signal_update.add(inventoryUpdateHandler);
         var _loc2_:int = InventoryItemType.TYPE_LIST.length;
         _tabs = new Vector.<String>();
         _tabs.push("all");
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(InventoryItemType.TYPE_LIST[_loc3_] != InventoryItemType.ARTIFACT && InventoryItemType.TYPE_LIST[_loc3_] != InventoryItemType.TITAN_ARTIFACT)
            {
               _tabs.push(InventoryItemType.TYPE_LIST[_loc3_].type);
            }
            _loc3_++;
         }
         _tabs.push("fragments");
         _tabs.push("hero_fragments");
         _currentFilter = "all";
         filterItems();
      }
      
      public function get signal_updateItems() : Signal
      {
         return _signal_updateItems;
      }
      
      public function get signal_updateSelectedItem() : Signal
      {
         return _signal_updateSelectedItem;
      }
      
      public function get selectedItem() : InventoryItem
      {
         return _selectedItem;
      }
      
      public function get selectedItemStats() : Vector.<BattleStatValueObject>
      {
         var _loc1_:GearItemDescription = _selectedItem.item as GearItemDescription;
         if(_loc1_ && !(_selectedItem is InventoryFragmentItem))
         {
            return BattleStatValueObjectProvider.fromBattleStats(_loc1_.battleStatData);
         }
         return null;
      }
      
      public function get selectedItemCanBeUsed() : Boolean
      {
         if(!_selectedItem)
         {
            return false;
         }
         var _loc1_:ConsumableDescription = _selectedItem.item as ConsumableDescription;
         var _loc2_:Boolean = _loc1_ && player.clan && (_loc1_.rewardType == "enchantValue" || _loc1_.rewardType == "titanExperience" || _loc1_.rewardType == "titanGift" || _loc1_.rewardType == "artifactChestKey" || _loc1_.rewardType == "artifactEvolution" || _loc1_.rewardType == "artifactExperience");
         return _loc1_ && (_loc1_.rewardType == "heroExperience" || _loc1_.rewardType == "lootBox" || _loc1_.rewardType == "stamina" || _loc2_);
      }
      
      public function get selectedItemCanBeSold() : Boolean
      {
         if(!_selectedItem)
         {
            return false;
         }
         if(_selectedItem.item is HeroDescription && !Tutorial.flags.canSellHeroFragments)
         {
            return false;
         }
         return _selectedItem.sellCost.gold > 0 || _selectedItem.sellCost.outputDisplayFirst && _selectedItem.sellCost.outputDisplayFirst.item is CoinDescription;
      }
      
      public function get selectedItemHasInfo() : Boolean
      {
         return _selectedItem && _selectedItem.item.type != InventoryItemType.PSEUDO && _selectedItem.item.type != InventoryItemType.CONSUMABLE && _selectedItem.item.type != InventoryItemType.COIN;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_gold(true);
         return _loc1_;
      }
      
      public function get items() : Vector.<InventoryItem>
      {
         return _items;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new PlayerInventoryPopup(this);
         return _popup;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function action_selectTab(param1:int) : void
      {
         if(_currentFilter != tabs[param1])
         {
            _currentFilter = tabs[param1];
            filterItems();
            _signal_updateItems.dispatch();
         }
      }
      
      public function action_selectItem(param1:InventoryItem) : void
      {
         _selectedItem = param1;
         signal_updateSelectedItem.dispatch();
      }
      
      public function action_sellItem(param1:InventoryItem = null) : void
      {
         if(!param1)
         {
            param1 = _selectedItem;
         }
         if(!param1)
         {
            return;
         }
         var _loc2_:SellItemPopupMediator = new SellItemPopupMediator(player,param1);
         PopUpManager.addPopUp(_loc2_.createPopup());
      }
      
      private function _addItem(param1:InventoryItem, param2:Vector.<InventoryItem>) : Boolean
      {
         if(param1 && param1.item && !param1.item.hidden)
         {
            param2.push(param1);
            return true;
         }
         return false;
      }
      
      private function filterItems() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc4_ = null;
         _loc1_ = 0;
         _loc2_ = 0;
         var _loc3_:int = 0;
         _items = new Vector.<InventoryItem>();
         var _loc7_:int = 0;
         var _loc6_:* = InventoryItemType.TYPE_LIST;
         for each(var _loc5_ in InventoryItemType.TYPE_LIST)
         {
            if(_currentFilter == "all" || _currentFilter == _loc5_.type)
            {
               _loc4_ = player.inventory.getItemCollection().getCollectionByType(_loc5_).getArray();
               _loc1_ = _loc4_.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _addItem(_loc4_[_loc2_],_items);
                  _loc2_++;
               }
               continue;
            }
         }
         if(_currentFilter == "fragments" || _currentFilter == "all")
         {
            var _loc9_:int = 0;
            var _loc8_:* = InventoryItemType.FRAGMENT_TYPE_LIST;
            for each(_loc5_ in InventoryItemType.FRAGMENT_TYPE_LIST)
            {
               if(!(_loc5_ == InventoryItemType.HERO || _loc5_ == InventoryItemType.TITAN))
               {
                  _loc4_ = player.inventory.getFragmentCollection().getCollectionByType(_loc5_).getArray();
                  _loc1_ = _loc4_.length;
                  _loc2_ = 0;
                  while(_loc2_ < _loc1_)
                  {
                     _addItem(_loc4_[_loc2_],_items);
                     _loc2_++;
                  }
                  continue;
               }
            }
         }
         if(_currentFilter == "hero_fragments" || _currentFilter == "all")
         {
            _loc4_ = player.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.HERO).getArray();
            _loc1_ = _loc4_.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _addItem(_loc4_[_loc2_],_items);
               _loc2_++;
            }
            _loc4_ = player.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.TITAN).getArray();
            _loc1_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _addItem(_loc4_[_loc3_],_items);
               _loc3_++;
            }
         }
         _items.sort(__sortItems);
         if(_items.length)
         {
            _selectedItem = _items[0];
            _signal_updateSelectedItem.dispatch();
         }
      }
      
      override public function close() : void
      {
         player.inventory.signal_update.remove(inventoryUpdateHandler);
         super.close();
      }
      
      public function action_useItem(param1:InventoryItem = null) : void
      {
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         if(!param1)
         {
            param1 = _selectedItem;
         }
         if(param1.item.type == InventoryItemType.CONSUMABLE)
         {
            _loc3_ = param1.item as ConsumableDescription;
            if(_loc3_.rewardType == "enchantValue")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.ENCHANT,Stash.click("inventory_use_item",_popup.stashParams));
               return;
            }
            if(_loc3_.rewardType == "stamina")
            {
               _loc8_ = new UseStaminaItemPopUpMediator(player,param1);
               PopUpManager.addPopUp(_loc8_.createPopup());
               return;
            }
            if(_loc3_.rewardType == "heroExperience")
            {
               PopupList.instance.dialog_hero_add_exp(null,param1);
               return;
            }
            if(_loc3_.rewardType == "lootBox")
            {
               _loc9_ = _loc3_.effectDescription as ConsumableEffectDescriptionLootBox;
               if(_loc9_ && _loc9_.playerChoice)
               {
                  _loc10_ = new LootBoxBulkUsePopupMediator(player,param1);
                  PopUpManager.addPopUp(_loc10_.createPopup());
               }
               else
               {
                  _loc2_ = param1.amount;
                  _loc6_ = GameModel.instance.actionManager.inventory.consumableUseLootBox(_loc3_,_loc2_);
                  _loc6_.signal_complete.addOnce(handler_lootBoxOpened);
               }
               return;
            }
            if(_loc3_.rewardType == "titanExperience")
            {
               Game.instance.navigator.navigateToTitans(Stash.click("inventory_use_item",_popup.stashParams));
               return;
            }
            if(_loc3_.rewardType == "titanGift")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_GIFT,Stash.click("inventory_use_item",_popup.stashParams));
               return;
            }
            if(_loc3_.rewardType == "artifactChestKey")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT_CHEST,Stash.click("chest",_popup.stashParams));
               return;
            }
            if(_loc3_.rewardType == "artifactEvolution")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT,Stash.click("artifacts",_popup.stashParams));
               return;
            }
            if(_loc3_.rewardType == "artifactExperience")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT,Stash.click("artifacts",_popup.stashParams));
               return;
            }
         }
         if(param1.item is TitanDescription)
         {
            _loc4_ = new OpenTitanPopupCommand(player,param1.item as TitanDescription,Stash.click("item_info",_popup.stashParams));
            _loc4_.execute();
         }
         else if(param1.item is HeroDescription)
         {
            _loc5_ = new OpenHeroPopUpCommand(player,param1.item as HeroDescription,Stash.click("item_info",_popup.stashParams));
            _loc5_.execute();
         }
         else if(param1.item is SkinDescription)
         {
            PopupList.instance.dialog_skin_info(param1.item.id);
         }
         else if(param1.item is ArtifactDescription)
         {
            PopupList.instance.popup_item_info(param1.item,null,Stash.click("item_info",_popup.stashParams));
         }
         else if(param1.item is TitanArtifactDescription)
         {
            PopupList.instance.popup_item_info(param1.item,null,Stash.click("item_info",_popup.stashParams));
         }
         else
         {
            _loc7_ = new ItemInfoPopupMediator(player,param1.item);
            _loc7_.open(Stash.click("item_info",_popup.stashParams));
         }
      }
      
      public function getTabHasNotificationByID(param1:String) : Boolean
      {
         if(param1 == InventoryItemType.CONSUMABLE.type)
         {
            return player.inventory.hasNotificationsByItemType(InventoryItemType.CONSUMABLE);
         }
         return false;
      }
      
      private function __sortItems(param1:InventoryItem, param2:InventoryItem) : int
      {
         return __getSortValue(param1) - __getSortValue(param2);
      }
      
      private function __getSortValue(param1:InventoryItem) : int
      {
         var _loc2_:int = _tabs.indexOf(param1.item.type.type) * 10000000;
         if(param1.item is HeroDescription)
         {
            _loc2_ = _tabs.indexOf("hero_fragments") * 20000000;
         }
         if(param1.item is TitanDescription)
         {
            _loc2_ = _tabs.indexOf("hero_fragments") * 10000000;
         }
         if(param1 is InventoryFragmentItem && !(param1.item is UnitDescription))
         {
            _loc2_ = _tabs.indexOf("fragments") * 10000000;
            if(param1.item is TitanArtifactDescription)
            {
               _loc2_ = _loc2_ + 5000000;
            }
         }
         if(param1.item is ConsumableDescription)
         {
            if(!((param1.item as ConsumableDescription).effectDescription is ConsumableEffectDescriptionLootBox))
            {
               _loc2_ = _loc2_ + 10000;
            }
         }
         if(param1.item is ScrollItemDescription)
         {
            _loc2_ = _loc2_ + (param1.item as ScrollItemDescription).gear.heroLevel * 10000;
         }
         else if(param1.item is GearItemDescription)
         {
            _loc2_ = _loc2_ + (param1.item as GearItemDescription).heroLevel * 10000;
         }
         _loc2_ = _loc2_ + param1.item.id;
         return _loc2_;
      }
      
      private function inventoryUpdateHandler(param1:Inventory, param2:InventoryItem) : void
      {
         if(_currentFilter == "all" || _currentFilter == param2.item.type.type || (_currentFilter == "fragments" || _currentFilter == "hero_fragments") && param2 is InventoryFragmentItem)
         {
            filterItems();
            _signal_updateItems.dispatch();
         }
      }
      
      private function handler_lootBoxOpened(param1:CommandConsumableUseLootBox) : void
      {
         var _loc2_:MultiRewardGroupedPopup = new MultiRewardGroupedPopup(param1.lootBoxRewardValueObjectList,null);
         PopUpManager.addPopUp(_loc2_);
      }
      
      public function handler_selectedItemClick() : void
      {
         if(selectedItem && selectedItem.item is HeroDescription)
         {
            new OpenHeroPopUpCommand(player,selectedItem.item as HeroDescription,Stash.click("item_info",_popup.stashParams)).execute();
         }
      }
   }
}
