package game.view.gui.components
{
   import com.progrestar.common.Logger;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.ErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.events.Event;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class CacheImageProxy
   {
      
      private static const _preloaded:Dictionary = new Dictionary();
      
      private static const _loaded:Dictionary = new Dictionary();
      
      public static const instance:CacheImageProxy = new CacheImageProxy();
       
      
      private const logger:Logger = Logger.getLogger(CacheImageProxy);
      
      private var _context:LoaderContext;
      
      private var _contextBytes:LoaderContext;
      
      private var _inited:Boolean;
      
      private var _currLoaderInfo:LoaderInfo;
      
      public function CacheImageProxy()
      {
         super();
         if(instance)
         {
            throw "double alloc";
         }
      }
      
      public function init() : void
      {
         _inited = true;
         _context = new LoaderContext(true);
         _context.allowCodeImport = true;
         _contextBytes = new LoaderContext(false);
         _context.allowCodeImport = true;
      }
      
      public function addImage(param1:String, param2:DisplayObjectContainer = null, param3:Function = null, param4:Boolean = true) : void
      {
         var _loc5_:* = null;
         if(!_inited)
         {
            init();
         }
         var _loc6_:CacheImage = new CacheImage(param1,param2,param3,param4);
         if(_loaded[param1])
         {
            _loc5_ = _loaded[param1] as Texture;
            _loc6_.image = new Image(_loc5_);
            if(_loc6_.image)
            {
               loadingComplete(_loc6_);
            }
            else
            {
               logger.error("CacheImageP addImage can\'t find cached image for path:",param1);
            }
         }
         else
         {
            load(_loc6_);
         }
      }
      
      private function load(param1:CacheImage) : void
      {
         var _loc3_:* = null;
         var _loc2_:URLRequest = new URLRequest(param1.path);
         _loc3_ = new Loader();
         var _loc4_:LoaderInfo = _loc3_.contentLoaderInfo;
         _preloaded[_loc4_] = param1;
         _loc4_.addEventListener("init",handler_init);
         _loc4_.addEventListener("complete",handler_loaderComplete);
         _loc4_.addEventListener("ioError",handler_error);
         _loc4_.addEventListener("securityError",handler_error);
         logger.debug("CacheImageP try to load",param1.path);
         _loc3_.load(_loc2_,_context);
      }
      
      private function unhandle(param1:LoaderInfo) : void
      {
         param1.removeEventListener("complete",handler_loaderComplete);
         param1.removeEventListener("ioError",handler_error);
         param1.removeEventListener("init",handler_init);
      }
      
      private function loadingComplete(param1:CacheImage) : void
      {
         removePreloader(param1);
         if(param1.container)
         {
            param1.container.addChild(param1.image);
         }
         if(param1.onComplete != null)
         {
            param1.onComplete(param1);
         }
      }
      
      private function removePreloader(param1:CacheImage) : void
      {
         if(param1.preloader)
         {
            if(param1.preloader.parent)
            {
               param1.preloader.parent.removeChild(param1.preloader);
            }
            param1.preloader = null;
         }
      }
      
      private function addTextureToCache(param1:BitmapData, param2:CacheImage) : void
      {
         bitmap = param1;
         cache = param2;
         var f:Function = function(param1:Event = null):void
         {
            Starling.current.removeEventListener("context3DCreate",f);
            var _loc2_:Texture = Texture.fromBitmapData(bitmap);
            TextureMemoryManager.add(_loc2_,"CacheImageProxy " + bitmap.width + "x" + bitmap.height);
            _loaded[cache.path] = _loc2_;
            cache.image = new Image(_loc2_);
            loadingComplete(cache);
            logger.debug("CacheImageP image loaded sucessfully",cache.path);
         };
         if(Starling.context.driverInfo == "Disposed")
         {
            Starling.current.addEventListener("context3DCreate",f);
         }
         else
         {
            f();
         }
      }
      
      private function handler_loaderComplete(param1:flash.events.Event) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:LoaderInfo = param1.target as LoaderInfo;
         unhandle(_loc6_);
         var _loc2_:CacheImage = _preloaded[_loc6_];
         delete _preloaded[_loc6_];
         try
         {
            _loc5_ = _loc6_.content as Bitmap;
            this.addTextureToCache(_loc5_.bitmapData.clone(),_loc2_);
            _loc5_.bitmapData.dispose();
            return;
         }
         catch(e:SecurityError)
         {
            logger.error("CacheImageP SecurityError with",!!_loc2_?_loc2_.path:" unknown path "," --trying to get bytes");
            _loc4_ = _loc6_.loader;
            _loc3_ = _loc4_.contentLoaderInfo;
            if(_loc3_.bytes)
            {
               _loc4_.loadBytes(_loc3_.bytes,_contextBytes);
               _loc6_.addEventListener("complete",handler_bytesComplete);
               _loc6_.addEventListener("securityError",handler_bytesSecurityError);
               _preloaded[_loc3_] = _loc2_;
            }
            return;
         }
      }
      
      private function unhandleBytes(param1:LoaderInfo) : void
      {
         param1.removeEventListener("complete",handler_bytesComplete);
         param1.removeEventListener("securityError",handler_bytesSecurityError);
      }
      
      private function onBytesDone(param1:LoaderInfo) : void
      {
         unhandleBytes(param1);
      }
      
      private function handler_bytesComplete(param1:flash.events.Event) : void
      {
         var _loc5_:LoaderInfo = param1.target as LoaderInfo;
         var _loc2_:CacheImage = _preloaded[_loc5_];
         logger.debug("CacheImageP bytes complete for",_loc2_.path);
         onBytesDone(_loc5_);
         var _loc4_:DisplayObject = _loc5_.content as DisplayObject;
         var _loc3_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc3_.draw(_loc4_);
         this.addTextureToCache(_loc3_,_loc2_);
      }
      
      private function handler_bytesSecurityError(param1:SecurityErrorEvent) : void
      {
         var _loc3_:LoaderInfo = param1.target as LoaderInfo;
         var _loc2_:CacheImage = _preloaded[_loc3_];
         logger.error("CacheImageP security error on load bytes",_loc2_.path);
         onBytesDone(_loc3_);
      }
      
      private function handler_init(param1:flash.events.Event) : void
      {
         var _loc3_:LoaderInfo = param1.target as LoaderInfo;
         var _loc2_:CacheImage = _preloaded[_loc3_];
         if(!_loc2_ || !_loc3_)
         {
            return;
         }
         _loc2_.preloader = new Image(Texture.empty(_loc3_.width,_loc3_.height));
         if(_loc2_.container)
         {
            _loc2_.container.addChild(_loc2_.preloader);
         }
      }
      
      private function handler_error(param1:flash.events.Event) : void
      {
         var _loc2_:SecurityErrorEvent = param1 as SecurityErrorEvent;
         var _loc4_:ErrorEvent = param1 as ErrorEvent;
         var _loc5_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:CacheImage = _preloaded[_loc5_];
         logger.error("CacheImageP",!!_loc2_?"security":!!_loc4_?"io":"unknown","error on load",!!_loc3_?_loc3_.path:"--unknown path");
         delete _preloaded[_loc5_];
         unhandle(_loc5_);
      }
   }
}
