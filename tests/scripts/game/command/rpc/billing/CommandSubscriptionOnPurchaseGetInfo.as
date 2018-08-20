package game.command.rpc.billing
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mechanics.expedition.mediator.SubscriptionActivateRewardPopupMediator;
   import game.model.user.Player;
   
   public class CommandSubscriptionOnPurchaseGetInfo extends RPCCommandBase
   {
       
      
      public function CommandSubscriptionOnPurchaseGetInfo()
      {
         super();
         rpcRequest = new RpcRequest("subscriptionGetInfo");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.subscription.update(result.body);
         var _loc2_:SubscriptionActivateRewardPopupMediator = new SubscriptionActivateRewardPopupMediator(param1);
         _loc2_.open();
      }
      
      override public function onRpc_infoHandler(param1:Object) : void
      {
         super.onRpc_infoHandler(param1);
      }
   }
}
