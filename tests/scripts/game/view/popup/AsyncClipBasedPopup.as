package game.view.popup
{
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupMediator;
   
   public class AsyncClipBasedPopup extends ClipBasedPopup
   {
       
      
      protected var asset:RsxGuiAsset;
      
      public function AsyncClipBasedPopup(param1:PopupMediator, param2:RsxGuiAsset)
      {
         super(param1);
         this.asset = param2;
         if(param2 != null)
         {
            param2.addUsage();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         if(asset != null)
         {
            asset.dropUsage();
         }
      }
      
      protected function get progressAsset() : RequestableAsset
      {
         return asset;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(progressAsset)
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(progressAsset,handler_assetLoaded);
         }
         else
         {
            handler_assetLoaded(null);
         }
      }
      
      protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
      }
      
      protected function handler_assetLoaded(param1:RequestableAsset) : void
      {
         onAssetLoaded(this.asset);
      }
   }
}
