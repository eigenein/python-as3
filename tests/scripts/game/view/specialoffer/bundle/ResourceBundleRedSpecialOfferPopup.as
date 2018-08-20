package game.view.specialoffer.bundle
{
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialOfferPopupMediator;
   import game.view.popup.billing.bundle.Bundle2PopupClip;
   import game.view.popup.billing.bundle.ResourceBundleSpecialOfferPopup;
   
   public class ResourceBundleRedSpecialOfferPopup extends ResourceBundleSpecialOfferPopup
   {
       
      
      public function ResourceBundleRedSpecialOfferPopup(param1:ResourceBundleSpecialOfferPopupMediator, param2:RsxGuiAsset = null)
      {
         super(param1,param2);
      }
      
      override protected function createClip() : Bundle2PopupClip
      {
         return AssetStorage.rsx.asset_bundle.create(Bundle2PopupClip,"dialog_bundle_resource_4_red");
      }
      
      override protected function initGraphics() : void
      {
         super.initGraphics();
         var _loc1_:RsxGuiAsset = AssetStorage.rsx.getByName("offer_birthday_2018") as RsxGuiAsset;
         if(_loc1_)
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc1_,onDecorLoaded);
         }
      }
      
      protected function onDecorLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:GuiAnimation = new GuiAnimation();
         param1.initGuiClip(_loc2_,"bundle_decor_background");
         _loc2_.graphics.touchable = false;
         addChildAt(_loc2_.graphics,0);
      }
   }
}
