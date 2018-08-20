package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandTitanArenaHallOfFameGet extends RPCCommandBase
   {
       
      
      public function CommandTitanArenaHallOfFameGet(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("hallOfFameGet");
         if(param1)
         {
            rpcRequest.writeParam("key",param1);
         }
      }
   }
}
