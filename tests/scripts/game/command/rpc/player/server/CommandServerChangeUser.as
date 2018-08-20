package game.command.rpc.player.server
{
   import engine.context.GameContext;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class CommandServerChangeUser extends RPCCommandBase
   {
       
      
      private var id:String;
      
      public function CommandServerChangeUser(param1:String)
      {
         super();
         this.id = param1;
         rpcRequest = new RpcRequest("userChange");
         rpcRequest.writeParam("id",param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         GameModel.instance.actionManager.initializer.writePlayerId(id);
         GameContext.instance.reloadGame();
      }
   }
}
