package game.command.rpc.player.server
{
   import engine.context.GameContext;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class CommandServerMigrateUser extends RPCCommandBase
   {
       
      
      public function CommandServerMigrateUser(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("userMigrate");
         rpcRequest.writeParam("serverId",param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         GameModel.instance.actionManager.initializer.writePlayerId(String(result.body));
         GameContext.instance.reloadGame();
      }
   }
}
