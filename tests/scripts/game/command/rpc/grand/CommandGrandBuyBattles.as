package game.command.rpc.grand
{
   import game.command.rpc.RefillableRefillCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandGrandBuyBattles extends RefillableRefillCommand
   {
       
      
      public function CommandGrandBuyBattles()
      {
         super();
         rpcRequest = new RpcRequest("grandBuyBattles");
      }
      
      override protected function getPlayerRefillable(param1:Player) : PlayerRefillableEntry
      {
         return param1.refillable.getById(DataStorage.arena.grand.refillableBattleId);
      }
   }
}
