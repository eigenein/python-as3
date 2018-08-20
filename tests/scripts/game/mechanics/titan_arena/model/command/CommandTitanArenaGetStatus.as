package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandTitanArenaGetStatus extends RPCCommandBase
   {
       
      
      public function CommandTitanArenaGetStatus()
      {
         super();
         rpcRequest = new RpcRequest("titanArenaGetStatus");
         rpcRequest.writeRequest(new RpcRequest("titanArenaGetDailyReward"));
      }
   }
}
