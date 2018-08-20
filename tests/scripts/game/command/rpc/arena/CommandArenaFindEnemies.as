package game.command.rpc.arena
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   
   public class CommandArenaFindEnemies extends RPCCommandBase
   {
       
      
      public function CommandArenaFindEnemies()
      {
         super();
         rpcRequest = new RpcRequest("arenaFindEnemies");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.arena.setEnemies(PlayerArenaEnemy.parseRawEnemies(result.body));
      }
   }
}
