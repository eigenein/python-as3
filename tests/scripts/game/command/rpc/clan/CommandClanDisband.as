package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanDisband extends RPCCommandBase
   {
       
      
      public function CommandClanDisband()
      {
         super();
         rpcRequest = new RpcRequest("clanDisband");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.clan.action_disband();
         super.clientExecute(param1);
      }
   }
}
