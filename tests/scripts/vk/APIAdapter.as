package vk
{
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   
   public final class APIAdapter extends EventDispatcher
   {
       
      
      private var _queue:Vector.<APIRequest>;
      
      private var _queueProcessing:Boolean;
      
      private var _initing:Boolean;
      
      private var _inited:Boolean;
      
      public function APIAdapter()
      {
         super();
         if(!ExternalInterfaceProxy.available)
         {
            throw Error("ExternalInterface не доступен, не возможно связатся с API социальной сети.");
         }
         ExternalInterfaceProxy.addCallback("onInit",onInit);
         ExternalInterfaceProxy.addCallback("onAPIResponse",onAPIResponse);
         _initing = false;
         _inited = false;
         _queue = new Vector.<APIRequest>();
      }
      
      private static function callWrapper(param1:String, param2:Array, param3:String = null) : void
      {
         var _loc4_:Object = {
            "method":param1,
            "params":param2,
            "callback":param3
         };
         ExternalInterfaceProxy.call("apiWrapper",_loc4_);
      }
      
      public function init() : void
      {
         if(!_inited && !_initing)
         {
            _initing = true;
            callWrapper("VK.init",[],"onInit");
         }
      }
      
      private function onInit() : void
      {
         _inited = true;
         dispatchEvent(new APIEvent("onInitialized"));
         addCallbacks();
         tryProcessQueue();
      }
      
      private function addCallbacks() : void
      {
         addCallback("onApplicationAdded");
         addCallback("onSettingsChanged","settings");
         addCallback("onBalanceChanged","balance");
         addCallback("onOrderCancel");
         addCallback("onOrderSuccess","orderId");
         addCallback("onOrderFail","errorCode");
         addCallback("onProfilePhotoSave");
         addCallback("onWallPostSave");
         addCallback("onWallPostCancel");
         addCallback("onWindowResized","width","height");
         addCallback("onLocationChanged","location");
         addCallback("onWindowBlur");
         addCallback("onWindowFocus");
         addCallback("onScrollTop","scrollTop","windowHeight");
         addCallback("onScroll","scrollTop","windowHeight");
         addCallback("onToggleFlash","show");
         addCallback("onRequestSuccess","requestId");
         addCallback("onRequestCancel","requestId");
         addCallback("onRequestFail","requestId");
         addCallback("onSubscriptionSuccess","subscription_id");
         addCallback("onSubscriptionCancel","errorCode");
         addCallback("onSubscriptionFail");
      }
      
      private function addCallback(param1:String, ... rest) : void
      {
         name = param1;
         paramNames = rest;
         handler = function(... rest):void
         {
            var _loc3_:int = 0;
            var _loc4_:* = null;
            var _loc6_:* = undefined;
            if(rest.length > paramNames.length)
            {
               throw Error("Ожидается что функция " + name + " примет минимум " + paramNames.length + " параметров, а получила " + rest.length + " параметров");
            }
            var _loc2_:Object = {};
            _loc3_ = 0;
            while(_loc3_ < rest.length)
            {
               _loc4_ = paramNames[_loc3_];
               _loc6_ = rest[_loc3_];
               _loc2_[_loc4_] = _loc6_;
               _loc3_++;
            }
            var _loc5_:APIEvent = new APIEvent(name,_loc2_);
            dispatchEvent(_loc5_);
         };
         ExternalInterfaceProxy.addCallback(name,handler);
         callWrapper("VK.addCallback",[name],name);
      }
      
      public function callMethod(param1:String, ... rest) : void
      {
         if(!_inited)
         {
            throw Error("API connection is not initialized. Please wait for the INITIALIZED event first.");
         }
         rest.unshift(param1);
         callWrapper("VK.callMethod",rest);
      }
      
      public function readdCallback(param1:String, ... rest) : void
      {
         rest.unshift(param1);
         addCallback.apply(this,rest);
      }
      
      public function api(param1:String, param2:Object, param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:APIRequest = new APIRequest(param1,param2,param3,param4);
         _queue.push(_loc5_);
      }
      
      private function onAPIResponse(param1:Object) : void
      {
         data = param1;
         nextRequest = function():void
         {
            _queueProcessing = false;
            tryProcessQueue();
         };
         if(_queueProcessing)
         {
            _queue.shift().invoke(data);
            setTimeout(nextRequest,350);
         }
      }
      
      private function tryProcessQueue() : void
      {
         if(!_queueProcessing && _queue.length > 0)
         {
            _queueProcessing = true;
            callWrapper("VK.api",[_queue[0].method,_queue[0].params],"onAPIResponse");
         }
      }
   }
}
