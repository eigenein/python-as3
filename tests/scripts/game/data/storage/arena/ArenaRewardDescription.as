package game.data.storage.arena
{
   import com.progrestar.common.util.assert;
   import game.data.reward.RewardData;
   
   public class ArenaRewardDescription
   {
       
      
      public var placeFrom:int;
      
      public var placeTo:int;
      
      public var placementReward:RewardData;
      
      public var arenaDailyReward:RewardData;
      
      public var grandHourlyReward:int;
      
      public function ArenaRewardDescription(param1:*)
      {
         super();
         assert(param1);
         placeFrom = param1.placeFrom;
         placeTo = param1.placeTo;
         placementReward = new RewardData(param1.placementReward);
         arenaDailyReward = new RewardData(param1.arenaPlaceDailyReward);
         if(param1.grandArenaPlaceHourlyReward && param1.grandArenaPlaceHourlyReward.coin)
         {
            grandHourlyReward = param1.grandArenaPlaceHourlyReward.coin[2];
         }
      }
   }
}
