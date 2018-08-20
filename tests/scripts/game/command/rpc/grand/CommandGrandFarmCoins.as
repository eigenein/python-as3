package game.command.rpc.grand
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandGrandFarmCoins extends CostCommand
   {
       
      
      public function CommandGrandFarmCoins()
      {
         super();
         rpcRequest = new RpcRequest("grandFarmCoins");
      }
      
      override protected function successHandler() : void
      {
         if(result.body)
         {
            _reward = new RewardData(result.body.reward);
         }
         super.successHandler();
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(result.body)
         {
            param1.grand.updateCoins(result.body.grandCoin,result.body.grandCoinTime);
         }
      }
   }
}
