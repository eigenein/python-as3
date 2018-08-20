package game.mediator.gui.popup.billing.bundle
{
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.Bundle2Popup;
   
   public class Bundle2PopupMediator extends BundlePopupMediator
   {
       
      
      private var _guiClipAsset:RsxGuiAsset;
      
      private var _clipName:String;
      
      public function Bundle2PopupMediator(param1:Player, param2:RsxGuiAsset, param3:String)
      {
         super(param1);
         _clipName = param3;
         _guiClipAsset = param2;
      }
      
      public function get guiClipAsset() : RsxGuiAsset
      {
         return _guiClipAsset;
      }
      
      public function get clipName() : String
      {
         return _clipName;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new Bundle2Popup(this);
         return _popup;
      }
   }
}
