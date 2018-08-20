package game.command.rpc.quest
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandGetAllQuestsAndEvents extends RPCCommandBase
   {
       
      
      public function CommandGetAllQuestsAndEvents()
      {
         super();
         rpcRequest = new RpcRequest();
         rpcRequest.writeRequest(new RpcRequest("questGetAll"));
         rpcRequest.writeRequest(new RpcRequest("questGetEvents"));
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.questData.reset(result.data["questGetAll"]);
         param1.questData.resetEvents(result.data["questGetEvents"]);
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
      }
   }
}
