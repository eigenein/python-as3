package game.command.realtime
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class PushdClient extends MessageClientBase
   {
      
      protected static const logger:Logger = Logger.getLogger(PushdClient);
       
      
      protected var errorTimer:Timer;
      
      protected var finalErrorFired:Boolean;
      
      protected var firstReconnect:Boolean = true;
      
      protected var MESSAGE_FUNC:String = "message";
      
      protected var CONNECT_FUNC:String = "onConnect";
      
      protected var DISCONNECT_FUNC:String = "onDisconnect";
      
      public function PushdClient()
      {
         super();
      }
      
      override public function initialize(param1:String, param2:Object) : void
      {
         super.initialize(param1,param2);
         try
         {
            ExternalInterfaceProxy.addCallback(CONNECT_FUNC,onConnect);
            ExternalInterfaceProxy.addCallback(DISCONNECT_FUNC,onError);
            ExternalInterfaceProxy.addCallback(MESSAGE_FUNC,myCustomMessageHandler);
         }
         catch(error:Error)
         {
         }
         connect();
      }
      
      override protected function connect() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = ["pushd",{
            "connect":"onConnect",
            "disconnect":"onDisconnect",
            "message":MESSAGE_FUNC
         }];
         try
         {
            _loc1_ = ExternalInterfaceProxy.call("progrestar.flashGate.started",_loc2_[0],_loc2_[1]);
         }
         catch(error:Error)
         {
         }
         if(_loc1_)
         {
            logger.debug(">>>> socket connect: " + JSON.stringify(_loc1_));
         }
         else
         {
            logger.error(">>>> socket connect invalid");
         }
      }
      
      protected function startErrorTimer() : void
      {
         if(errorTimer)
         {
            errorTimer.reset();
         }
         errorTimer = new Timer(10000,1);
         errorTimer.addEventListener("timer",onFinalError);
         errorTimer.start();
      }
      
      protected function stopErrorTimer() : void
      {
         if(errorTimer)
         {
            errorTimer.stop();
         }
      }
      
      protected function myCustomMessageHandler(... rest) : void
      {
         var _loc4_:* = null;
         var _loc2_:String = JSON.stringify(rest);
         ExternalInterfaceProxy.call("console.log","flash:" + _loc2_);
         logger.debug(">>>> socket custom msg: " + _loc2_);
         var _loc3_:Object = rest[1];
         if(_loc3_.body.pushUserId == userId || !_loc3_.body.pushUserId)
         {
            _loc4_ = new SocketClientEvent(_loc3_);
            dataSignal.dispatch(_loc4_);
            notifySubscribers(_loc4_);
         }
      }
      
      protected function onError(... rest) : void
      {
         logger.error(">>>> socket error: " + JSON.stringify(rest));
         _connected = false;
         connectionStateChange.dispatch(_connected);
         startErrorTimer();
      }
      
      protected function onConnect(... rest) : void
      {
         logger.debug(">>>> socket connect: " + JSON.stringify(rest));
         _connected = true;
         firstReconnect = false;
         connectionStateChange.dispatch(_connected);
         stopErrorTimer();
      }
      
      protected function onFinalError(param1:Event) : void
      {
         if(!finalErrorFired)
         {
            statSignal.dispatch("SOCKET","FINAL_CONNECT_ERROR");
            _connected = false;
            connectionStateChange.dispatch(_connected);
            finalErrorFired = true;
         }
      }
   }
}
