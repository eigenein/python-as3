package game.command.rpc.refillable
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   
   public class AlchemyRewardValueObject
   {
       
      
      private var _reward:RewardData;
      
      private var _crit:int;
      
      private var _tryNumber:int;
      
      private var _cost:CostData;
      
      public function AlchemyRewardValueObject(param1:RewardData, param2:CostData, param3:int, param4:int)
      {
         super();
         this._cost = param2;
         this._tryNumber = param4;
         this._crit = param3;
         this._reward = param1;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get crit() : int
      {
         return _crit;
      }
      
      public function get tryNumber() : int
      {
         return _tryNumber;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get costItemCount() : int
      {
         return _cost.starmoney;
      }
      
      public function get rewardItemCount() : int
      {
         return _reward.gold;
      }
   }
}
