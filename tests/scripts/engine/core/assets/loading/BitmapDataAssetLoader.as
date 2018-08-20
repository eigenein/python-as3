package engine.core.assets.loading
{
   import engine.core.utils.Broadcaster;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.system.LoaderContext;
   
   public class BitmapDataAssetLoader extends AssetLoaderItem
   {
       
      
      private var _source:ByteArrayAssetLoader;
      
      private var _loader:Loader;
      
      private var _bitmapData:BitmapData;
      
      public function BitmapDataAssetLoader(param1:ByteArrayAssetLoader)
      {
         _source = param1;
         super(_source.file);
      }
      
      override protected function load() : void
      {
         _source.subscribe(onSourceComplete);
      }
      
      override public function get progressEvent() : Broadcaster
      {
         return _source.progressEvent;
      }
      
      override protected function getProgress() : Number
      {
         var _loc1_:* = NaN;
         if(isCompleted)
         {
            return 1;
         }
         _loc1_ = 0.8;
         if(_loader == null)
         {
            return _source.progress * _loc1_;
         }
         return _loc1_;
      }
      
      private function onSourceComplete(param1:ByteArrayAssetLoader) : void
      {
         var _loc2_:* = null;
         if(param1.isSuccess)
         {
            _loc2_ = new LoaderContext();
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener("complete",onComplete);
            _loader.contentLoaderInfo.addEventListener("ioError",onIOError);
            _loader.loadBytes(param1.bytes,_loc2_);
         }
         else
         {
            complete(false);
         }
         param1.dispose();
      }
      
      private function onComplete(param1:Event) : void
      {
         _bitmapData = Bitmap(_loader.content).bitmapData.clone();
         _loader.unload();
         _loader.contentLoaderInfo.removeEventListener("complete",onComplete);
         _loader.contentLoaderInfo.removeEventListener("ioError",onIOError);
         complete(true);
      }
      
      private function onIOError(param1:ErrorEvent) : void
      {
         _loader.contentLoaderInfo.removeEventListener("complete",onComplete);
         _loader.contentLoaderInfo.removeEventListener("ioError",onIOError);
         _loader = null;
         complete(false);
      }
      
      override protected function unload() : void
      {
         if(isSuccess)
         {
            _loader.unloadAndStop();
            _bitmapData.dispose();
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
   }
}
