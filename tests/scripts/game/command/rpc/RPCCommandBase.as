package game.command.rpc
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.requirement.CommandRequirement;
   import game.model.GameModel;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class RPCCommandBase
   {
       
      
      private const logger:Logger = Logger.getLogger(RPCCommandBase);
      
      private var clientExecuteDispatched:Boolean = false;
      
      private const signal_clientExecute:Signal = new Signal(RPCCommandBase);
      
      public const signal_complete:Signal = new Signal(RPCCommandBase);
      
      public const signal_error:Signal = new Signal(RPCCommandBase);
      
      public var isImmediate:Boolean = true;
      
      public var error:CommandResultError;
      
      public var result:CommandResult;
      
      public var rpcRequest:RpcRequest;
      
      public function RPCCommandBase()
      {
         super();
      }
      
      public function get type() : String
      {
         if(rpcRequest)
         {
            return rpcRequest.name;
         }
         return "unknown cmd";
      }
      
      public function clientExecute(param1:Player) : void
      {
         logger.debug("clientExecute",!!rpcRequest?rpcRequest.name:"unknown");
      }
      
      public function dispatchClientExecute() : void
      {
         clientExecuteDispatched = true;
         signal_clientExecute.dispatch(this);
      }
      
      public function onClientExecute(param1:Function) : void
      {
         if(clientExecuteDispatched)
         {
            param1(this);
         }
         else
         {
            signal_clientExecute.addOnce(param1);
         }
      }
      
      public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         return new CommandRequirement();
      }
      
      public function dispose() : void
      {
         signal_complete.clear();
         signal_error.clear();
         signal_clientExecute.clear();
      }
      
      protected function successHandler() : void
      {
         var _loc1_:Player = GameModel.instance.player;
         if(_loc1_)
         {
            _loc1_.questData.onRpc_checkQuestUpdates(this);
            _loc1_.specialOffer.onRpc_update(this);
            _loc1_.billingData.onRpc_checkUpdates(this);
            _loc1_.specialShop.controller.onRpc_checkUpdates(this);
         }
         signal_complete.dispatch(this);
         if(isImmediate)
         {
            dispatchClientExecute();
         }
      }
      
      public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         error = new CommandResultError();
         error.name = param1.response.error.name;
         error.description = param1.response.error.description;
         error.message = param1.response.error.name + " : " + param1.response.error.description;
         signal_error.dispatch(this);
         logger.error(error.message);
      }
      
      public function onRpc_infoHandler(param1:Object) : void
      {
         logger.debug("success",rpcRequest.name);
         this.result = new CommandResult(param1);
         successHandler();
      }
      
      public function onRpc_responseHandler(param1:RpcEntryBase) : void
      {
      }
   }
}
