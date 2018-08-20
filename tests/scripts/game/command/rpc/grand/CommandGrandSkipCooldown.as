package game.command.rpc.grand
{
   import game.command.rpc.RefillableRefillCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandGrandSkipCooldown extends RefillableRefillCommand
   {
       
      
      public function CommandGrandSkipCooldown()
      {
         super();
         rpcRequest = new RpcRequest("grandSkipCooldown");
      }
      
      override protected function getPlayerRefillable(param1:Player) : PlayerRefillableEntry
      {
         return param1.refillable.getById(DataStorage.arena.grand.refillableCooldownId);
      }
   }
}
