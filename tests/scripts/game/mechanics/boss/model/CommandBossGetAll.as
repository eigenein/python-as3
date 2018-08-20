package game.mechanics.boss.model
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandBossGetAll extends RPCCommandBase
   {
       
      
      public function CommandBossGetAll()
      {
         super();
         rpcRequest = new RpcRequest("bossGetAll");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.boss.updateAll(result.body as Array);
      }
   }
}
