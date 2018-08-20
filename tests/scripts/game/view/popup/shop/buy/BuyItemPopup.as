package game.view.popup.shop.buy
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.shop.buy.BuyItemPopupMediator;
   import game.view.gui.components.GameSlider;
   import game.view.popup.ClipBasedPopup;
   
   public class BuyItemPopup extends ClipBasedPopup
   {
       
      
      private var mediator:BuyItemPopupMediator;
      
      private var clip:BuyItemPopupClip;
      
      private var slider:GameSlider;
      
      public function BuyItemPopup(param1:BuyItemPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         this.mediator.signal_amountUpdate.add(handler_updateAmount);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(BuyItemPopupClip,"dialog_shop_item_buy");
         addChild(clip.graphics);
         clip.item_icon.setItem(mediator.slot.item);
         clip.button_buy.signal_click.add(mediator.action_buySlot);
         clip.button_minus_inst0.signal_click.add(mediator.action_decreaseAmount);
         clip.button_plus_inst0.signal_click.add(mediator.action_increaseAmount);
         clip.button_close.signal_click.add(mediator.close);
         slider = new GameSlider();
         slider.addEventListener("change",handler_sliderChange);
         slider.width = clip.marker_slider_container.graphics.width;
         clip.marker_slider_container.addChild(slider);
         slider.minimum = mediator.minItemsAmount;
         slider.step = mediator.minItemsAmount;
         handler_updateAmount();
         clip.tf_buy_for_label_base.height = 22;
         clip.tf_buy_for_label.height = 22;
         clip.price_base.data = mediator.priceBase.outputDisplayFirst;
         clip.price.data = mediator.price.outputDisplayFirst;
         clip.tf_selected_item_name.text = mediator.slot.item.name;
         clip.tf_hint.text = Translate.translate("UI_DIALOG_BUY_ITEM_HINT");
         clip.button_buy.label = Translate.translate("UI_DIALOG_BUY_ITEM_BUY");
         clip.tf_buy_for_label_base.text = Translate.translate("UI_DIALOG_BUY_ITEM_COST_BASE");
         clip.tf_buy_for_label.text = Translate.translate("UI_DIALOG_BUY_ITEM_PROFIT");
      }
      
      private function handler_updateAmount() : void
      {
         clip.tf_current_amount.text = mediator.amount + "/" + mediator.maxItemsAmount;
         clip.price.data = mediator.price.outputDisplayFirst;
         clip.marker_slider_container.graphics.visible = mediator.maxItemsAmount > 1;
         slider.maximum = mediator.maxItemsAmount;
         slider.value = mediator.amount;
      }
      
      private function handler_sliderChange() : void
      {
         mediator.action_setAmount(slider.value);
      }
   }
}
