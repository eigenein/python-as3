package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandTitanArenaTestGetNextTier extends RPCCommandBase
   {
       
      
      public function CommandTitanArenaTestGetNextTier()
      {
         super();
         rpcRequest = new RpcRequest("titanArenaTestGetNextTier","titanArenaTestGetNextTier");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.titanArenaData.action_testKillEveryone();
         super.clientExecute(param1);
      }
   }
}
