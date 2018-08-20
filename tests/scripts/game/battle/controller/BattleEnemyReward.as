package game.battle.controller
{
   import flash.utils.Dictionary;
   import game.data.reward.RewardData;
   
   public class BattleEnemyReward
   {
       
      
      private var hasReward:Boolean = false;
      
      private var rewardPerHero:Dictionary;
      
      public function BattleEnemyReward()
      {
         rewardPerHero = new Dictionary();
         super();
      }
      
      public function get empty() : Boolean
      {
         return !hasReward;
      }
      
      public function addReward(param1:*) : void
      {
         var _loc2_:* = undefined;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            if(_loc2_.reward != null)
            {
               hasReward = true;
               rewardPerHero[int(_loc3_)] = new RewardData(_loc2_.reward);
            }
         }
      }
      
      public function getByHeroId(param1:int) : RewardData
      {
         if(hasReward && rewardPerHero[param1])
         {
            return rewardPerHero[param1];
         }
         return RewardData.EMPTY_REWARD;
      }
   }
}
