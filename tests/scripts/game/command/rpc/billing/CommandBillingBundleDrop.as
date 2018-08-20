package game.command.rpc.billing
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandBillingBundleDrop extends RPCCommandBase
   {
       
      
      public function CommandBillingBundleDrop()
      {
         super();
         rpcRequest = new RpcRequest("bundleDrop");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.billingData.bundleData.dropBundle();
         super.clientExecute(param1);
      }
   }
}
