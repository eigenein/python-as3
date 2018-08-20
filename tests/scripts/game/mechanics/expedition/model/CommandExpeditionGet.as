package game.mechanics.expedition.model
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandExpeditionGet extends RPCCommandBase
   {
       
      
      public function CommandExpeditionGet()
      {
         super();
         rpcRequest = new RpcRequest("expeditionGet");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.expedition.updateExpeditions(result.body);
      }
   }
}
