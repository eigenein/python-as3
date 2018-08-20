package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanDismissMember extends RPCCommandBase
   {
       
      
      private var memberId:String;
      
      public function CommandClanDismissMember(param1:String)
      {
         super();
         this.memberId = param1;
         rpcRequest = new RpcRequest("clanDismissMember");
         if(param1)
         {
            rpcRequest.writeParam("id",param1);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(memberId)
         {
            param1.clan.action_dismissMember(memberId);
         }
         else
         {
            param1.clan.action_leave();
         }
         super.clientExecute(param1);
      }
   }
}
