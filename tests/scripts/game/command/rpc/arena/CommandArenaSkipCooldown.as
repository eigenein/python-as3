package game.command.rpc.arena
{
   import game.command.rpc.RefillableRefillCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandArenaSkipCooldown extends RefillableRefillCommand
   {
       
      
      public function CommandArenaSkipCooldown()
      {
         super();
         rpcRequest = new RpcRequest("arenaSkipCooldown");
      }
      
      override protected function getPlayerRefillable(param1:Player) : PlayerRefillableEntry
      {
         return param1.refillable.getById(DataStorage.arena.arena.refillableCooldownId);
      }
   }
}
