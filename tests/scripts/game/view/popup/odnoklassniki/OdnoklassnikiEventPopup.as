package game.view.popup.odnoklassniki
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.OKSocialFacadeHelper;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.stat.Stash;
   import game.view.popup.ClipBasedPopup;
   
   public class OdnoklassnikiEventPopup extends ClipBasedPopup
   {
      
      public static const ASSET_IDENT:String = "odnoklassniki_sale_banner";
       
      
      private var clip:OdnoklassnikiEventPopupClip;
      
      public function OdnoklassnikiEventPopup(param1:PopupMediator)
      {
         super(param1);
         stashParams.windowName = "odnoklassniki_event_popup";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(OdnoklassnikiEventPopupClip,"dialog_odnoklassniki_event");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc1_:RsxGuiAsset = AssetStorage.rsx.getByName("odnoklassniki_sale_banner") as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc1_,handler_assetLoaded);
         clip.button_close.signal_click.add(close);
         clip.button_to_store.label = Translate.translate("UI_DIALOG_ODNOKLASSNIKI_EVENT_BTN_LABEL");
         clip.button_to_store.signal_click.add(handler_openStore);
      }
      
      private function handler_openStore() : void
      {
         OKSocialFacadeHelper.showPortalPaymentBox();
         close();
         PopupList.instance.dialog_bank(Stash.click("bank",stashParams));
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:GuiClipNestedContainer = param1.create(GuiClipNestedContainer,"SaleActionFullPic");
         clip.postcard_container.container.addChild(_loc2_.graphics);
      }
   }
}
