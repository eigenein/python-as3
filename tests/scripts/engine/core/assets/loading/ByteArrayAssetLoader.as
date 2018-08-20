package engine.core.assets.loading
{
   import com.progrestar.common.error.ClientErrorManager;
   import engine.context.GameContext;
   import engine.core.assets.file.AssetFile;
   import engine.core.utils.Broadcaster;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public final class ByteArrayAssetLoader extends AssetLoaderItem
   {
      
      private static var _counterChanged:Broadcaster = new Broadcaster();
      
      private static var _counterLimit:int = 8;
      
      private static var _counter:int;
      
      private static var _loaderPool:Vector.<URLLoader> = new Vector.<URLLoader>();
      
      private static var _attemptMaxNumber:int = 4;
      
      private static var _attemptNumberToBreakCache:int = 2;
       
      
      private var _attemptNumber:int;
      
      private var _request:URLRequest;
      
      private var _loader:URLLoader;
      
      private var _hasValidProgress:Boolean;
      
      public function ByteArrayAssetLoader(param1:AssetFile)
      {
         super(param1);
         _request = !!param1?new URLRequest(param1.url):null;
      }
      
      protected static function getLoaderFromPool() : URLLoader
      {
         if(_loaderPool.length > 0)
         {
            return _loaderPool.pop();
         }
         return new URLLoader();
      }
      
      protected static function addLoaderToPool(param1:URLLoader) : void
      {
         param1.close();
         _loaderPool.push(param1);
      }
      
      override protected function load() : void
      {
         var _loc1_:* = _counter < _counterLimit;
         if(_loc1_)
         {
            tryBeginLoad();
         }
         else
         {
            _counterChanged.addListener(tryBeginLoad);
         }
      }
      
      protected function onURLLoaderProgress(param1:ProgressEvent) : void
      {
         _progressEvent.dispatch();
         _hasValidProgress = true;
      }
      
      private function tryBeginLoad() : void
      {
         if(_counter < _counterLimit)
         {
            _counter = Number(_counter) + 1;
            _counterChanged.removeListener(tryBeginLoad);
            _attemptNumber = Number(_attemptNumber) + 1;
            if(_loader == null)
            {
               _loader = getLoaderFromPool();
               _loader.dataFormat = "binary";
               _loader.addEventListener("complete",onURLLoaderComplete);
               _loader.addEventListener("progress",onURLLoaderProgress);
               _loader.addEventListener("ioError",onURLLoaderError);
               _loader.addEventListener("securityError",onURLLoaderError);
               _hasValidProgress = false;
            }
            _loader.load(_request);
         }
      }
      
      override protected function unload() : void
      {
         bytes && bytes.clear();
         _loader.removeEventListener("complete",onURLLoaderComplete);
         _loader.removeEventListener("progress",onURLLoaderProgress);
         _loader.removeEventListener("ioError",onURLLoaderError);
         _loader.removeEventListener("securityError",onURLLoaderError);
         addLoaderToPool(_loader);
         _loader = null;
      }
      
      protected function breakCache() : void
      {
         var _loc1_:String = file.url;
         var _loc2_:String = String(Math.random());
         if(url.indexOf("?") == -1)
         {
            _loc1_ = _loc1_ + ("?" + _loc2_);
         }
         else
         {
            _loc1_ = _loc1_ + _loc2_;
         }
         _request = new URLRequest(_loc1_);
      }
      
      protected function tryReload() : void
      {
         if(_attemptNumber < _attemptMaxNumber && _attemptNumber > _attemptNumberToBreakCache)
         {
            breakCache();
         }
         if(_attemptNumber >= _attemptMaxNumber)
         {
            ClientErrorManager.action_handleError(new Error("AssetLoad:Failed"),!!bytes?"bytes:" + bytes.length + " file:" + file.size:"no bytes");
         }
      }
      
      private function onURLLoaderComplete(param1:Event) : void
      {
         _counter = Number(_counter) - 1;
         _counterChanged.dispatch();
         _hasValidProgress = true;
         var _loc2_:ByteArray = this.bytes;
         _loc2_ && _loc3_;
         if(_loc2_ == null || file.size > 0 && _loc2_.length != file.size && !GameContext.instance.consoleEnabled || _loc2_.length == 0)
         {
            trace("Вероятно, файл не загружен, или загружен, но неверный");
            tryReload();
         }
         else
         {
            if(_attemptNumber > 1)
            {
               ClientErrorManager.action_handleError(new Error("AssetLoad:Succeeded"),_attemptNumber + " attempt");
            }
            complete(true);
         }
      }
      
      private function onURLLoaderError(param1:Event) : void
      {
         _counter = Number(_counter) - 1;
         _counterChanged.dispatch();
         _hasValidProgress = true;
         tryReload();
      }
      
      override protected function getProgress() : Number
      {
         return _hasValidProgress && _loader && _loader.bytesTotal?_loader.bytesLoaded / _loader.bytesTotal:0;
      }
      
      public function get bytes() : ByteArray
      {
         return !!_loader?_loader.data:null;
      }
      
      public function toString() : String
      {
         return "[ByteArray url=\"" + _request.url + "\"]";
      }
      
      function get url() : String
      {
         return _request.url;
      }
   }
}
