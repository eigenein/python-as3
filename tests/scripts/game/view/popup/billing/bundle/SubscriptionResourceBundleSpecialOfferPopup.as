package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialOfferPopupMediator;
   
   public class SubscriptionResourceBundleSpecialOfferPopup extends ResourceBundleSpecialOfferPopup
   {
       
      
      public function SubscriptionResourceBundleSpecialOfferPopup(param1:ResourceBundleSpecialOfferPopupMediator)
      {
         super(param1,AssetStorage.rsx.getByName("dialog_valkyrie_image") as RsxGuiAsset);
      }
      
      override protected function initGraphics() : void
      {
         clip = AssetStorage.rsx.asset_bundle.create(Bundle2PopupClip,"dialog_bundle_subscription_4");
         addChild(clip.graphics);
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_header.text = mediator.bundleTitle;
         clip.tf_label_desc.text = mediator.bundleDescription;
         clip.timer.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         var _loc2_:ClipSprite = (AssetStorage.rsx.getByName("dialog_valkyrie_image") as RsxGuiAsset).create(ClipSprite,"valkyrie_image");
         clip.marker_girl.container.addChild(_loc2_.graphics);
      }
   }
}
