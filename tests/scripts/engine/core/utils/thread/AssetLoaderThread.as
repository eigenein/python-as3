package engine.core.utils.thread
{
   import com.progrestar.common.util.assert;
   import engine.core.assets.file.AssetFile;
   import engine.core.assets.loading.AssetLoaderItem;
   
   public class AssetLoaderThread extends Thread
   {
       
      
      private var loader:AssetLoaderItem;
      
      private var _file:AssetFile;
      
      public function AssetLoaderThread(param1:AssetFile)
      {
         assert(param1);
         this._file = param1;
         super();
      }
      
      public function get file() : AssetFile
      {
         return _file;
      }
      
      public function get fileName() : String
      {
         return !!_file?_file.fileName:null;
      }
      
      public function get asset() : AssetLoaderItem
      {
         return loader;
      }
      
      override public function run() : void
      {
         loader = _file.getLoader();
         loader.progressEvent.addListener(progressListener);
         loader.subscribe(assetLoaded);
         eventProgress.dispatch(this);
      }
      
      override public function get progressCurrent() : uint
      {
         if(loader)
         {
            return loader.progress * file.size;
         }
         return 0;
      }
      
      override public function get progressTotal() : uint
      {
         return file.size;
      }
      
      protected function progressListener(param1:AssetLoaderItem) : void
      {
         eventProgress.dispatch(this);
      }
      
      protected function assetLoaded(param1:AssetLoaderItem) : void
      {
         if(param1.isSuccess)
         {
            eventComplete.dispatch(this);
         }
         else
         {
            eventError.dispatch(this);
         }
      }
   }
}
