package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipFactory;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.hero.slot.HeroSlotPopupClip;
   
   public class ItemInfoPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      protected var clip:HeroSlotPopupClip;
      
      protected var mediator:ItemInfoPopupMediator;
      
      public function ItemInfoPopup(param1:ItemInfoPopupMediator)
      {
         super(param1);
         stashParams.windowName = "item_info";
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(mediator)
         {
            mediator.signal_amountChanged.remove(updateItemAmount);
            mediator.signal_craftSelected.remove(handler_updateSelectedCraft);
            mediator.signal_craftItem.remove(handler_craftItem);
            mediator.signal_dropListSelected.remove(updateSelectedDropList);
            mediator.signal_craftOrderUpdated.remove(updateCraftOrder);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_slot();
         addChild(clip.graphics);
         mediator.signal_amountChanged.add(updateItemAmount);
         mediator.signal_craftSelected.add(handler_updateSelectedCraft);
         mediator.signal_craftItem.add(handler_craftItem);
         mediator.signal_dropListSelected.add(updateSelectedDropList);
         mediator.signal_craftOrderUpdated.add(updateCraftOrder);
         updateItemAmount();
         if(mediator.currentItemHasCraft)
         {
            updateSelectedCraft();
         }
         else
         {
            updateSelectedDropList();
         }
         updateCraftOrder();
         clip.button_close.signal_click.add(close);
         updateTwoMainButtons();
         clip.current_craft.button_craft.label = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_CRAFT");
         clip.current_craft.button_craft.signal_click.add(mediator.action_craftItem);
         clip.current_craft.craft_recipe_list.signal_itemSelected.add(mediator.action_selectRecipePartItem);
         clip.current_drop_sources.drop_list.signal_select.add(mediator.action_selectMission);
         clip.current_drop_sources.signal_obtainClick.add(handler_heroSourceObtainClick);
         clip.current_drop_sources.signal_obtainFromChestClick.add(handler_chestObtainClick);
         clip.item_description.tf_item_in_stock_label.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_AMOUNT");
         clip.item_description.item_icon.setItem(mediator.iconInventoryItem);
         clip.item_description.tf_item_name.text = mediator.itemName;
         clip.item_description.itemDesc.setData(mediator.iconInventoryItem,mediator.itemStats);
         if(mediator.heroLevelRequired > 0)
         {
            clip.item_description.tf_green_item_requirements.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_REQUIRED_LEVEL") + " " + mediator.heroLevelRequired;
         }
         clip.current_drop_sources.setMediator(mediator);
      }
      
      protected function updateCraftOrder() : void
      {
         var factory:GuiClipFactory = new GuiClipFactory();
         var container:LayoutGroup = clip.layout_craft_order.layoutGroup;
         container.removeChildren(0,-1,true);
         var craftOrder:Vector.<InventoryItemValueObject> = mediator.craftOrder;
         var length:int = craftOrder.length;
         if(length <= 1 && mediator.currentItemHasCraft)
         {
            return;
         }
         var i:int = 0;
         while(i < length)
         {
            lambda = function(param1:InventoryItemValueObject):void
            {
               item = param1;
               itemIcon.signal_click.add(function():*
               {
                  mediator.action_selectRecipePartItem(item);
               });
            };
            var item:InventoryItemValueObject = craftOrder[i];
            if(i > 0)
            {
               var arrow:ClipSprite = new ClipSprite();
               factory.create(arrow,clip.arrow_right.clip);
               container.addChild(arrow.graphics);
            }
            var itemIcon:InventoryItemIcon = new InventoryItemIcon();
            factory.create(itemIcon,clip.craft_order_item_icon.clip);
            if(length > 4 && i < length - 1)
            {
               var _loc2_:* = 0.66;
               itemIcon.graphics.scaleY = _loc2_;
               itemIcon.graphics.scaleX = _loc2_;
            }
            itemIcon.setItem(item.inventoryItem);
            container.addChild(itemIcon.graphics);
            lambda(item);
            i = Number(i) + 1;
         }
      }
      
      protected function updateItemAmount() : void
      {
         clip.item_description.tf_item_in_stock.text = mediator.itemAmount;
         updateTwoMainButtons();
      }
      
      protected function updateSelectedCraft() : void
      {
         clip.tf_current_item_name.text = mediator.currentItemName;
         clip.current_craft.setCurrentItem(mediator.currentRecipe);
         clip.current_craft.button_craft.glow = false;
         switchBlockVisibility(true);
      }
      
      protected function updateSelectedDropList() : void
      {
         clip.tf_current_item_name.text = mediator.currentItemName;
         var _loc2_:Vector.<MissionItemDropValueObject> = mediator.currentDropList;
         if(_loc2_.length)
         {
            clip.current_drop_sources.setDropList(_loc2_);
         }
         else if(mediator.obtainType)
         {
            clip.current_drop_sources.setObtainType(mediator.obtainType);
         }
         else
         {
            clip.current_drop_sources.setObtainTypeNone();
         }
         var _loc1_:ChestDescription = mediator.obtainableFromChest;
         clip.current_drop_sources.setChestType(_loc1_);
         switchBlockVisibility(false);
      }
      
      protected function switchBlockVisibility(param1:Boolean) : void
      {
         clip.current_craft.graphics.visible = param1;
         clip.current_drop_sources.graphics.visible = !param1;
      }
      
      protected function updateTwoMainButtons() : void
      {
         clip.button_wear.signal_click.clear();
         clip.button_craft.signal_click.clear();
         clip.button_craft.graphics.visible = false;
         clip.button_wear.label = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_OK");
         clip.button_wear.glow = false;
         clip.button_wear.signal_click.add(close);
      }
      
      private function handler_heroSourceObtainClick() : void
      {
         mediator.action_obtainCurrentHeroSource();
      }
      
      private function handler_chestObtainClick() : void
      {
         mediator.action_obtainFromChest();
      }
      
      protected function handler_updateSelectedCraft() : void
      {
         updateSelectedCraft();
      }
      
      protected function handler_craftItem() : void
      {
         Game.instance.soundPlayer.playClipSound("hammer_med2_x2_fast");
      }
   }
}
