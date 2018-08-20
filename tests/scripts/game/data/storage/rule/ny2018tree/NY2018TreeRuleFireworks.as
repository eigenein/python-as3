package game.data.storage.rule.ny2018tree
{
   import game.data.reward.RewardData;
   
   public class NY2018TreeRuleFireworks
   {
       
      
      private var _decorateAction:NY2018TreeDecorateAction;
      
      private var _randomPlayerGiftReward:RewardData;
      
      private var _randomPlayerGiftAmount:int;
      
      public function NY2018TreeRuleFireworks(param1:Object, param2:NY2018TreeDecorateAction)
      {
         super();
         this._decorateAction = param2;
         _randomPlayerGiftReward = new RewardData(param1.randomPlayerGiftReward);
         _randomPlayerGiftAmount = param1.randomPlayerGiftAmount;
      }
      
      public function get decorateAction() : NY2018TreeDecorateAction
      {
         return _decorateAction;
      }
      
      public function get randomPlayerGiftReward() : RewardData
      {
         return _randomPlayerGiftReward;
      }
      
      public function get randomPlayerGiftAmount() : int
      {
         return _randomPlayerGiftAmount;
      }
   }
}
