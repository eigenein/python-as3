package game.view.popup.dailybonus
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.BillingPopupMediator;
   import game.model.GameModel;
   import game.view.popup.PopupBase;
   
   public class DailyBonusPopupVipNeeded extends PopupBase
   {
       
      
      private var level:int;
      
      public function DailyBonusPopupVipNeeded(param1:int)
      {
         super();
         this.level = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:DailyBonusPopupVipNeededClip = AssetStorage.rsx.popup_theme.create_popup_daily_bonus_vip_needed();
         addChild(_loc1_.graphics);
         _loc1_.button_bank.signal_click.add(handler_bank);
         _loc1_.button_cancel.signal_click.add(close);
         _loc1_.tf_caption.text = Translate.translateArgs("UI_DIALOG_DAILY_BONUS_VIP_NEEDED",level);
         _loc1_.tf_question.text = Translate.translate("UI_DIALOG_DAILY_BONUS_VIP_NEEDED_QUESTION");
         _loc1_.button_bank.label = Translate.translate("UI_DIALOG_DAILY_BONUS_VIP_NEEDED_BANK");
         _loc1_.button_cancel.label = Translate.translate("UI_DIALOG_DAILY_BONUS_VIP_NEEDED_CANCEL");
      }
      
      private function handler_bank() : void
      {
         var _loc1_:BillingPopupMediator = new BillingPopupMediator(GameModel.instance.player);
         PopUpManager.addPopUp(_loc1_.createPopup());
      }
   }
}
