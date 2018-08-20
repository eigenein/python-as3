package game.data.storage.tower
{
   import game.data.reward.RewardData;
   
   public class TowerRewardDescription
   {
       
      
      private var _id:int;
      
      private var _pointsEarned:int;
      
      private var _reward:RewardData;
      
      public function TowerRewardDescription(param1:*)
      {
         super();
         _id = param1.id;
         _pointsEarned = param1.pointsEarned;
         _reward = new RewardData(param1.reward);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get pointsEarned() : int
      {
         return _pointsEarned;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
   }
}
