package engine.core.assets.loading
{
   import com.progrestar.common.Logger;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.io.ResourceReader;
   import engine.core.assets.AssetLoader;
   import engine.core.utils.property.ObjectPropertyWriteable;
   
   public class RsxAssetLoader extends AssetLoaderItem
   {
      
      public static var commonAsset:ObjectPropertyWriteable = new ObjectPropertyWriteable(ClipAsset);
       
      
      private var data:ClipAsset;
      
      private var source:ByteArrayAssetLoader;
      
      private var resourceReader:ResourceReader;
      
      public function RsxAssetLoader(param1:ByteArrayAssetLoader)
      {
         this.source = param1;
         super(param1.file);
      }
      
      override protected function load() : void
      {
         source.progressEvent.addListener(onSourceProgress);
         source.subscribe(onSourceComplete);
      }
      
      override protected function getProgress() : Number
      {
         if(isCompleted)
         {
            return 1;
         }
         return 0.8 * source.progress;
      }
      
      private function onSourceProgress(param1:ByteArrayAssetLoader) : void
      {
         _progressEvent.dispatch();
      }
      
      private function onSourceComplete(param1:ByteArrayAssetLoader) : void
      {
         if(param1.isSuccess)
         {
            resourceReader = new ResourceReader();
            resourceReader.resourceReady.addOnce(onResourceRead);
            resourceReader.resourceError.addOnce(onError);
            AssetLoader.highLoadTasks.doWhenAppropriate(doReadResourceData);
         }
         else
         {
            complete(false);
         }
      }
      
      private function doReadResourceData() : void
      {
         resourceReader.readData(new ClipAsset(source.file.fileName),source.bytes);
      }
      
      private function onResourceRead(param1:ClipAsset) : void
      {
         this.data = param1;
         if(resourceReader.links.length > 0)
         {
            commonAsset.onValue(handler_completeAssetFromCommon);
         }
         onComplete(param1);
      }
      
      private function onComplete(param1:ClipAsset) : void
      {
         this.data = param1;
         source.dispose();
         resourceReader.resourceReady.remove(onComplete);
         resourceReader.resourceError.remove(onError);
         resourceReader.clear();
         resourceReader = null;
         complete(true);
      }
      
      private function onError(param1:String) : void
      {
         source.dispose();
         Logger.getLogger("AssetLoadError").error(source.file.fileName + " : " + param1);
         trace("RsxAsset loader error:",param1);
         resourceReader.resourceReady.remove(onComplete);
         resourceReader.resourceError.remove(onError);
         resourceReader.clear();
         resourceReader = null;
         complete(false);
      }
      
      override protected function unload() : void
      {
         if(isSuccess)
         {
            source.dispose();
            resourceReader = null;
            data = null;
            source = null;
         }
      }
      
      public function get asset() : ClipAsset
      {
         return data;
      }
      
      private function handler_completeAssetFromCommon(param1:ClipAsset) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc6_:int = 0;
         var _loc5_:* = data.clips;
         for each(var _loc4_ in data.clips)
         {
            if(_loc4_.linkSymbol)
            {
               _loc2_ = _loc4_.linkSymbol.slice(_loc4_.linkSymbol.indexOf("@") + 1);
               _loc3_ = param1.getClipByName(_loc2_);
               _loc4_.copyFrom(_loc3_);
               _loc4_.id = _loc3_.id;
               _loc4_.resource = _loc3_.resource;
            }
         }
         commonAsset.unsubscribe(handler_completeAssetFromCommon);
      }
   }
}
