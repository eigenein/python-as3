package game.data.storage.admiration
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   
   public class AdmirationDescription extends DescriptionBase
   {
       
      
      private var _payerCost:CostData;
      
      private var _payerReward:RewardData;
      
      private var _receiverReward:RewardData;
      
      private var _vipLevel:int;
      
      public function AdmirationDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _vipLevel = param1.vipLevel;
         if(param1.payerCost)
         {
            _payerCost = new CostData(param1.payerCost);
         }
         if(param1.payerReward)
         {
            _payerReward = new RewardData(param1.payerReward);
         }
         if(param1.receiverReward)
         {
            _receiverReward = new RewardData(param1.receiverReward);
         }
      }
      
      public function get payerCost() : CostData
      {
         return _payerCost;
      }
      
      public function get payerReward() : RewardData
      {
         return _payerReward;
      }
      
      public function get receiverReward() : RewardData
      {
         return _receiverReward;
      }
      
      public function get vipLevel() : int
      {
         return _vipLevel;
      }
   }
}
