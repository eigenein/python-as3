package engine.context
{
   import com.progrestar.common.lang.Locale;
   import com.progrestar.common.lang.LocaleEnum;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import engine.context.index.AssetIndex;
   import engine.context.platform.PlatformFacade;
   import idv.cjcat.signals.Signal;
   
   public class GameContext
   {
      
      private static var _instance:GameContext;
       
      
      public var libStaticData:Object;
      
      public var localeStaticData:Object;
      
      public var locale:Locale;
      
      public const assetIndex:AssetIndex = new AssetIndex();
      
      public var rpcURL:String;
      
      public var consoleEnabled:Boolean = false;
      
      public var gameURL:String;
      
      public var platformFacade:PlatformFacade;
      
      public const initSuccessSignal:Signal = new Signal();
      
      public const initErrorSignal:Signal = new Signal(String);
      
      public const selectAccountSignal:Signal = new Signal(Array);
      
      public const blockMessageSignal:Signal = new Signal(String);
      
      public function GameContext()
      {
         super();
      }
      
      public static function get instance() : GameContext
      {
         if(!_instance)
         {
            _instance = new GameContext();
         }
         return _instance;
      }
      
      public function get localeID() : String
      {
         if(locale)
         {
            return locale.id;
         }
         return LocaleEnum.ENGLISH.id;
      }
      
      public function applyProxy(param1:GameContextProxy) : void
      {
      }
      
      public function reloadGame() : void
      {
         var _loc1_:* = null;
         if(gameURL)
         {
            _loc1_ = "function getURL() { window.top.location = \'" + gameURL + "\';}";
            ExternalInterfaceProxy.call(_loc1_);
         }
         else
         {
            ExternalInterfaceProxy.call("window.location.reload()");
         }
      }
   }
}
