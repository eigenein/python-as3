package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.inventory.LootBoxBulkUsePopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameSlider;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class LootBoxBulkUsePopup extends ClipBasedPopup
   {
       
      
      private var mediator:LootBoxBulkUsePopupMediator;
      
      private var slider:GameSlider;
      
      private var clip:LootBoxBulkUsePopupClip;
      
      private var itemList:List;
      
      public function LootBoxBulkUsePopup(param1:LootBoxBulkUsePopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mediator.property_amount.signal_update.add(handler_updateAmount);
         clip = AssetStorage.rsx.popup_theme.create(LootBoxBulkUsePopupClip,"dialog_inventory_bulk_lootbox_use");
         addChild(clip.graphics);
         clip.item_icon.setItem(mediator.item);
         clip.button_use.signal_click.add(mediator.action_use);
         clip.button_minus_inst0.signal_click.add(mediator.action_decreaseAmount);
         clip.button_plus_inst0.signal_click.add(mediator.action_increaseAmount);
         clip.button_close.signal_click.add(mediator.close);
         slider = new GameSlider();
         slider.addEventListener("change",handler_sliderChange);
         slider.width = clip.marker_slider_container.graphics.width;
         clip.marker_slider_container.addChild(slider);
         slider.step = 1;
         slider.minimum = 1;
         handler_updateAmount();
         clip.tf_hint2.text = Translate.translate("UI_DIALOG_INVENTORY_BULK_LOOTBOX_USE_TF_HINT2");
         clip.tf_hint1.text = Translate.translate("UI_DIALOG_INVENTORY_BULK_LOOTBOX_USE_TF_HINT1");
         clip.tf_selected_item_name.text = mediator.item.name;
         clip.button_use.label = Translate.translate("UI_DIALOG_INVENTORY_USE");
         itemList = new List();
         itemList.itemRendererType = PlayerInventoryPopupItemRenderer;
         clip.layout_items.addChild(itemList);
         var _loc2_:* = "off";
         itemList.verticalScrollPolicy = _loc2_;
         itemList.horizontalScrollPolicy = _loc2_;
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 5;
         _loc2_ = 5;
         _loc1_.paddingLeft = _loc2_;
         _loc1_.paddingRight = _loc2_;
         itemList.layout = _loc1_;
         itemList.dataProvider = mediator.dropTable;
         itemList.addEventListener("change",handler_listSelectionChange);
         itemList.validate();
         if(itemList.width > clip.layout_items.width)
         {
            _loc2_ = clip.layout_items.width / itemList.width;
            itemList.scaleY = _loc2_;
            itemList.scaleX = _loc2_;
         }
         updateButtonEnabledState();
         mediator.property_rewardIndex.signal_update.add(updateButtonEnabledState);
         mediator.property_amountInStock.signal_update.add(handler_updateAmount);
      }
      
      private function handler_sliderChange() : void
      {
         mediator.action_setAmount(slider.value);
      }
      
      private function handler_updateAmount(param1:int = -1) : void
      {
         clip.tf_item_in_stock.text = Translate.translate("UI_DIALOG_SELL_ITEM_STOCK") + mediator.property_amountInStock.value.toString();
         clip.tf_current_amount.text = mediator.property_amount.value + "/" + mediator.property_amountInStock.value;
         clip.marker_slider_container.graphics.visible = mediator.property_amountInStock.value > 1;
         slider.maximum = mediator.property_amountInStock.value;
         slider.value = mediator.property_amount.value;
      }
      
      private function handler_listSelectionChange(param1:Event) : void
      {
         if(itemList.selectedItem != null && itemList.selectedItem is InventoryItem)
         {
            mediator.action_selectIndex(itemList.selectedIndex);
         }
      }
      
      private function updateButtonEnabledState(param1:int = -1) : void
      {
         clip.button_use.isEnabled = mediator.property_rewardIndex.value != -1;
         clip.button_use.graphics.alpha = !!clip.button_use.isEnabled?1:0.2;
      }
   }
}
