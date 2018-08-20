package game.command.rpc
{
   import game.command.requirement.CommandRequirement;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CostCommand extends RPCCommandBase
   {
       
      
      protected var _reward:RewardData;
      
      protected var _cost:CostData;
      
      public function CostCommand()
      {
         super();
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:CommandRequirement = super.prerequisiteCheck(param1);
         if(cost)
         {
            _loc2_.cost = cost;
         }
         return _loc2_;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(cost)
         {
            param1.spendCost(cost);
         }
         if(reward)
         {
            param1.takeReward(reward);
         }
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
   }
}
