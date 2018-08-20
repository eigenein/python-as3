package game.command.realtime
{
   import com.progrestar.common.error.ClientErrorManager;
   import engine.context.GameContext;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   
   public class MessageClientBase
   {
       
      
      protected var userId:String;
      
      protected var subscribers:Dictionary;
      
      public const connectionStateChange:Signal = new Signal(Boolean);
      
      public const statSignal:Signal = new Signal(String,String);
      
      public const dataSignal:Signal = new Signal(SocketClientEvent);
      
      protected var _connected:Boolean;
      
      public function MessageClientBase()
      {
         subscribers = new Dictionary();
         super();
      }
      
      public function get connected() : Boolean
      {
         return _connected;
      }
      
      public function initialize(param1:String, param2:Object) : void
      {
         this.userId = param1;
      }
      
      public function subscribe(param1:String, param2:Function) : void
      {
         if(subscribers[param1] == null)
         {
            subscribers[param1] = new Signal(SocketClientEvent);
         }
         subscribers[param1].add(param2);
      }
      
      public function unsubscribe(param1:String, param2:Function) : void
      {
         if(subscribers[param1])
         {
            subscribers[param1].remove(param2);
         }
      }
      
      protected function connect() : void
      {
      }
      
      protected function notifySubscribers(param1:SocketClientEvent) : void
      {
         var _loc2_:Signal = subscribers[param1.type];
         trace("MessageClientBase::notifySubscribers",param1.type,!!_loc2_?_loc2_.numListeners:0);
         if(_loc2_)
         {
            try
            {
               _loc2_.dispatch(param1);
               return;
            }
            catch(error:*)
            {
               if(error is Error)
               {
                  ClientErrorManager.action_handleError(error);
               }
               else
               {
                  ClientErrorManager.action_handleError(new Error(error));
               }
               if(GameContext.instance.consoleEnabled)
               {
                  throw error;
               }
               return;
            }
         }
      }
   }
}
