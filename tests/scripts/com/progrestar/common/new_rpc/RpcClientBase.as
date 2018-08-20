package com.progrestar.common.new_rpc
{
   import by.blooddy.crypto.MD5;
   import engine.loader.ClientVersion;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RpcClientBase extends EventDispatcher
   {
       
      
      protected var sessionKey:String;
      
      public var LOG_ERRORS:Boolean = false;
      
      public var LOG_SECRET:String;
      
      public var LOG_API_URL:String;
      
      public var STAT_API_URL:String;
      
      protected var statTimer:Timer;
      
      protected var statLastSendTime:uint;
      
      protected var STAT_SECOND_INTERVAL:int = 5;
      
      protected var statQueue:Array;
      
      protected var initializer:RPCClientInitializerParams;
      
      private var unionRequestID:int = 0;
      
      public var networkErrorHandler:Function;
      
      public var invalidSignatureErrorHandler:Function;
      
      public function RpcClientBase(param1:RPCClientInitializerParams)
      {
         statQueue = [];
         super();
         this.initializer = param1;
      }
      
      protected function createAndSendRequest(param1:RpcRequestBase, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:RpcEntryBase = createRequest(param1,param2,param3,param4);
         sendEntry(_loc5_);
      }
      
      protected function createRequest(param1:RpcRequestBase, param2:Function = null, param3:Function = null, param4:Function = null) : RpcEntryBase
      {
         var _loc5_:RpcEntryBase = new RpcEntryBase();
         _loc5_.request = param1;
         _loc5_.infoHandler = param3;
         _loc5_.responseCallback = param2;
         _loc5_.errorHandler = param4;
         return _loc5_;
      }
      
      protected function sendEntry(param1:RpcEntryBase) : void
      {
         requestObject = param1;
         _serverResponseHandler = function(param1:Event):void
         {
            var _loc3_:URLLoader = param1.target as URLLoader;
            var _loc2_:String = _loc3_.data as String;
            trace("RpcClientBase::_serverResponseHandler"," time=",(getTimer() - time) / 1000," sent=",sent," responseSize=",_loc2_.length);
            _loader.destroy();
            onConnectionCompleteHandler(requestObject);
            serverResponseHandler(_loc2_,requestObject);
         };
         _networkErrorHandler = function(param1:ErrorEvent):void
         {
            trace("[Network error]",param1.text," time=",(getTimer() - time) / 1000);
            _loader.destroy();
            onConnectionCompleteHandler(requestObject);
            logError(requestObject,param1);
         };
         _onIOErrorEvent = function(param1:Event):void
         {
            dispatchEvent(new RpcClientErrorEvent("ioError",requestObject));
         };
         _onStatusEvent = function(param1:Event):void
         {
         };
         _onSecurityErrorEvent = function(param1:Event):void
         {
            dispatchEvent(new RpcClientErrorEvent("securityError",requestObject));
         };
         var request:URLRequest = new URLRequest(initializer.url);
         request.method = "POST";
         var time:int = getTimer();
         requestObject.timestamp = time;
         addBody(request,requestObject);
         addHeaders(request,requestObject);
         var _loader:RPCURLLoader = new RPCURLLoader();
         _loader.completed.add(_serverResponseHandler);
         _loader.ioErrorThrown.add(_networkErrorHandler);
         _loader.ioErrorThrown.add(_onIOErrorEvent);
         _loader.securityErrorThrown.add(_networkErrorHandler);
         _loader.securityErrorThrown.add(_onSecurityErrorEvent);
         _loader.statusEvent.add(_onStatusEvent);
         _loader.load(request);
         var sent:int = (request.data as String).length;
      }
      
      protected function addBody(param1:URLRequest, param2:RpcEntryBase) : void
      {
         param1.data = param2.request.getFormattedData();
      }
      
      protected function createHeaders(param1:RpcEntryBase) : Object
      {
         var _loc2_:String = initializer.network_session_key;
         unionRequestID = unionRequestID + 1;
         var _loc3_:Object = {
            "Content-Type":"application/json; charset=UTF-8",
            "X-Request-Id":unionRequestID + 1,
            "X-Auth-Network-Ident":initializer.network_ident,
            "X-Auth-Application-Id":initializer.application_id,
            "X-Auth-Session-Id":initializer.client_session_key
         };
         if(initializer.user_id != null)
         {
            _loc3_["X-Auth-User-Id"] = initializer.user_id;
         }
         if(initializer.player_id != null)
         {
            _loc3_["X-Auth-Player-Id"] = initializer.player_id;
         }
         if(_loc2_ != null)
         {
            _loc3_["X-Auth-Session-Key"] = _loc2_;
         }
         var _loc4_:Object = param1.headers;
         if(_loc4_ != null)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for(var _loc5_ in _loc4_)
            {
               _loc3_[_loc5_] = _loc4_[_loc5_];
            }
         }
         return _loc3_;
      }
      
      protected function createAuthSignature(param1:Object, param2:RpcEntryBase) : ByteArray
      {
         var _loc3_:* = null;
         var _loc4_:Object = param2.request.getFormattedData();
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeUTFBytes(param1["X-Request-Id"]);
         _loc5_.writeUTFBytes(":");
         _loc5_.writeUTFBytes(initializer.auth_key);
         _loc5_.writeUTFBytes(":");
         _loc5_.writeUTFBytes(param1["X-Auth-Session-Id"]);
         _loc5_.writeUTFBytes(":");
         if(_loc4_ is ByteArray)
         {
            _loc3_ = _loc4_ as ByteArray;
            _loc3_.position = 0;
            _loc5_.writeBytes(_loc3_,0,_loc3_.length);
         }
         else if(_loc4_ is String)
         {
            _loc5_.writeUTFBytes(_loc4_ as String);
         }
         _loc5_.writeUTFBytes(":");
         _loc5_.writeUTFBytes(createFingerprint(param1));
         return _loc5_;
      }
      
      private function createFingerprint(param1:Object) : String
      {
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         var _loc2_:String = "";
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for(var _loc6_ in param1)
         {
            if(_loc6_.indexOf("X-Env") != -1)
            {
               _loc7_ = _loc6_.substr(6);
               _loc4_.push({
                  "key":_loc7_.toUpperCase(),
                  "value":param1[_loc6_]
               });
            }
         }
         _loc4_.sort(sort_onKey);
         var _loc3_:int = _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc2_ + (_loc4_[_loc5_].key + "=" + _loc4_[_loc5_].value);
            _loc5_++;
         }
         return _loc2_;
      }
      
      protected function sort_onKey(param1:Object, param2:Object) : int
      {
         if(param1.key > param2.key)
         {
            return 1;
         }
         if(param1.key < param2.key)
         {
            return -1;
         }
         return 0;
      }
      
      protected function addHeaders(param1:URLRequest, param2:RpcEntryBase) : void
      {
         var _loc3_:Object = getCompletedHeaders(param2);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for(var _loc4_ in _loc3_)
         {
            param1.requestHeaders.push(new URLRequestHeader(_loc4_.toString(),_loc3_[_loc4_].toString()));
         }
      }
      
      protected function getCompletedHeaders(param1:RpcEntryBase) : Object
      {
         var _loc2_:Object = createHeaders(param1);
         var _loc3_:ByteArray = createAuthSignature(_loc2_,param1);
         _loc2_["X-Auth-Signature"] = MD5.hashBytes(_loc3_);
         return _loc2_;
      }
      
      protected function serverResponseHandler(param1:String, param2:RpcEntryBase) : void
      {
         param2.response = createResponse(param1);
         if(param2.response.error != null)
         {
            if(param2.response.error.name == "invalid_signature")
            {
               invalidSignatureErrorHandler && invalidSignatureErrorHandler(param2);
            }
            else
            {
               param2.errorHandler && param2.errorHandler(param2);
            }
            logError(param2);
         }
         else
         {
            currentResponseHandler(param2);
         }
      }
      
      protected function onConnectionCompleteHandler(param1:RpcEntryBase) : void
      {
         if(param1.responseCallback != null)
         {
            param1.responseCallback(param1);
         }
      }
      
      protected function currentResponseHandler(param1:RpcEntryBase) : void
      {
      }
      
      protected function createResponse(param1:String) : RpcResponseBase
      {
         return new RpcResponseBase(param1);
      }
      
      protected function logError(param1:RpcEntryBase, param2:Event = null, param3:Object = null) : void
      {
         r = param1;
         event = param2;
         args = param3;
         ioError = function(param1:IOErrorEvent):void
         {
         };
         if(initializer.log_errors == false)
         {
            return;
         }
         if(LOG_SECRET == null)
         {
            LOG_SECRET = initializer.log_secret;
         }
         if(LOG_API_URL == null)
         {
            LOG_API_URL = initializer.log_api_url;
         }
         if(LOG_SECRET == null)
         {
            return;
            §§push(trace("Log api secret key not assigned"));
         }
         else if(LOG_API_URL == null)
         {
            return;
            §§push(trace("Log api url not assigned"));
         }
         else
         {
            var request:Object = null;
            var response:Object = null;
            var errorType:String = null;
            var status:int = 200;
            if(r.request.body)
            {
               try
               {
                  request = r.request.name + " " + r.request.getFormattedData();
               }
               catch(err:Error)
               {
                  request = "JSON parsing error";
               }
            }
            if(event && event.type != "complete")
            {
               var match:Array = event is ErrorEvent?(event as ErrorEvent).text.match(/\d+/):null;
               status = !!match?parseInt(match[0]):0;
               var eventTarget:Object = event.target;
               response = eventTarget && eventTarget.hasOwnProperty("data") && eventTarget.data != null?"{\"responseText\":\"" + escape(eventTarget.data) + "\"}":JSON.stringify(event);
               if(event is IOErrorEvent)
               {
                  errorType = "ioError";
               }
               if(event is SecurityErrorEvent)
               {
                  errorType = "securityError";
               }
            }
            else if(r.response.body)
            {
               var responseObj:Object = r.response.body;
               var parsingSuccess:Boolean = false;
               if(responseObj is String)
               {
                  response = "{\"responseText\":\"" + escape(responseObj as String) + "\"}";
                  errorType = "string";
               }
               else
               {
                  response = {};
                  var _loc8_:int = 0;
                  var _loc7_:* = responseObj;
                  for(s in responseObj)
                  {
                     response[s] = responseObj[s];
                     parsingSuccess = true;
                  }
                  if(parsingSuccess)
                  {
                     errorType = response != null && response.error != null?response.error.name:"object";
                     response = createErrorResponse(response);
                  }
                  else
                  {
                     response = null;
                  }
               }
            }
            var urlLoader:URLLoader = new URLLoader();
            var urlRequest:URLRequest = new URLRequest(LOG_API_URL);
            urlRequest.method = "POST";
            var v:URLVariables = new URLVariables();
            v["app_id"] = initializer.application_id;
            v["user_id"] = initializer.user_id;
            v["url"] = initializer.url;
            v["secret"] = MD5.hash(LOG_SECRET + v["user_id"]);
            v["network_id"] = initializer.network_ident;
            v["request"] = request == null || request is String && String(request).length == 0?"{\"text\":null}":request;
            v["response"] = response == null || response is String && String(response).length == 0?"{\"text\":null}":response;
            v["error_type"] = errorType;
            v["status"] = status;
            v["fversion"] = Capabilities.version;
            v["appversion"] = ClientVersion.version;
            v["rpc"] = 1;
            if(args)
            {
               if(args.hasOwnProperty("url"))
               {
                  v["url"] = args.url;
               }
               if(args.hasOwnProperty("error_type"))
               {
                  v["error_type"] = args.error_type;
               }
            }
            urlRequest.data = v;
            urlLoader.addEventListener("ioError",ioError);
            urlLoader.addEventListener("networkError",ioError);
            urlLoader.addEventListener("diskError",ioError);
            urlLoader.addEventListener("verifyError",ioError);
            urlLoader.load(urlRequest);
            return;
         }
      }
      
      protected function createErrorResponse(param1:Object) : String
      {
         return JSON.stringify(param1);
      }
      
      private function checkErrorSystem() : Boolean
      {
         if(initializer.log_client_errors == false)
         {
            return false;
         }
         if(LOG_SECRET == null)
         {
            LOG_SECRET = initializer.log_secret;
         }
         if(LOG_API_URL == null)
         {
            LOG_API_URL = initializer.log_api_url;
         }
         if(LOG_SECRET == null)
         {
            trace("Log api secret key not assigned");
            return false;
         }
         if(LOG_API_URL == null)
         {
            trace("Log api url not assigned");
            return false;
         }
         return true;
      }
      
      protected function logClientError(param1:String, param2:Boolean = false) : void
      {
         if(!checkErrorSystem())
         {
            return;
         }
         var _loc4_:String = createErrorResponse({"text":param1});
         var _loc5_:String = !!param2?"StackTracedClientError":"ClientError";
         var _loc3_:String = null;
         sendError(_loc4_,_loc5_,_loc3_);
      }
      
      private function sendError(param1:String, param2:String, param3:String) : void
      {
         response = param1;
         error_type = param2;
         request_type = param3;
         ioError = function(param1:IOErrorEvent):void
         {
         };
         var urlLoader:URLLoader = new URLLoader();
         var urlRequest:URLRequest = new URLRequest(LOG_API_URL);
         urlRequest.method = "POST";
         var v:URLVariables = new URLVariables();
         v["app_id"] = initializer.application_id;
         v["user_id"] = initializer.user_id;
         v["url"] = initializer.url;
         v["secret"] = MD5.hash(LOG_SECRET + v["user_id"]);
         v["network_id"] = initializer.network_ident;
         v["request"] = "{\"text\":null}";
         v["response"] = response;
         v["error_type"] = error_type;
         if(request_type != null)
         {
            v["request_type"] = request_type;
         }
         v["status"] = 0;
         v["fversion"] = Capabilities.version;
         v["appversion"] = ClientVersion.version;
         urlRequest.data = v;
         urlLoader.addEventListener("complete",function(param1:Event):void
         {
            var _loc2_:int = 1;
         });
         urlLoader.addEventListener("ioError",ioError);
         urlLoader.addEventListener("networkError",ioError);
         urlLoader.addEventListener("diskError",ioError);
         urlLoader.addEventListener("verifyError",ioError);
         urlLoader.load(urlRequest);
      }
   }
}
