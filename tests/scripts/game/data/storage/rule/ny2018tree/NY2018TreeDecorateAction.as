package game.data.storage.rule.ny2018tree
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   
   public class NY2018TreeDecorateAction
   {
       
      
      private var _id:uint;
      
      private var _cost:CostData;
      
      private var _reward:RewardData;
      
      private var _exp:Number;
      
      public function NY2018TreeDecorateAction(param1:uint, param2:Object)
      {
         super();
         _id = param1;
         _exp = Number(param2.exp);
         _cost = new CostData(param2.cost);
         _reward = new RewardData(param2.reward);
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get exp() : Number
      {
         return _exp;
      }
   }
}
