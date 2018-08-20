package game.view.specialoffer.welcomeback
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import starling.animation.Juggler;
   
   public class SpecialOfferWelcomeBackPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:SpecialOfferWelcomeBackPopupMediator;
      
      private var clip:SpecialOfferWelcomeBackPopupClip;
      
      private var animationJuggler:Juggler;
      
      public function SpecialOfferWelcomeBackPopup(param1:SpecialOfferWelcomeBackPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName("offer_welcome_back"));
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.freeRewardObtained.unsubscribe(handler_freeRewardObtainedValue);
         mediator.freeRewardObtained.signal_update.remove(handler_freeRewardObtained);
         if(animationJuggler)
         {
            animationJuggler.purge();
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(SpecialOfferWelcomeBackPopupClip,"dialog_specialOffer_welcomeBack");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics);
         clip.animation_highlight.gotoAndStop(0);
         var _loc2_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"bundle_bg");
         clip.marker_bg.container.addChild(_loc2_.graphics);
         mediator.freeRewardObtained.onValue(handler_freeRewardObtainedValue);
         mediator.freeRewardObtained.signal_update.add(handler_freeRewardObtained);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_buy.signal_click.add(mediator.action_buy);
      }
      
      override public function close() : void
      {
      }
      
      private function setReward(param1:int, param2:InventoryItem) : void
      {
         clip.reward[param1].graphics.visible = param2 != null;
         clip.animation[param1].graphics.visible = param2 != null;
         if(param2)
         {
            clip.reward[param1].data = param2;
         }
      }
      
      private function handler_freeRewardObtained(param1:Boolean) : void
      {
         clip.animation_highlight.gotoAndPlay(1);
         clip.animation_highlight.stopOnFrame(clip.animation_highlight.lastFrame);
      }
      
      private function handler_freeRewardObtainedValue(param1:Boolean) : void
      {
         if(param1)
         {
            clip.tf_header.text = mediator.offerTitle;
            clip.tf_description.text = mediator.offerDescription;
            clip.button_buy.label = mediator.offerButton;
         }
         else
         {
            clip.tf_header.text = mediator.title;
            clip.tf_description.text = mediator.description;
            clip.button_buy.label = mediator.button;
         }
         var _loc2_:Vector.<InventoryItem> = mediator.reward;
         var _loc3_:int = _loc2_.length;
         if(_loc3_ == 1)
         {
            setReward(0,null);
            setReward(1,_loc2_[0]);
            setReward(2,null);
            var _loc4_:Boolean = false;
            clip.plus[1].graphics.visible = _loc4_;
            clip.plus[0].graphics.visible = _loc4_;
         }
         else
         {
            setReward(0,_loc2_[0]);
            setReward(1,_loc2_[1]);
            setReward(2,_loc2_[2]);
            _loc4_ = true;
            clip.plus[1].graphics.visible = _loc4_;
            clip.plus[0].graphics.visible = _loc4_;
         }
      }
   }
}
