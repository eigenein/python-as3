package game.view.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.BillingConfirmPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class BillingConfirmPopup extends ClipBasedPopup
   {
       
      
      private var clip:BillingConfirmPopupClip;
      
      private var mediator:BillingConfirmPopupMediator;
      
      public function BillingConfirmPopup(param1:BillingConfirmPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "lot";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_popup_billing_confirm();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.action_close);
         clip.button_confirm.initialize(mediator.costString,mediator.action_confirm);
         clip.list.list.dataProvider = mediator.billingBenefitDataProvider;
         clip.tf_question.text = Translate.translate("?");
         clip.tf_you_got.text = Translate.translate("UI_DIALOG_BILLING_YOU_GET");
         if(mediator.isTransfer)
         {
            clip.tf_buy.text = Translate.translate("UI_DIALOG_BILLING_BUY_TRANSFER");
            clip.tf_gem_value.visible = false;
            clip.icon_gem.graphics.visible = false;
            clip.setDenseLayout();
         }
         else if(mediator.isSubscription)
         {
            clip.tf_buy.text = Translate.translate("UI_DIALOG_BILLING_BUY_SUBSCRIPTION");
            clip.tf_gem_value.visible = false;
            clip.icon_gem.graphics.visible = false;
            clip.setDenseLayout();
         }
         else
         {
            clip.tf_gem_value.text = String(mediator.gemCount);
            clip.tf_buy.text = Translate.translate("UI_DIALOG_BILLING_BUY");
         }
      }
   }
}
