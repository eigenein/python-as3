package game.command.rpc.billing
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandSubscriptionFarmGifts extends CostCommand
   {
       
      
      private var _zeppelinReward:RewardData;
      
      private var _subscriptionReward:RewardData;
      
      public function CommandSubscriptionFarmGifts(param1:Boolean)
      {
         super();
         rpcRequest = new RpcRequest("subscriptionFarm");
         param1 = true;
         if(param1)
         {
            rpcRequest.writeRequest(new RpcRequest("zeppelinGiftFarm"));
         }
      }
      
      public function get zeppelinReward() : RewardData
      {
         return _zeppelinReward;
      }
      
      public function get subscriptionReward() : RewardData
      {
         return _subscriptionReward;
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData();
         if(result.body.reward)
         {
            _subscriptionReward = new RewardData(result.body.reward);
         }
         if(result.data.zeppelinGiftFarm.reward)
         {
            _zeppelinReward = new RewardData(result.data.zeppelinGiftFarm.reward);
         }
         if(_zeppelinReward)
         {
            _reward.add(_zeppelinReward);
         }
         if(_subscriptionReward)
         {
            _reward.add(_subscriptionReward);
         }
         super.successHandler();
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.subscription.action_markGiftsAsFarmed();
         super.clientExecute(param1);
      }
   }
}
