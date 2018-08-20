package game.command.rpc
{
   import com.adobe.crypto.MD5;
   import com.progrestar.common.error.ClientErrorManager;
   import com.progrestar.common.new_rpc.IRpcClient;
   import com.progrestar.common.new_rpc.RPCClientInitializerParams;
   import com.progrestar.common.new_rpc.RpcClientBase;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import com.progrestar.common.new_rpc.RpcRequestBase;
   import com.progrestar.common.new_rpc.RpcResponseBase;
   import com.progrestar.common.server.TimeSyncer;
   import com.progrestar.common.util.DelayCallback;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import game.model.GameModel;
   import idv.cjcat.signals.Signal;
   
   public class RpcClient extends RpcClientBase implements IRpcClient
   {
      
      public static var sessionData:Object;
       
      
      private const QUEUE_AUTO_SEND_TIMEOUT:int = 5000;
      
      private var requestsQueue:Vector.<RpcEntryBase>;
      
      private var firstRequest:Boolean = true;
      
      private var nonBlockingRequests:Array;
      
      private var waitingRequests:Array;
      
      public var defaultErrorHandler:Function;
      
      private var _hasBlockingRequests:Boolean;
      
      private var _signal_updateWaitingState:Signal;
      
      private var _signal_date:Signal;
      
      private var _waitingForServerResponse:Boolean = false;
      
      public function RpcClient(param1:RPCClientInitializerParams)
      {
         nonBlockingRequests = ["stashClient","tutorialSaveProgress","arenaCheckTargetRange"];
         waitingRequests = [];
         _signal_updateWaitingState = new Signal();
         _signal_date = new Signal(Number,Number);
         requestsQueue = new Vector.<RpcEntryBase>();
         super(param1);
         GameModel.instance.context.platformFacade.customNetwork.setClient(this);
      }
      
      public function get hasBlockingRequests() : Boolean
      {
         return _hasBlockingRequests;
      }
      
      public function get signal_updateWaitingState() : Signal
      {
         return _signal_updateWaitingState;
      }
      
      public function get signal_date() : Signal
      {
         return _signal_date;
      }
      
      protected function get waitingForServerResponse() : Boolean
      {
         return _waitingForServerResponse;
      }
      
      public function executeCommand(param1:RPCCommandBase) : void
      {
         if(param1.isImmediate)
         {
            createAndSendRequest(param1.rpcRequest,param1.onRpc_responseHandler,param1.onRpc_infoHandler,param1.onRpc_errorHandler);
         }
         else
         {
            createAndQueueRequest(param1.rpcRequest,param1.onRpc_responseHandler,param1.onRpc_infoHandler,param1.onRpc_errorHandler);
         }
      }
      
      override protected function createResponse(param1:String) : RpcResponseBase
      {
         return new RpcResponse(param1);
      }
      
      override protected function createHeaders(param1:RpcEntryBase) : Object
      {
         var _loc2_:Object = super.createHeaders(param1);
         _loc2_["X-Env-Library-Version"] = "1";
         _loc2_["X-Requested-With"] = "XMLHttpRequest";
         _loc2_["X-Server-Time"] = TimeSyncer.serverTime;
         if(firstRequest)
         {
            firstRequest = false;
            if(initializer.referrer_type)
            {
               _loc2_["X-Env-Referrer"] = encodeURIComponent(initializer.referrer_type);
            }
            _loc2_["X-Auth-Session-Init"] = 1;
         }
         return _loc2_;
      }
      
      override protected function sendEntry(param1:RpcEntryBase) : void
      {
         if(GameModel.instance.context.platformFacade.customNetwork.isAvailable)
         {
            GameModel.instance.context.platformFacade.customNetwork.sendEntry(param1,getCompletedHeaders(param1));
         }
         else
         {
            super.sendEntry(param1);
         }
      }
      
      public function setResponse(param1:RpcEntryBase, param2:String) : void
      {
         onConnectionCompleteHandler(param1);
         serverResponseHandler(param2,param1);
      }
      
      public function setError(param1:RpcEntryBase, param2:String) : void
      {
         onConnectionCompleteHandler(param1);
      }
      
      override protected function serverResponseHandler(param1:String, param2:RpcEntryBase) : void
      {
         ClientErrorManager.instance.setCurrentRequestData(param1);
         param2.response = createResponse(param1);
         if(param2.response.hasOwnProperty("error") && param2.response.error)
         {
            if(param2.response.error.name == "invalid_signature")
            {
               param2.errorHandler && param2.errorHandler(param2);
            }
            else
            {
               param2.errorHandler && param2.errorHandler(param2);
            }
            if(defaultErrorHandler != null)
            {
               defaultErrorHandler(param2);
            }
         }
         else
         {
            currentResponseHandler(param2);
         }
         ClientErrorManager.instance.setCurrentRequestData(null);
      }
      
      override protected function getCompletedHeaders(param1:RpcEntryBase) : Object
      {
         var _loc4_:* = null;
         var _loc2_:Object = createHeaders(param1);
         var _loc3_:ByteArray = createAuthSignature(_loc2_,param1);
         _loc2_["X-Auth-Signature"] = MD5.hashBytes(_loc3_);
         _loc2_["X-Auth-Token"] = initializer.auth_key;
         return _loc2_;
      }
      
      override protected function logError(param1:RpcEntryBase, param2:Event = null, param3:Object = null) : void
      {
      }
      
      protected function createAndQueueRequest(param1:RpcRequestBase, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         addToRequestsQueue(createRequest(param1,param2,param3,param4));
      }
      
      override protected function createAndSendRequest(param1:RpcRequestBase, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         var _loc6_:Array = param1.names;
         var _loc5_:* = requestsQueue.length > 0;
         if(_loc5_)
         {
            addToRequestsQueue(createRequest(param1,param2,param3,param4));
         }
         else
         {
            setWaitingForServerResponse(true,param1 as RpcRequest);
            super.createAndSendRequest(param1,param2,param3,param4);
         }
         if(_loc5_)
         {
            sendQueue();
         }
      }
      
      private function setWaitingForServerResponse(param1:Boolean, param2:RpcRequest) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = param1 != _waitingForServerResponse;
         _waitingForServerResponse = param1;
         if(param1)
         {
            waitingRequests.push(param2);
         }
         else
         {
            _loc8_ = waitingRequests.indexOf(param2);
            if(_loc8_ != -1)
            {
               waitingRequests.splice(_loc8_,1);
            }
         }
         _hasBlockingRequests = false;
         var _loc5_:int = waitingRequests.length;
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc3_ = waitingRequests[_loc9_];
            _loc4_ = _loc3_.names;
            _loc11_ = _loc4_.length;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc7_ = _loc4_[_loc10_];
               if(nonBlockingRequests.indexOf(_loc7_) == -1)
               {
                  _hasBlockingRequests = true;
                  break;
               }
               _loc10_++;
            }
            if(!_hasBlockingRequests)
            {
               _loc9_++;
               continue;
            }
            break;
         }
         _signal_updateWaitingState.dispatch();
      }
      
      private function addToRequestsQueue(param1:RpcEntryBase) : void
      {
         requestsQueue.push(param1);
         if(!waitingForServerResponse)
         {
            DelayCallback.call(this,lazySendQueue,"rpcSendQueue",5000);
         }
      }
      
      private function lazySendQueue() : void
      {
         if(waitingForServerResponse)
         {
            return;
         }
         sendQueue();
      }
      
      private function sendQueue() : void
      {
         onServerResponse = function(param1:RpcEntryBase):void
         {
            var _loc2_:int = 0;
            try
            {
               if(param1 != null && param1.response != null)
               {
                  trace(JSON.stringify(param1.response.body));
               }
            }
            catch(error:Error)
            {
            }
            _loc2_ = 0;
            while(_loc2_ < _requestsQueue.length)
            {
               if(_requestsQueue[_loc2_].responseCallback != null)
               {
                  _requestsQueue[_loc2_].responseCallback(param1);
               }
               _loc2_++;
            }
         };
         infoHandler = function(param1:Object):void
         {
            var _loc3_:int = 0;
            var _loc2_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc4_:int = 0;
            _loc4_ = 0;
            while(_loc4_ < _requestsQueue.length)
            {
               if(_requestsQueue[_loc4_].infoHandler != null)
               {
                  _loc2_ = {};
                  _loc5_ = "group_" + _loc4_ + "_";
                  var _loc8_:int = 0;
                  var _loc7_:* = param1;
                  for(_loc6_ in param1)
                  {
                     _loc3_ = _loc6_.indexOf(_loc5_);
                     if(_loc3_ == 0)
                     {
                        _loc2_[_loc6_.substr(_loc3_ + _loc5_.length)] = param1[_loc6_];
                        delete param1[_loc6_];
                     }
                  }
                  _requestsQueue[_loc4_].infoHandler(_loc2_);
               }
               _loc4_++;
            }
         };
         errorHandler = function(param1:RpcEntryBase):void
         {
            var _loc2_:int = 0;
            _loc2_ = 0;
            while(_loc2_ < _requestsQueue.length)
            {
               if(_requestsQueue[_loc2_].errorHandler != null)
               {
                  _requestsQueue[_loc2_].errorHandler(param1);
               }
               _loc2_++;
            }
         };
         if(requestsQueue.length == 0)
         {
            return;
         }
         var _requestsQueue:Vector.<RpcEntryBase> = requestsQueue.concat();
         requestsQueue.length = 0;
         var max:int = _requestsQueue.length;
         var batchRpcRequest:RpcRequest = new RpcRequest();
         var i:int = 0;
         while(i < max)
         {
            var rpcRequestBase:RpcRequestBase = _requestsQueue[i].request as RpcRequestBase;
            if(rpcRequestBase != null)
            {
               batchRpcRequest.concatRpcRequest(rpcRequestBase,"group_" + i + "_");
            }
            i = Number(i) + 1;
         }
         createAndSendRequest(batchRpcRequest,onServerResponse,infoHandler,errorHandler);
      }
      
      override protected function onConnectionCompleteHandler(param1:RpcEntryBase) : void
      {
         setWaitingForServerResponse(false,param1.request as RpcRequest);
         sendQueue();
         super.onConnectionCompleteHandler(param1);
      }
      
      override protected function currentResponseHandler(param1:RpcEntryBase) : void
      {
         var _loc2_:RpcResponse = param1.response as RpcResponse;
         if(_loc2_ != null)
         {
            sessionData = _loc2_.session;
            signal_date.dispatch(_loc2_.date,_loc2_.timestamp - param1.timestamp);
         }
         super.currentResponseHandler(param1);
      }
   }
}
