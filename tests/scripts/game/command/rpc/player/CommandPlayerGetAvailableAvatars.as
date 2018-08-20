package game.command.rpc.player
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandPlayerGetAvailableAvatars extends RPCCommandBase
   {
       
      
      public function CommandPlayerGetAvailableAvatars()
      {
         super();
         rpcRequest = new RpcRequest("userGetAvailableAvatars");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.avatarData.updateAvailableAvatars(result.body as Array);
         super.clientExecute(param1);
      }
   }
}
