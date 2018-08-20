package game.view.specialoffer.welcomeback
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class SpecialOfferWelcomeBackBonusesPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:SpecialOfferWelcomeBackBonusesPopupMediator;
      
      private var clip:SpecialOfferWelcomeBackBonusesPopupClip;
      
      public function SpecialOfferWelcomeBackBonusesPopup(param1:SpecialOfferWelcomeBackBonusesPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName("offer_welcome_back_bonuses"));
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         if(mediator)
         {
            mediator.signal_timer.remove(handler_updateTimer);
         }
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:* = null;
         clip = param1.create(SpecialOfferWelcomeBackBonusesPopupClip,"dialog_offer_welcome_back_bonuses");
         addChild(clip.graphics);
         centerPopupBy(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_header.text = Translate.translate("UI_SPECIALOFFER_WELCOME_BACK_BONUSES_TITLE");
         clip.tf_desc.text = Translate.translate("UI_SPECIALOFFER_WELCOME_BACK_BONUSES_DESC");
         clip.button_billing.initialize(Translate.translate("UI_DIALOG_VIP_TO_STORE"),mediator.action_toBilling);
         clip.tf_panel_billing_header.text = Translate.translate("UI_SPECIALOFFER_WELCOME_BACK_BONUSES_BILLING_DESC");
         clip.tf_billing_sale.text = mediator.billingSale;
         clip.button_chest.initialize(Translate.translate("UI_SPECIALOFFER_WELCOME_BACK_BONUSES_TO_CHEST"),mediator.action_toChest);
         clip.tf_panel_chest_header.text = Translate.translate("UI_SPECIALOFFER_WELCOME_BACK_BONUSES_CHEST_DESC");
         clip.tf_chest_sale.text = "-" + mediator.chestSale;
         var _loc4_:Texture = mediator.billingIconTexture;
         var _loc6_:int = 0;
         var _loc5_:* = clip.layout_billing;
         for each(var _loc2_ in clip.layout_billing)
         {
            if(_loc2_)
            {
               _loc3_ = new Image(_loc4_);
               _loc3_.width = _loc2_.container.width;
               _loc3_.height = _loc2_.container.height;
               _loc2_.container.addChild(_loc3_);
            }
         }
         clip.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         mediator.signal_timer.add(handler_updateTimer);
         handler_updateTimer();
      }
      
      protected function handler_updateTimer() : void
      {
         if(!clip)
         {
            return;
         }
         if(mediator.isOver)
         {
            clip.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER_IS_OVER");
            clip.tf_timer.text = "";
         }
         else
         {
            clip.tf_timer.text = mediator.timeLeftString;
         }
      }
   }
}
