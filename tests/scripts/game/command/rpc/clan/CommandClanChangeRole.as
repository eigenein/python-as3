package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mediator.gui.popup.clan.ClanRole;
   
   public class CommandClanChangeRole extends RPCCommandBase
   {
       
      
      private var memberId:String;
      
      private var role:ClanRole;
      
      public function CommandClanChangeRole(param1:String, param2:ClanRole)
      {
         super();
         this.role = param2;
         this.memberId = param1;
         rpcRequest = new RpcRequest("clanChangeRole");
         rpcRequest.writeParam("id",param1);
         rpcRequest.writeParam("newRole",param2.code);
      }
   }
}
