package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialOfferPopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ResourceBundleSpecialOfferPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      protected var clip:Bundle2PopupClip;
      
      protected var mediator:ResourceBundleSpecialOfferPopupMediator;
      
      public function ResourceBundleSpecialOfferPopup(param1:ResourceBundleSpecialOfferPopupMediator, param2:RsxGuiAsset = null)
      {
         super(param1,param2);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.signal_updateBundleTimeLeft.remove(handler_updateTimer);
         super.dispose();
      }
      
      protected function createClip() : Bundle2PopupClip
      {
         return AssetStorage.rsx.asset_bundle.create(Bundle2PopupClip,"dialog_bundle_5");
      }
      
      protected function initGraphics() : void
      {
         clip = createClip();
         addChild(clip.graphics);
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_header.text = mediator.bundleTitle;
         clip.tf_label_desc.text = mediator.bundleDescription;
         clip.timer.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         var _loc1_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"vendor_girl");
         clip.marker_girl.container.addChild(_loc1_.graphics);
      }
      
      protected function setupPrice() : void
      {
         clip.tf_old_price.text = mediator.oldPrice;
         clip.button_to_store.label = mediator.billing.costString;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         initGraphics();
         centerPopupBy(clip.dialog_frame.graphics);
         clip.button_close.signal_click.add(close);
         clip.button_to_store.signal_click.add(mediator.action_buy);
         setupPrice();
         var _loc3_:int = clip.reward_item.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = clip.reward_item[_loc4_];
            if(mediator.reward.length > _loc4_)
            {
               _loc2_.setData(mediator.reward[_loc4_]);
            }
            _loc4_++;
         }
         mediator.signal_updateBundleTimeLeft.add(handler_updateTimer);
         handler_updateTimer();
      }
      
      protected function handler_updateTimer() : void
      {
         clip.timer.tf_timer.text = mediator.bundleTimeLeft;
      }
   }
}
