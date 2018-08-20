package game.command.rpc.friends
{
   import engine.context.platform.PlatformUser;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandFriendSetInvitedBy extends RPCCommandBase
   {
       
      
      private var friend:PlatformUser;
      
      public function CommandFriendSetInvitedBy(param1:PlatformUser)
      {
         super();
         rpcRequest = new RpcRequest("friendsSetInvitedBy");
         rpcRequest.writeParam("id",!!param1?param1.id:0);
         this.friend = param1;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.socialQuestData.completeStep_setReferrer(param1);
         super.clientExecute(param1);
      }
   }
}
