package game.mechanics.zeppelin.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.zeppelin.mediator.ZeppelinPopupMediator;
   import game.mechanics.zeppelin.popup.clip.ZeppelinPopupClip;
   import game.model.user.specialoffer.SpecialOfferViewSlot;
   import game.view.gui.overlay.offer.SpecialOfferSideBarBase;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import starling.core.Starling;
   
   public class ZeppelinPopup extends ZeppelinPopupBase implements ITutorialNodePresenter
   {
       
      
      private var clip:ZeppelinPopupClip;
      
      private var mediator:ZeppelinPopupMediator;
      
      private var chestSlot:SpecialOfferViewSlot;
      
      public function ZeppelinPopup(param1:ZeppelinPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_zeppelin);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         if(clip)
         {
            clip.btn_dealer.dispose();
            clip.dispose();
            chestSlot.dispose();
         }
         clip = null;
         chestSlot = null;
         super.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.ZEPPELIN;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         width = 1000;
         height = 640;
         ZeppelinPopupMediator.music.shopOpen();
         clip = AssetStorage.rsx.dialog_zeppelin.create(ZeppelinPopupClip,"zeppelin_popup");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         clip.btn_characters.label = Translate.translate("UI_ZEPPELIN_POPUP_TF_ARTIFACTS");
         clip.btn_chest.label = Translate.translate("UI_ZEPPELIN_POPUP_TF_CHEST");
         clip.btn_dealer.label = Translate.translate("UI_ZEPPELIN_POPUP_TF_MERCHANT");
         clip.btn_desk.label = Translate.translate("UI_ZEPPELIN_POPUP_TF_EXPEDITIONS");
         clip.btn_subscription.label = Translate.translate("UI_ZEPPELIN_POPUP_TF_SUBSCRIPTION");
         clip.btn_characters.signal_click.add(mediator.action_navigate_artifacts);
         clip.btn_chest.signal_click.add(mediator.action_navigate_chest);
         clip.btn_dealer.signal_click.add(mediator.action_navigate_merchant);
         clip.btn_desk.signal_click.add(mediator.action_navigate_expeditions);
         clip.btn_subscription.signal_click.add(mediator.action_navigate_subscription);
         clip.btn_chest.redMarkerState = mediator.redMarkerState_chest;
         clip.btn_characters.redMarkerState = mediator.redMarkerState_artifacts;
         clip.btn_desk.redMarkerState = mediator.redMarkerState_expeditions;
         clip.btn_subscription.redMarkerState = mediator.redMarkerState_subscription;
         chestSlot = new SpecialOfferViewSlot(clip.btn_chest.graphics,mediator.specialOfferHooks.zeppelinArtifactChest);
         clip.btn_subscription.action_setActiveSubscription(mediator.property_subscriptionActive.value);
         mediator.registerSpecialOfferSpot(clip.layout_special_offer);
         var _loc2_:SpecialOfferSideBarBase = mediator.sideBar.panel;
         _loc2_.x = Starling.current.stage.stageWidth - _loc2_.width - 10;
         _loc2_.y = Starling.current.stage.stageHeight * 0.5 - _loc2_.height * 0.5;
         addChild(_loc2_);
      }
   }
}
