package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.inventory.UseStaminaItemPopUpMediator;
   import game.view.gui.components.GameSlider;
   import game.view.popup.ClipBasedPopup;
   
   public class UseStaminaItemPopup extends ClipBasedPopup
   {
       
      
      private var clip:UseStaminaItemPopupClip;
      
      private var mediator:UseStaminaItemPopUpMediator;
      
      private var slider:GameSlider;
      
      public function UseStaminaItemPopup(param1:UseStaminaItemPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_amountUpdate.add(handler_updateAmount);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_player_inventory_use_stamina();
         addChild(clip.graphics);
         clip.item_icon.setItem(mediator.item);
         clip.button_use.signal_click.add(mediator.action_use);
         clip.button_minus_inst0.signal_click.add(mediator.action_decreaseAmount);
         clip.button_plus_inst0.signal_click.add(mediator.action_increaseAmount);
         clip.button_close.signal_click.add(mediator.close);
         clip.icon_stamina.image.texture = AssetStorage.rsx.popup_theme.getTexture("icon_energy");
         clip.icon_stamina_base.image.texture = AssetStorage.rsx.popup_theme.getTexture("icon_energy");
         slider = new GameSlider();
         slider.addEventListener("change",handler_sliderChange);
         slider.width = clip.marker_slider_container.graphics.width;
         clip.marker_slider_container.addChild(slider);
         slider.step = 1;
         slider.minimum = 1;
         handler_updateAmount();
         clip.tf_item_in_stock_label.text = Translate.translate("UI_DIALOG_SELL_ITEM_STOCK");
         clip.tf_hint.text = Translate.translate("UI_DIALOG_USE_ITEM_HINT");
         clip.tf_selected_item_name.text = mediator.item.name;
         clip.button_use.label = Translate.translate("UI_DIALOG_INVENTORY_USE");
         clip.tf_use_for_label_base.text = Translate.translate("LIB_PSEUDO_STAMINA") + ":";
         clip.tf_use_cost_base.text = mediator.staminaProfitBase.toString();
         clip.tf_item_in_stock.text = mediator.amountInStock.toString();
         clip.tf_use_for_label.text = Translate.translate("UI_DIALOG_USE_ITEM_PROFIT");
      }
      
      private function handler_updateAmount() : void
      {
         clip.tf_current_amount.text = mediator.amount + "/" + mediator.amountInStock;
         clip.tf_use_cost.text = mediator.staminaProfit.toString();
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
