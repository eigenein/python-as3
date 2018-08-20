package game.command.rpc.billing
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.billing.PlayerBillingDescription;
   
   public class CommandBillingChooseHero extends RPCCommandBase
   {
       
      
      public function CommandBillingChooseHero(param1:UnitDescription, param2:PlayerBillingDescription)
      {
         super();
         rpcRequest = new RpcRequest("billingChooseHero");
         rpcRequest.writeParam("heroId",param1.id);
         rpcRequest.writeParam("billingId",param2.id);
      }
   }
}
