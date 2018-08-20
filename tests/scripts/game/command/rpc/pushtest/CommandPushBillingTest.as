package game.command.rpc.pushtest
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.billing.PlayerBillingDescription;
   
   public class CommandPushBillingTest extends RPCCommandBase
   {
       
      
      public function CommandPushBillingTest(param1:PlayerBillingDescription)
      {
         super();
         rpcRequest = new RpcRequest("pushBilling");
         rpcRequest.writeParam("id",param1.id);
      }
   }
}
