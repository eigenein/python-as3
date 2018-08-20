package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   
   public class CommandTitanArenaCompleteTier extends CostCommand
   {
       
      
      public function CommandTitanArenaCompleteTier()
      {
         super();
         rpcRequest = new RpcRequest("titanArenaCompleteTier");
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body.tierReward);
         super.successHandler();
      }
   }
}
