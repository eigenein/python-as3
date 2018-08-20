package game.mechanics.boss.model
{
   import game.command.rpc.RefillableRefillCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandBossBuyTries extends RefillableRefillCommand
   {
       
      
      public function CommandBossBuyTries()
      {
         super();
         rpcRequest = new RpcRequest("bossBuyTries");
      }
      
      override protected function getPlayerRefillable(param1:Player) : PlayerRefillableEntry
      {
         return param1.boss.tries;
      }
   }
}
