package game.data.storage.subscription
{
   import game.data.reward.RewardData;
   
   public class SubscriptionLevelDescription
   {
       
      
      private var _level:int;
      
      private var _dailyReward:RewardData;
      
      private var _levelUpReward:RewardData;
      
      public function SubscriptionLevelDescription(param1:int, param2:Object)
      {
         super();
         this._levelUpReward = new RewardData(param2.levelUpReward);
         this._dailyReward = new RewardData(param2.dailyReward);
         this._level = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get dailyReward() : RewardData
      {
         return _dailyReward;
      }
      
      public function get levelUpReward() : RewardData
      {
         return _levelUpReward;
      }
   }
}
