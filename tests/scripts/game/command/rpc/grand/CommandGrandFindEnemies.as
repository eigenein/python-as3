package game.command.rpc.grand
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   
   public class CommandGrandFindEnemies extends RPCCommandBase
   {
       
      
      public function CommandGrandFindEnemies()
      {
         super();
         rpcRequest = new RpcRequest("grandFindEnemies");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.grand.setEnemies(PlayerArenaEnemy.parseRawEnemies(result.body));
      }
   }
}
