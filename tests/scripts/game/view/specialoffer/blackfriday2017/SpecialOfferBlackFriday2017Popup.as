package game.view.specialoffer.blackfriday2017
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.billing.bundle.BundlePopupTimerBlockClip;
   import starling.animation.Juggler;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class SpecialOfferBlackFriday2017Popup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var juggler:Juggler;
      
      private var mediator:SpecialOfferBlackFriday2017PopupMediator;
      
      private var clip:SpecialOfferBlackFriday2017PopupClip;
      
      protected var timerBlock:BundlePopupTimerBlockClip;
      
      public function SpecialOfferBlackFriday2017Popup(param1:SpecialOfferBlackFriday2017PopupMediator)
      {
         juggler = new Juggler();
         super(param1,param1.popupClip.asset as RsxGuiAsset);
         this.mediator = param1;
         Starling.juggler.add(juggler);
      }
      
      override public function dispose() : void
      {
         if(mediator)
         {
            mediator.signal_timer.remove(handler_updateTimer);
         }
         Starling.juggler.remove(juggler);
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:* = null;
         clip = param1.create(SpecialOfferBlackFriday2017PopupClip,mediator.popupClip.clipName);
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_header.text = Translate.translate(mediator.localeTitleKey);
         clip.tf_desc.text = Translate.translate(mediator.localeDescKey);
         clip.panel1.button.initialize(Translate.translate("UI_DIALOG_VIP_TO_STORE"),mediator.action_toBilling);
         clip.panel1.tf_header.text = Translate.translate("UI_SPECIALOFFER_WELCOME_BACK_BONUSES_BILLING_DESC");
         clip.tf_billing_bought.text = Translate.translate("UI_SPECIALOFFER_BLACKFRIDAY_PURCHASED_TODAY");
         clip.panel2.button.initialize(Translate.translate("UI_DIALOG_QUEST_INFO"),mediator.action_toArtifactChest);
         clip.panel2.tf_header.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST");
         clip.tf_artifactChest_sale.text = "-" + mediator.artifactChestSale;
         clip.panel3.button.initialize(Translate.translate("UI_DIALOG_QUEST_INFO"),mediator.action_toSummoningCircle);
         clip.panel3.tf_header.text = Translate.translate("UI_CLANMENU_SUMMONING_CIRCLE");
         clip.tf_summoningCircle_sale.text = "-" + mediator.summoningCircleSale;
         clip.panel4.button.initialize(Translate.translate("UI_DIALOG_QUEST_INFO"),mediator.action_toChest);
         clip.panel4.tf_header.text = Translate.translate("LIB_CHEST_NAME_town");
         clip.tf_chest_sale.text = "-" + mediator.chestSale;
         clip.panel1.button.graphics.visible = mediator.hasBillingSpecialOffer;
         clip.layout_billing_bought.graphics.visible = !mediator.hasBillingSpecialOffer;
         clip.tf_billing_sale.text = mediator.billingSale;
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
         initTimer(clip.timer);
         juggler.delayCall(animateButtons,4);
      }
      
      protected function animateButtons() : void
      {
         juggler.delayCall(animateButtons,4);
         animateButton(1);
         juggler.delayCall(animateButton,0.1,2);
         juggler.delayCall(animateButton,0.2,3);
         juggler.delayCall(animateButton,0.3,4);
      }
      
      protected function animateButton(param1:int = 1) : void
      {
         var _loc3_:DisplayObject = (clip["panel" + param1] as SpecialOfferBlackFriday2017PanelClip).button.graphics;
         var _loc2_:* = 0.15;
         juggler.tween(_loc3_,_loc2_,{
            "y":_loc3_.y - 4,
            "transition":"easeOut"
         });
         juggler.tween(_loc3_,_loc2_,{
            "y":_loc3_.y,
            "transition":"easeIn",
            "delay":_loc2_ + 0.05
         });
      }
      
      protected function initTimer(param1:BundlePopupTimerBlockClip, param2:Boolean = false) : void
      {
         this.timerBlock = param1;
         param1.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         var _loc3_:Boolean = true;
         param1.graphics.visible = _loc3_;
         if(_loc3_)
         {
            mediator.signal_timer.add(handler_updateTimer);
            handler_updateTimer();
         }
      }
      
      protected function handler_updateTimer() : void
      {
         if(!clip)
         {
            return;
         }
         if(mediator.isOver)
         {
            clip.timer.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER_IS_OVER");
            clip.timer.tf_timer.text = "";
         }
         else
         {
            clip.timer.tf_timer.text = mediator.timeLeftString;
         }
      }
   }
}
