package game.command.rpc.player
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandPlayerSetAvatar extends CostCommand
   {
       
      
      private var avatarId:int;
      
      public function CommandPlayerSetAvatar(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("userSetAvatar");
         rpcRequest.writeParam("avatarId",param1);
         this.avatarId = param1;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.changeAvatar(avatarId);
         super.clientExecute(param1);
      }
   }
}
