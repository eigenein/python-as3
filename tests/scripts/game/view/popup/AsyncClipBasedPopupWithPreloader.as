package game.view.popup
{
   import avmplus.getQualifiedClassName;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetDisposingWatcher;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupMediator;
   import game.view.gui.components.ClipProgressBar;
   
   public class AsyncClipBasedPopupWithPreloader extends AsyncClipBasedPopup
   {
       
      
      protected var progressbar:ClipProgressBar;
      
      protected var assetProgress:AssetProgressProvider;
      
      public function AsyncClipBasedPopupWithPreloader(param1:PopupMediator, param2:RsxGuiAsset)
      {
         super(param1,param2);
         AssetDisposingWatcher.watch(this,getQualifiedClassName(this));
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:RequestableAsset = this.progressAsset;
         if(_loc1_ && !_loc1_.completed)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(_loc1_);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      override protected function handler_assetLoaded(param1:RequestableAsset) : void
      {
         if(_isDisposed)
         {
            return;
         }
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         onAssetLoaded(this.asset);
      }
      
      protected function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
   }
}
