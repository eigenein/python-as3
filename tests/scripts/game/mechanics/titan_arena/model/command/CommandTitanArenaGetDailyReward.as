package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandTitanArenaGetDailyReward extends RPCCommandBase
   {
       
      
      public function CommandTitanArenaGetDailyReward()
      {
         super();
         rpcRequest = new RpcRequest("titanArenaGetDailyReward");
      }
   }
}
