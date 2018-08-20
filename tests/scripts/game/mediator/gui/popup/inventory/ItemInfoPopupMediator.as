package game.mediator.gui.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.inventory.CommandInventoryCraftFragments;
   import game.command.rpc.inventory.CommandInventoryCraftRecipe;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.InventoryItemObtainType;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.InventoryItemRecipeMediator;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.mission.MissionEnterPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.inventory.ItemInfoPopup;
   import idv.cjcat.signals.Signal;
   
   public class ItemInfoPopupMediator extends PopupMediator
   {
       
      
      public const signal_amountChanged:Signal = new Signal();
      
      public const signal_craftSelected:Signal = new Signal();
      
      public const signal_dropListSelected:Signal = new Signal();
      
      public const signal_craftOrderUpdated:Signal = new Signal();
      
      private var _craftItemSignal:Signal;
      
      private var _recipeOrder:Vector.<InventoryItemRecipeMediator>;
      
      private var _craftOrder:Vector.<InventoryItemValueObject>;
      
      protected var _item:InventoryItemDescription;
      
      private var _inventoryItem:InventoryItemCountProxy;
      
      protected var _iconInventoryItem:InventoryItem;
      
      public function ItemInfoPopupMediator(param1:Player, param2:InventoryItemDescription)
      {
         var _loc3_:* = null;
         _craftItemSignal = new Signal();
         super(param1);
         this._item = param2;
         if(_item is UnitDescription)
         {
            _inventoryItem = param1.inventory.getItemCounterProxy(_item,true);
            _iconInventoryItem = new InventoryFragmentItem(param2,1);
         }
         else
         {
            _inventoryItem = param1.inventory.getItemCounterProxy(_item,false);
            _iconInventoryItem = new InventoryItem(param2,1);
         }
         _inventoryItem.signal_update.add(handler_itemAmountUpdate);
         _craftOrder = new Vector.<InventoryItemValueObject>();
         if(param2 is UnitDescription)
         {
            _loc3_ = new InventoryFragmentItem(param2,1);
         }
         else
         {
            _loc3_ = new InventoryItem(param2,1);
         }
         _craftOrder.push(new InventoryItemValueObject(param1,_loc3_));
         _recipeOrder = new Vector.<InventoryItemRecipeMediator>();
         updateCurrentCraftRecipes();
      }
      
      override protected function dispose() : void
      {
         var _loc2_:int = 0;
         _inventoryItem.signal_update.remove(handler_itemAmountUpdate);
         var _loc1_:int = _recipeOrder.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_recipeOrder[_loc2_] != null)
            {
               _recipeOrder[_loc2_].dispose();
            }
            _loc2_++;
         }
         super.dispose();
      }
      
      public function get signal_craftItem() : Signal
      {
         return _craftItemSignal;
      }
      
      public function get item() : InventoryItemDescription
      {
         return _item;
      }
      
      public function get inventoryItem() : InventoryItemCountProxy
      {
         return _inventoryItem;
      }
      
      public function get obtainableFromChest() : ChestDescription
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(item is UnitDescription)
         {
            _loc2_ = item as UnitDescription;
            _loc1_ = DataStorage.chest.checkIfHeroIsInUnlockableDropList(_loc2_);
            if(_loc1_ && player.heroes.getById(_loc2_.id))
            {
               return _loc1_;
            }
            return DataStorage.chest.checkIfHeroIsInDropList(_loc2_);
         }
         return null;
      }
      
      public function get iconInventoryItem() : InventoryItem
      {
         return _iconInventoryItem;
      }
      
      public function get itemName() : String
      {
         return _item.name;
      }
      
      public function get itemAmount() : String
      {
         if(item is UnitDescription)
         {
            return player.inventory.getFragmentCollection().getItemCount(item).toString();
         }
         return player.inventory.getItemCollection().getItemCount(item).toString();
      }
      
      public function get itemStats() : Vector.<BattleStatValueObject>
      {
         var _loc1_:GearItemDescription = item as GearItemDescription;
         if(!_loc1_)
         {
            return null;
         }
         return BattleStatValueObjectProvider.fromBattleStats(_loc1_.battleStatData);
      }
      
      public function get heroLevelRequired() : int
      {
         var _loc1_:GearItemDescription = item as GearItemDescription;
         if(!_loc1_)
         {
            return null;
         }
         return _loc1_.heroLevel;
      }
      
      public function get craftOrder() : Vector.<InventoryItemValueObject>
      {
         return _craftOrder;
      }
      
      public function get currentItemName() : String
      {
         return _craftOrder[_craftOrder.length - 1].name;
      }
      
      public function get currentItemHasCraft() : Boolean
      {
         return _recipeOrder[_craftOrder.length - 1] != null;
      }
      
      public function get currentRecipe() : InventoryItemRecipeMediator
      {
         return _recipeOrder[_craftOrder.length - 1];
      }
      
      public function get currentDropList() : Vector.<MissionItemDropValueObject>
      {
         return player.missions.getItemDropList(_craftOrder[_craftOrder.length - 1].item);
      }
      
      public function get obtainType() : InventoryItemObtainType
      {
         var _loc1_:InventoryItemValueObject = _craftOrder[_craftOrder.length - 1];
         if(_loc1_.item is InventoryItemDescription)
         {
            return (_loc1_.item as InventoryItemDescription).obtainType;
         }
         return null;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_gold(true);
         return _loc1_;
      }
      
      public function get itemIsCraftable() : Boolean
      {
         var _loc1_:InventoryItemRecipeMediator = this.currentRecipe;
         return _loc1_ && _loc1_.craftRecipe && _loc1_.craftRecipe.length;
      }
      
      public function get itemIsCraftableRightNow() : Boolean
      {
         if(!itemIsCraftable)
         {
            return false;
         }
         var _loc1_:CostData = null;
         var _loc2_:GearItemDescription = currentRecipe.item as GearItemDescription;
         if(currentRecipe.item.fragmentMergeCost)
         {
            _loc1_ = currentRecipe.item.fragmentMergeCost.clone() as CostData;
         }
         else if(_loc2_ && _loc2_.craftRecipe)
         {
            _loc1_ = _loc2_.craftRecipe.clone() as CostData;
         }
         _loc1_.gold = 0;
         return player.canSpend(_loc1_);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ItemInfoPopup(this);
         return _popup;
      }
      
      public function action_selectRecipePartItem(param1:InventoryItemValueObject) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function action_craftItem() : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:InventoryItemDescription = _craftOrder[_craftOrder.length - 1].item;
         var _loc5_:GearItemDescription = _loc1_ as GearItemDescription;
         var _loc2_:CostData = null;
         if(_loc1_.fragmentMergeCost)
         {
            _loc2_ = _loc1_.fragmentMergeCost.clone() as CostData;
         }
         else if(_loc5_ && _loc5_.craftRecipe)
         {
            _loc2_ = _loc5_.craftRecipe.clone() as CostData;
         }
         _loc2_.gold = 0;
         if(player.canSpend(_loc2_))
         {
            if(_loc1_.fragmentMergeCost)
            {
               _loc4_ = GameModel.instance.actionManager.inventory.inventoryCraftFragments(_loc1_,1);
               _loc4_.onClientExecute(onAction_craftItemFromFragments);
            }
            else
            {
               _loc3_ = GameModel.instance.actionManager.inventory.inventoryCraftRecipe(_loc5_,1);
               _loc3_.onClientExecute(onAction_craftItem);
            }
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_CANT_CRAFT"),"");
         }
      }
      
      public function action_selectMission(param1:MissionItemDropValueObject) : void
      {
         var _loc2_:MissionEnterPopupMediator = new MissionEnterPopupMediator(GameModel.instance.player,param1.mission);
         var _loc3_:InventoryItem = _craftOrder[_craftOrder.length - 1].inventoryItem;
         _loc2_.itemToLookFor = _loc3_;
         _loc2_.signal_close.add(handler_missionClosed);
         _loc2_.open(Stash.click("mission_enter",_popup.stashParams));
      }
      
      public function action_obtainCurrentHeroSource() : void
      {
         if(obtainType)
         {
            if(obtainType.type == "mechanic:ny2018_gifts")
            {
               if(!player.specialOffer.hasSpecialOffer("newYear2018"))
               {
                  PopupList.instance.message(Translate.translate("LIB_HERO_OBTAIN_TYPE_EVENT__SPECIAL"));
                  return;
               }
            }
            Game.instance.navigator.heroObtainTypeHelper.navigate(obtainType,Stash.click("hero_obtain",_popup.stashParams));
         }
      }
      
      public function action_obtainFromChest() : void
      {
         if(obtainableFromChest)
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.CHEST,Stash.click("chest",_popup.stashParams));
         }
      }
      
      public function action_obtainTitanFromDungeon() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CLAN_DUNGEON,Stash.click("dungeon",_popup.stashParams));
         close();
      }
      
      public function action_obtainTitanFromSummoningCircle() : void
      {
         Game.instance.navigator.navigateToSummoningCircle(Stash.click("summoning_circle",_popup.stashParams));
         close();
      }
      
      protected function updateCurrentCraftRecipes() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _craftOrder.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ >= _recipeOrder.length || _recipeOrder[_loc2_] == null || _recipeOrder[_loc2_].item != _craftOrder[_loc2_].item)
            {
               if(InventoryItemRecipeMediator.canBeCrafted(_craftOrder[_loc2_].inventoryItem))
               {
                  _recipeOrder[_loc2_] = new InventoryItemRecipeMediator(player,_craftOrder[_loc2_].item);
               }
               else
               {
                  if(_recipeOrder.length > _loc2_ && _recipeOrder[_loc2_])
                  {
                     _recipeOrder[_loc2_].dispose();
                  }
                  _recipeOrder[_loc2_] = null;
               }
            }
            _loc2_++;
         }
      }
      
      protected function oneLevelUpInCraftOrder() : Boolean
      {
         if(_craftOrder.length > 1)
         {
            action_selectRecipePartItem(_craftOrder[_craftOrder.length - 2]);
            return true;
         }
         return false;
      }
      
      protected function onAction_craftItem(param1:CommandInventoryCraftRecipe) : void
      {
         _craftItemSignal.dispatch();
         if(!oneLevelUpInCraftOrder() && currentItemHasCraft)
         {
            signal_craftSelected.dispatch();
         }
      }
      
      protected function onAction_craftItemFromFragments(param1:CommandInventoryCraftFragments) : void
      {
         _craftItemSignal.dispatch();
         if(!oneLevelUpInCraftOrder() && currentItemHasCraft)
         {
            signal_craftSelected.dispatch();
         }
      }
      
      protected function handler_itemAmountUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_amountChanged.dispatch();
      }
      
      protected function handler_missionClosed() : void
      {
         var _loc1_:InventoryItemValueObject = _craftOrder[_craftOrder.length - 1];
         if(!(_loc1_.item is UnitDescription) && _craftOrder.length > 1)
         {
            if(_loc1_.ownedAmount >= _loc1_.amount)
            {
               oneLevelUpInCraftOrder();
            }
         }
      }
   }
}
