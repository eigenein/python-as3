package game.command.rpc.player
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandOfferFarmReward extends RPCCommandBase
   {
       
      
      private var _reward:RewardData;
      
      public function CommandOfferFarmReward(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("offerFarmReward");
         rpcRequest.writeParam("offerId",param1);
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function farmReward(param1:Player) : void
      {
         param1.takeReward(_reward);
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body);
         super.successHandler();
      }
   }
}
