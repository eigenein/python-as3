package game.command.rpc.clan
{
   import game.command.rpc.RefillableRefillCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandClanSkipEnterCooldown extends RefillableRefillCommand
   {
       
      
      public function CommandClanSkipEnterCooldown()
      {
         super();
         rpcRequest = new RpcRequest("refillableSkipClanCooldown");
      }
      
      override protected function getPlayerRefillable(param1:Player) : PlayerRefillableEntry
      {
         var _loc2_:RefillableDescription = DataStorage.refillable.getByIdent("clanReenter_cooldown");
         return param1.refillable.getById(_loc2_.id);
      }
   }
}
