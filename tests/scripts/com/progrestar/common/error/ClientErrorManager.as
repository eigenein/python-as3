package com.progrestar.common.error
{
   import com.adobe.crypto.MD5;
   import com.progrestar.common.Logger;
   import com.progrestar.common.new_rpc.RpcClientBase;
   import com.progrestar.common.new_rpc.RpcClientErrorEvent;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import engine.loader.ClientVersion;
   import flash.display.DisplayObject;
   import flash.events.UncaughtErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import loader.web.SocialLoader;
   import starling.textures.TextureMemoryManager;
   
   public class ClientErrorManager
   {
      
      private static const MAX_CHARS_IN_ERROR_NAME:int = 37;
      
      private static var _instance:ClientErrorManager;
       
      
      private var _clientErrorDescriptions:Vector.<ClientErrorDescription>;
      
      private var SERVER_URL:String = "http://rpc.url.omg/";
      
      private var _url:String;
      
      private var _appId:String;
      
      private var _userId:String;
      
      private var _networkId:int;
      
      private var _secret:String;
      
      private var _rpcUrl:String;
      
      private var _sessionStateInfoProvider:ISessionStateInfoProvider;
      
      private var _currentRequestData:String;
      
      public function ClientErrorManager()
      {
         super();
         if(_instance != null)
         {
            throw new Error("This is a singleton class. Use \'instance\' property.");
         }
         _instance = this;
      }
      
      public static function get instance() : ClientErrorManager
      {
         if(_instance == null)
         {
            _instance = new ClientErrorManager();
         }
         return _instance;
      }
      
      public static function action_handleError(param1:Error, param2:String = null) : void
      {
         instance.handleError(param1,param2);
      }
      
      private static function errorsAreEqual(param1:ClientErrorDescription, param2:ClientErrorDescription) : Boolean
      {
         if(param1.errorKey != param2.errorKey)
         {
            return false;
         }
         if(param1.request != param2.request)
         {
            return false;
         }
         if(param1.response != param2.response)
         {
            return false;
         }
         return true;
      }
      
      public function init() : void
      {
         Logger.addHandler(onAssetFactoryError,8,"engine.core.assets");
         Logger.addHandler(onClientLoaderFailed,8,SocialLoader);
         Logger.addHandler(onInvalidBattleError,8,"CommandMissionEnd");
         Logger.addHandler(onInvalidTitanBattleError,8,"CommandDungeonEndBattle");
         Logger.addHandler(onInvalidBattleError,8,"CommandBossEndBattle");
         Logger.addHandler(onInvalidBattleError,8,"CommandTowerEndBattle");
         Logger.addHandler(onIvalidArenaBattleError,8,"InvalidArenaReplay");
         Logger.addHandler(onInvalidClanWarBattleError,8,"CommandClanWarEndBattle");
         Logger.addHandler(onHackedBattleError,8,"bCommandMissionEnd");
         Logger.addHandler(onHackedBattleError,8,"bCommandDungeonEndBattle");
         Logger.addHandler(onHackedBattleError,8,"bCommandBossEndBattle");
         Logger.addHandler(onHackedBattleError,8,"bCommandTowerEndBattle");
         Logger.addHandler(onHackedBattleError,8,"bCommandClanWarEndBattle");
         Logger.addHandler(onIncorrectBattleVersionError,8,"IncorrectBattleVersion");
         Logger.addHandler(onDesyncRefillableError,8,"DesyncRefillable");
         Logger.addHandler(onAssetLoadError,8,"AssetLoadError");
         Logger.addHandler(onResetDayError,8,"CommandUserResetDay");
         TextureMemoryManager.signal_error.addOnce(handler_textureError);
         initDuplicateErrorCheck();
      }
      
      public function initRPCClient(param1:RpcClientBase) : void
      {
         param1.addEventListener("ioError",onRPCClientIOError);
         param1.addEventListener("securityError",onRPCClientSecurityError);
      }
      
      public function initGlobalErrorHandler(param1:DisplayObject) : void
      {
         param1.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError",onUncaughtErrorEvent);
      }
      
      public function addSessionStateInfoProvider(param1:ISessionStateInfoProvider) : void
      {
         _sessionStateInfoProvider = param1;
      }
      
      public function setCurrentRequestData(param1:String) : void
      {
         _currentRequestData = param1;
      }
      
      private function onUncaughtErrorEvent(param1:UncaughtErrorEvent) : void
      {
         try
         {
            ExternalInterfaceProxy.call("console.log","UncaughtErrorEvent");
         }
         catch(error:Error)
         {
         }
         handleError(param1.error as Error);
      }
      
      private function handleError(param1:Error, param2:String = null) : void
      {
         var _loc3_:* = null;
         ExternalInterfaceProxy.call("console.log","handleError");
         var _loc5_:String = param1.message;
         if(param1 is RangeError && param1.errorID == 1125)
         {
            _loc5_ = "RangeError: Error #1125 The index is out of range";
         }
         if(_loc5_)
         {
            if(_loc5_.lastIndexOf(".") == _loc5_.length - 1)
            {
               _loc5_ = _loc5_.slice(0,_loc5_.length - 1);
            }
            if(_loc5_.length > 37)
            {
               _loc5_ = _loc5_.slice(0,37) + "...";
            }
         }
         if(param2)
         {
            _loc3_ = param2;
         }
         else
         {
            _loc3_ = param1.getStackTrace();
         }
         if(_currentRequestData)
         {
            _loc3_ = _loc3_ + ("\n\nResponse:\n" + _currentRequestData);
         }
         if(_loc3_.length + _loc5_.length > 4800)
         {
            _loc3_ = _loc3_.slice(0,4800 - _loc5_.length);
         }
         var _loc4_:ClientErrorDescription = new ClientErrorDescription(_loc5_,"",_loc3_);
         sendErrorDescription(_loc4_);
      }
      
      private function onAssetFactoryError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("McFactory:Failed",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onClientLoaderFailed(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("AssetLoad:Failed",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onInvalidBattleError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("PVE:InvalidBattle",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onInvalidTitanBattleError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("PVE:InvalidTitanBattle",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onInvalidClanWarBattleError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("PVP:InvalidClanWarBattle",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onIvalidArenaBattleError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("PVP:InvalidArenaBattle",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onHackedBattleError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("PVE:HackedBattle",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onIncorrectBattleVersionError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("PVE:IncorrectVersion",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onDesyncRefillableError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("Desync:Refillable",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onAssetLoadError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("AssetLoad:Error",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function handler_textureError(param1:int, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 4000;
         var _loc4_:ClientErrorDescription = new ClientErrorDescription("Texture Error #" + param1,null,param2.slice(0,4000));
         sendErrorDescription(_loc4_);
      }
      
      private function onResetDayError(param1:String) : void
      {
         var _loc2_:ClientErrorDescription = new ClientErrorDescription("RPCClient:ResetDayError",param1,null);
         sendErrorDescription(_loc2_);
      }
      
      private function onRPCClientIOError(param1:RpcClientErrorEvent) : void
      {
         var _loc2_:* = null;
         if(param1.rpcEntryBase.response == null)
         {
            _loc2_ = null;
         }
         else if(param1.rpcEntryBase.response.body is String)
         {
            _loc2_ = param1.rpcEntryBase.response.body as String;
         }
         else
         {
            _loc2_ = JSON.stringify(param1.rpcEntryBase.response.body);
         }
         var _loc3_:ClientErrorDescription = new ClientErrorDescription("RPCClient:IOError",param1.rpcEntryBase.request.name + " " + param1.rpcEntryBase.request.getFormattedData(),_loc2_);
         sendErrorDescription(_loc3_);
      }
      
      private function onRPCClientSecurityError(param1:RpcClientErrorEvent) : void
      {
         var _loc2_:String = param1.rpcEntryBase.response.body is String?param1.rpcEntryBase.response.body as String:JSON.stringify(param1.rpcEntryBase.response.body);
         var _loc3_:ClientErrorDescription = new ClientErrorDescription("RPCClient:SecurityError",param1.rpcEntryBase.request.name + " " + param1.rpcEntryBase.request.getFormattedData(),_loc2_);
         sendErrorDescription(_loc3_);
      }
      
      private function createShortSessionState(param1:ClientErrorDescription) : String
      {
         var _loc2_:String = "#" + param1.numInSession;
         if(_sessionStateInfoProvider != null)
         {
            _loc2_ = _loc2_ + (" " + _sessionStateInfoProvider.getState());
         }
         return _loc2_;
      }
      
      private function sendErrorDescription(param1:ClientErrorDescription) : void
      {
         if(isDuplicate(param1))
         {
            return;
         }
         var _loc2_:Object = {};
         _loc2_["url"] = SERVER_URL;
         _loc2_["status"] = 0;
         _loc2_["fversion"] = Capabilities.version;
         _loc2_["appversion"] = String(ClientVersion.version).slice(ClientVersion.version.length - 32);
         _loc2_["errorKey"] = param1.errorKey;
         _loc2_["request"] = !!param1.request?param1.request:createShortSessionState(param1);
         _loc2_["response"] = param1.response;
         if(_url != null)
         {
            sendErrorDescriptionURL(_loc2_);
         }
         else
         {
            sendErrorDescriptionEI(_loc2_);
         }
      }
      
      public function initNetworkData(param1:String, param2:String, param3:String, param4:int, param5:String) : void
      {
         _url = param1;
         _rpcUrl = param2;
         _appId = param3.replace(/\./g,"/");
         _networkId = param4;
         _secret = param5;
      }
      
      public function setUserId(param1:String) : void
      {
         _userId = param1;
      }
      
      private function sendErrorDescriptionURL(param1:Object) : void
      {
         try
         {
            ExternalInterfaceProxy.call("console.log","sendErrorDescriptionURL");
            ExternalInterfaceProxy.call("console.log",JSON.stringify(JSON.stringify(param1)));
         }
         catch(error:Error)
         {
         }
         var _loc2_:URLRequest = new URLRequest(_url);
         _loc2_.method = "POST";
         param1["url"] = _rpcUrl;
         param1["app_id"] = _appId;
         if(_userId != null)
         {
            param1["user_id"] = _userId;
            param1["secret"] = MD5.hash(_secret + _userId);
         }
         param1["network_id"] = _networkId;
         var _loc4_:URLVariables = new URLVariables();
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for(var _loc5_ in param1)
         {
            _loc4_[_loc5_] = param1[_loc5_];
         }
         _loc2_.data = _loc4_;
         trace("ClientErrorManager::sendErrorDescriptionURL"," url=",param1["url"]," app_id=",param1["app_id"]," user_id=",param1["user_id"]," network_id=",param1["network_id"]," errorKey=",param1["errorKey"]," request=",param1["request"]," response=",param1["response"]);
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.load(_loc2_);
      }
      
      private function sendErrorDescriptionEI(param1:Object) : void
      {
         if(!ExternalInterfaceProxy.available)
         {
            return;
         }
         try
         {
            ExternalInterfaceProxy.call("console.log","sendErrorDescriptionEI1");
            ExternalInterfaceProxy.call("console.log",JSON.stringify(param1).substr(0,1000));
            ExternalInterfaceProxy.call("console.log","sendErrorDescriptionEI2");
            ExternalInterfaceProxy.call("progrestar.getModule(\'errord\').send",param1);
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
      
      private function initDuplicateErrorCheck() : void
      {
         _clientErrorDescriptions = new Vector.<ClientErrorDescription>();
      }
      
      private function isDuplicate(param1:ClientErrorDescription) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _clientErrorDescriptions;
         for each(var _loc2_ in _clientErrorDescriptions)
         {
            if(errorsAreEqual(param1,_loc2_))
            {
               return true;
            }
         }
         _clientErrorDescriptions.push(param1);
         return false;
      }
   }
}
