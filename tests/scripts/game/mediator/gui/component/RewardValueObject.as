package game.mediator.gui.component
{
   import game.data.reward.RewardData;
   
   public class RewardValueObject
   {
       
      
      private var _itemReward:RewardData;
      
      private var _reward:RewardData;
      
      public function RewardValueObject(param1:RewardData)
      {
         super();
         this._reward = param1;
         _itemReward = param1.clone() as RewardData;
      }
      
      public function get itemReward() : RewardData
      {
         return _itemReward;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get gold() : int
      {
         return reward.gold;
      }
      
      public function get teamExp() : int
      {
         return reward.experience;
      }
   }
}
