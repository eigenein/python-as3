package game.command.tower
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandTowerFullSkip extends CostCommand
   {
       
      
      public function CommandTowerFullSkip(param1:CostData)
      {
         super();
         rpcRequest = new RpcRequest("towerFullSkip");
         _cost = param1;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         _reward = new RewardData();
         var _loc4_:int = 0;
         var _loc3_:* = result.body.reward;
         for(var _loc2_ in result.body.reward)
         {
            reward.addRawData(result.body.reward[_loc2_]);
         }
         super.clientExecute(param1);
         param1.tower.parseRewards(result.body);
         param1.tower.parseNewState(result.body);
      }
   }
}
