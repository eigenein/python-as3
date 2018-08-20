package engine.core.assets.loading
{
   import com.progrestar.common.Logger;
   import engine.core.utils.Broadcaster;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public final class SWFAssetLoader extends AssetLoaderItem
   {
      
      private static const logger:Logger = Logger.getLogger(SWFAssetLoader);
       
      
      private var _asset:ByteArrayAssetLoader;
      
      private var _loader:Loader;
      
      public function SWFAssetLoader(param1:ByteArrayAssetLoader)
      {
         super(!!param1?param1.file:null);
         if(param1 == null)
         {
            throw new TypeError("Parameter asset must be non null");
         }
         _asset = param1;
         if(_asset.isCompleted && !_asset.isSuccess)
         {
            complete(false);
         }
      }
      
      override protected function load() : void
      {
         _asset.subscribe(onByteArrayLoaded);
      }
      
      override protected function getProgress() : Number
      {
         return _asset.progress;
      }
      
      override public function get progressEvent() : Broadcaster
      {
         return _asset.progressEvent;
      }
      
      private function onByteArrayLoaded(param1:ByteArrayAssetLoader) : void
      {
         var _loc2_:* = null;
         if(param1.isSuccess)
         {
            if(_loader == null)
            {
               _loader = new Loader();
               _loader.contentLoaderInfo.addEventListener("init",onInit);
               _loader.contentLoaderInfo.addEventListener("ioError",onIOError);
               _loc2_ = new LoaderContext(false,ApplicationDomain.currentDomain);
               _loader.loadBytes(_asset.bytes,_loc2_);
            }
         }
         else
         {
            complete(false);
         }
      }
      
      private function onInit(param1:Event) : void
      {
         _loader.contentLoaderInfo.removeEventListener("init",onInit);
         _loader.contentLoaderInfo.removeEventListener("ioError",onIOError);
         var _loc2_:MovieClip = _loader.content as MovieClip;
         if(_loc2_)
         {
            _loc2_.gotoAndStop(1);
            stopAll(_loc2_);
         }
         complete(true);
      }
      
      private function stopAll(param1:MovieClip) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         var _loc3_:int = param1.numChildren;
         _loc4_ = uint(0);
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.getChildAt(_loc4_) as MovieClip;
            if(_loc2_)
            {
               stopAll(_loc2_);
               _loc2_.stop();
            }
            _loc4_++;
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         logger.error("ByteArray не корректный SWF-файл.");
         _loader.contentLoaderInfo.removeEventListener("init",onInit);
         _loader.contentLoaderInfo.removeEventListener("ioError",onIOError);
         complete(false);
      }
      
      override protected function unload() : void
      {
         _loader && _loader.unloadAndStop();
         _loader = null;
         _asset.dispose();
      }
      
      public function get applicationDomain() : ApplicationDomain
      {
         return _loader && _loader.contentLoaderInfo?_loader.contentLoaderInfo.applicationDomain:null;
      }
      
      public function get bytes() : ByteArray
      {
         return _asset.bytes;
      }
      
      public function get content() : *
      {
         return !!_loader?_loader.content:null;
      }
      
      public function toString() : String
      {
         return "[SWF url=\"" + _asset.url + "\"]";
      }
   }
}
