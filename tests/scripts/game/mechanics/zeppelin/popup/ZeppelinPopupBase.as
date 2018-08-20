package game.mechanics.zeppelin.popup
{
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ZeppelinPopupBase extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var _progressAsset:RequestableAsset;
      
      public function ZeppelinPopupBase(param1:PopupMediator, param2:RsxGuiAsset)
      {
         super(param1,param2);
         var _loc3_:AssetList = new AssetList();
         _loc3_.addAssets(AssetStorage.rsx.dialog_zeppelin,AssetStorage.rsx.dialog_expedition,AssetStorage.rsx.dialog_artifact_subscription,AssetStorage.rsx.dialog_artifact_chest,AssetStorage.rsx.artifact_graphics,AssetStorage.rsx.artifact_icons_large);
         _progressAsset = _loc3_;
         AssetStorage.instance.globalLoader.requestAsset(_loc3_);
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
   }
}
