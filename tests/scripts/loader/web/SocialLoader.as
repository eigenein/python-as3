package loader.web
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.error.ClientErrorManager;
   import com.progrestar.common.lang.Locale;
   import com.progrestar.common.lang.LocaleEnum;
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import engine.context.GameContext;
   import engine.core.assets.loading.SWFAssetLoader;
   import engine.core.utils.thread.AssetLoaderThread;
   import engine.core.utils.thread.Thread;
   import engine.core.utils.thread.ThreadQueue;
   import engine.loader.PreloaderView;
   import engine.loader.thread.AssetLoaderThreadQueue;
   import engine.loader.thread.LibLoaderThread;
   import engine.loader.thread.LocaleLoaderThread;
   import engine.loader.thread.PlatformInitThread;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import loader.web.util.MouseWheelLinuxFix;
   
   public class SocialLoader extends VersionedClientLoader
   {
      
      protected static const _logger:Logger = Logger.getLogger(SocialLoader);
       
      
      protected var gameLoaderThread:AssetLoaderThread;
      
      protected var preloaderView:PreloaderView;
      
      protected var mainQueue:ThreadQueue;
      
      protected var mandatoryAssetLoaderThread:AssetLoaderThreadQueue;
      
      protected var PRELOADER_NAME:String;
      
      private var _stat_lastDecimalProgress:int;
      
      private var _stat_loadStartTimer:int;
      
      public function SocialLoader()
      {
         var _loc1_:* = null;
         super();
         _stat_loadStartTimer = getTimer();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         addEventListener("addedToStage",handler_addedToStage);
         if(Capabilities.playerType == "StandAlone" && stage)
         {
            _loc1_ = new TextField();
            _loc1_.text = !!GameContext.instance.consoleEnabled?"debug":"release";
            _loc1_.height = 25;
            _loc1_.width = 500;
            stage.addChild(_loc1_);
         }
      }
      
      protected function create_platformInitThread(param1:Object) : PlatformInitThread
      {
         throw new Error("create_platformInitThread should be overridden");
      }
      
      protected function create_localeID(param1:String) : Locale
      {
         var _loc2_:* = null;
         if(param1 != "ru")
         {
            var _loc3_:* = param1;
            if("it" !== _loc3_)
            {
               if("fr" !== _loc3_)
               {
                  if("de" !== _loc3_)
                  {
                     if("es" !== _loc3_)
                     {
                        if("zh" !== _loc3_)
                        {
                           if("zh-tw" !== _loc3_)
                           {
                              if("zh-cn" !== _loc3_)
                              {
                                 _loc2_ = LocaleEnum.ENGLISH;
                                 Translate.init(LocaleEnum.ENGLISH);
                              }
                              else
                              {
                                 _loc2_ = LocaleEnum.CHINESE_CN;
                                 Translate.init(LocaleEnum.CHINESE_CN);
                              }
                           }
                        }
                        _loc2_ = LocaleEnum.CHINESE_TW;
                        Translate.init(LocaleEnum.CHINESE_TW);
                     }
                     else
                     {
                        _loc2_ = LocaleEnum.SPANISH;
                        Translate.init(LocaleEnum.SPANISH);
                     }
                  }
                  else
                  {
                     _loc2_ = LocaleEnum.GERMAN;
                     Translate.init(LocaleEnum.GERMAN);
                  }
               }
               else
               {
                  _loc2_ = LocaleEnum.FRENCH;
                  Translate.init(LocaleEnum.FRENCH);
               }
            }
            else
            {
               _loc2_ = LocaleEnum.ITALIAN;
               Translate.init(LocaleEnum.ITALIAN);
            }
            return _loc2_;
         }
         Translate.init(LocaleEnum.RUSSIAN);
         return LocaleEnum.RUSSIAN;
      }
      
      protected function create_preloaderName(param1:String) : String
      {
         var _loc2_:* = null;
         if(param1 == "ru")
         {
            _loc2_ = "preloader_ru.swf";
         }
         else
         {
            _loc2_ = "preloader_en.swf";
         }
         return _loc2_;
      }
      
      private function sendProgressStat(param1:int) : void
      {
         var _loc2_:int = param1 / 10;
         while(_stat_lastDecimalProgress < _loc2_)
         {
            _stat_lastDecimalProgress = Number(_stat_lastDecimalProgress) + 1;
            stat("PROGRESS","global",(_stat_lastDecimalProgress * 10).toString(),null,"progress");
         }
      }
      
      private function stat(param1:String, param2:String, param3:String = null, param4:Array = null, param5:String = null) : void
      {
      }
      
      protected function handler_addedToStage(param1:Event) : void
      {
         ClientErrorManager.instance.init();
         ClientErrorManager.instance.initGlobalErrorHandler(this.parent);
         var _loc2_:Object = stage.loaderInfo.parameters;
         var _loc5_:Locale = create_localeID(stage.loaderInfo.parameters.interface_lang);
         PRELOADER_NAME = create_preloaderName(_loc5_.id);
         new MouseWheelLinuxFix(stage);
         GameContext.instance.gameURL = stage.loaderInfo.parameters.game_url;
         GameContext.instance.locale = _loc5_;
         GameContext.instance.rpcURL = stage.loaderInfo.parameters.rpc_url != null?stage.loaderInfo.parameters.rpc_url:"http://dev.nexters.com/dev/heroes/trunk/";
         var _loc6_:AssetLoaderThread = new AssetLoaderThread(GameContext.instance.assetIndex.getAssetFile(PRELOADER_NAME));
         _loc6_.eventComplete.add(hanlder_preloaderViewLoaded);
         var _loc3_:PlatformInitThread = create_platformInitThread(_loc2_);
         _loc3_.eventComplete.add(handler_platformInitThreadComplete);
         var _loc4_:LibLoaderThread = new LibLoaderThread(GameContext.instance.assetIndex.getLibFile());
         _loc4_.eventComplete.add(handler_libLoaded);
         var _loc7_:LocaleLoaderThread = new LocaleLoaderThread(GameContext.instance.assetIndex.getLocaleURL(_loc5_.id));
         _loc7_.eventComplete.add(handler_localeLoaded);
         gameLoaderThread = new AssetLoaderThread(GameContext.instance.assetIndex.getAssetFile("heroes.swf"));
         gameLoaderThread.eventComplete.add(handler_gameLoaded);
         mandatoryAssetLoaderThread = new AssetLoaderThreadQueue(5);
         mainQueue = new ThreadQueue();
         mainQueue.addThread(_loc6_);
         mainQueue.addThread(_loc3_);
         mainQueue.addThread(_loc4_);
         mainQueue.addThread(_loc7_);
         mainQueue.addThread(mandatoryAssetLoaderThread);
         mainQueue.addThread(gameLoaderThread);
         mainQueue.eventError.add(handler_queueError);
         mainQueue.eventProgress.add(handler_queueProgress);
         mainQueue.eventComplete.add(handler_loadQueueComplete);
         mainQueue.run();
      }
      
      private function hanlder_preloaderViewLoaded(param1:Thread) : void
      {
         dispatchEvent(new Event("EVENT_GRAPHICS_READY",true));
         var _loc2_:Class = ((param1 as AssetLoaderThread).asset as SWFAssetLoader).applicationDomain.getDefinition("loader") as Class;
         preloaderView = new PreloaderView(null,new _loc2_() as MovieClip);
         addChild(preloaderView);
      }
      
      private function handler_libLoaded(param1:Thread) : void
      {
         GameContext.instance.libStaticData = (param1 as LibLoaderThread).data;
         GameContext.instance.assetIndex.initLibStaticData((param1 as LibLoaderThread).data.asset);
         mandatoryAssetLoaderThread.loadFiles(GameContext.instance.assetIndex.getMandatoryAssets());
      }
      
      private function handler_localeLoaded(param1:Thread) : void
      {
         GameContext.instance.localeStaticData = (param1 as LocaleLoaderThread).data;
      }
      
      protected function handler_platformInitThreadComplete(param1:Thread) : void
      {
      }
      
      private function handler_gameLoaded(param1:Thread) : void
      {
      }
      
      private function handler_queueError(param1:Thread) : void
      {
      }
      
      private function handler_queueProgress(param1:Thread) : void
      {
         var _loc2_:int = mainQueue.progressCurrent / mainQueue.progressTotal * 100;
         if(preloaderView)
         {
            preloaderView.update(_loc2_);
         }
         sendProgressStat(_loc2_);
      }
      
      private function handler_loadQueueComplete(param1:Thread) : void
      {
         var _loc3_:* = (gameLoaderThread.asset as SWFAssetLoader).content;
         addChild(_loc3_ as Sprite);
         ClientErrorManager.instance.initGlobalErrorHandler(_loc3_);
         GameContext.instance.initSuccessSignal.add(handler_gameRunSuccess);
         GameContext.instance.initErrorSignal.add(handler_gameRunError);
         sendProgressStat(100);
         var _loc2_:Number = (getTimer() - _stat_loadStartTimer) / 1000;
         stat("loading","time",String(_loc2_));
         trace("loadingTime:",_loc2_);
         _loc3_.run(GameContext.instance);
      }
      
      private function handler_gameRunSuccess() : void
      {
         if(preloaderView)
         {
            removeChild(preloaderView);
            preloaderView = null;
         }
      }
      
      private function handler_gameRunError(param1:String) : void
      {
         try
         {
            ExternalInterfaceProxy.call("console.log","rpcInitError::" + param1);
         }
         catch(error:Error)
         {
         }
         preloaderView.displayError(param1);
         _logger.error(param1);
      }
   }
}
