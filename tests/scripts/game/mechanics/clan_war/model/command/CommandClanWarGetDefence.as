package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanWarGetDefence extends RPCCommandBase
   {
       
      
      public function CommandClanWarGetDefence()
      {
         super();
         rpcRequest = new RpcRequest("clanWarGetDefence");
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
   }
}
