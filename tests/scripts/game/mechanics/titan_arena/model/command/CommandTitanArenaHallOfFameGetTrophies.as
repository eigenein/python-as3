package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandTitanArenaHallOfFameGetTrophies extends RPCCommandBase
   {
       
      
      public function CommandTitanArenaHallOfFameGetTrophies()
      {
         super();
         rpcRequest = new RpcRequest("hallOfFameGetTrophies");
      }
   }
}
