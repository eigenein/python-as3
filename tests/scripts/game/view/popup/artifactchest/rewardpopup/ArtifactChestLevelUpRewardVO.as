package game.view.popup.artifactchest.rewardpopup
{
   import game.data.reward.RewardData;
   
   public class ArtifactChestLevelUpRewardVO
   {
       
      
      private var _level:uint;
      
      private var _reward:RewardData;
      
      public function ArtifactChestLevelUpRewardVO(param1:uint, param2:RewardData)
      {
         super();
         _level = param1;
         _reward = param2;
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function set level(param1:uint) : void
      {
         _level = param1;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function set reward(param1:RewardData) : void
      {
         _reward = param1;
      }
   }
}
