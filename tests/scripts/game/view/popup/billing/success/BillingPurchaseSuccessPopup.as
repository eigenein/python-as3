package game.view.popup.billing.success
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.success.BillingPurchaseSuccessPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class BillingPurchaseSuccessPopup extends ClipBasedPopup
   {
       
      
      private var mediator:BillingPurchaseSuccessPopupMediator;
      
      public function BillingPurchaseSuccessPopup(param1:BillingPurchaseSuccessPopupMediator)
      {
         super(param1);
         stashParams.windowName = "billing_success";
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:BillingPurchaseSuccessPopupClip = AssetStorage.rsx.popup_theme.create(BillingPurchaseSuccessPopupClip,"popup_purchase_confirm");
         addChild(_loc1_.graphics);
         _loc1_.button_close.signal_click.add(close);
         _loc1_.tf_gem_amount.text = mediator.gemReward.toString();
         _loc1_.tf_vip_reward.text = "+" + mediator.vipPointsReward;
         _loc1_.tf_vip_reward_label.text = Translate.translateArgs("UI_DIALOG_BILLING_POINTS",mediator.vipPoints);
         _loc1_.button_close.label = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_OK");
         _loc1_.vip_level.setVip(mediator.vipLevel);
         _loc1_.vip_level_next.setVip(mediator.nextVipLevel);
         _loc1_.progress_bar.maxValue = mediator.progressbarMaxValue;
         _loc1_.progress_bar.value = mediator.progressbarMinValue;
         _loc1_.progress_bar.value = mediator.progressbarValue;
      }
   }
}
