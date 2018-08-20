package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanWarTakeEmptySlots extends RPCCommandBase
   {
       
      
      public function CommandClanWarTakeEmptySlots()
      {
         super();
         rpcRequest = new RpcRequest("clanWarTakeEmptySlots");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = result.body;
         super.clientExecute(param1);
      }
   }
}
