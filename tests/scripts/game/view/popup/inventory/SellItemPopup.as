package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.inventory.SellItemPopupMediator;
   import game.view.gui.components.GameSlider;
   import game.view.popup.ClipBasedPopup;
   
   public class SellItemPopup extends ClipBasedPopup
   {
       
      
      private var clip:SellItemPopupClip;
      
      private var mediator:SellItemPopupMediator;
      
      private var slider:GameSlider;
      
      public function SellItemPopup(param1:SellItemPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_amountUpdate.add(handler_updateAmount);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_player_inventory_sell_item();
         addChild(clip.graphics);
         clip.item_icon.setItem(mediator.item);
         clip.button_sell.signal_click.add(mediator.action_sell);
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
         clip.icon_gold_base.image.texture = mediator.sellCoinIcon;
         clip.icon_gold.image.texture = mediator.sellCoinIcon;
         clip.tf_item_in_stock_label.text = Translate.translate("UI_DIALOG_SELL_ITEM_STOCK");
         clip.tf_hint.text = Translate.translate("UI_DIALOG_SELL_ITEM_HINT");
         clip.tf_selected_item_name.text = mediator.item.name;
         clip.button_sell.label = Translate.translate("UI_DIALOG_SELL_ITEM_SELL");
         clip.tf_sell_for_label_base.text = Translate.translate("UI_DIALOG_SELL_ITEM_COST_BASE");
         clip.tf_sell_cost_base.text = mediator.sellProfitBase.toString();
         clip.tf_item_in_stock.text = mediator.amountInStock.toString();
         clip.tf_sell_for_label.text = Translate.translate("UI_DIALOG_SELL_ITEM_PROFIT");
      }
      
      private function handler_updateAmount() : void
      {
         clip.tf_current_amount.text = mediator.amount + "/" + mediator.amountInStock;
         clip.tf_sell_cost.text = mediator.sellProfit.toString();
         clip.marker_slider_container.graphics.visible = mediator.amountInStock > 1;
         slider.maximum = mediator.amountInStock;
         slider.value = mediator.amount;
      }
      
      private function handler_sliderChange() : void
      {
         mediator.action_setAmount(slider.value);
      }
   }
}
