package game.model.user.hero
{
   import flash.utils.Dictionary;
   import game.data.reward.RewardData;
   
   public class PlayerTitanArenaTrophyData
   {
       
      
      public var championReward:RewardData;
      
      public var championRewardFarmed:Boolean;
      
      public var serverReward:RewardData;
      
      public var serverRewardFarmed:Boolean;
      
      public var clanRewards:Dictionary;
      
      public var clanRewardFarmed:Boolean;
      
      public var cup:int;
      
      public var clanId:int;
      
      public var place:int;
      
      public var serverId:int;
      
      public var week:int;
      
      public function PlayerTitanArenaTrophyData(param1:Object)
      {
         super();
         this.cup = param1.cup;
         this.clanId = param1.clanId;
         this.place = param1.place;
         this.serverId = param1.serverId;
         this.week = param1.week;
         if(param1.championReward)
         {
            this.championReward = new RewardData(param1.championReward);
         }
         if(param1.serverReward)
         {
            this.serverReward = new RewardData(param1.serverReward);
         }
         if(param1.clanReward)
         {
            clanRewards = new Dictionary();
            var _loc4_:int = 0;
            var _loc3_:* = param1.clanReward;
            for(var _loc2_ in param1.clanReward)
            {
               this.clanRewards[_loc2_] = new RewardData(param1.clanReward[_loc2_]);
            }
         }
         this.championRewardFarmed = param1.championRewardFarmed;
         this.serverRewardFarmed = param1.serverRewardFarmed;
         this.clanRewardFarmed = param1.clanRewardFarmed;
      }
      
      public function get hasCup() : Boolean
      {
         return cup > 0 && cup < 5;
      }
      
      public function get hasNotFarmedReward() : Boolean
      {
         return !championRewardFarmed && hasChampionReward || !serverRewardFarmed && hasServerReward || !clanRewardFarmed && hasClanReward;
      }
      
      public function get hasChampionReward() : Boolean
      {
         return championReward && championReward.outputDisplay.length;
      }
      
      public function get hasServerReward() : Boolean
      {
         return serverReward && serverReward.outputDisplay.length;
      }
      
      public function get hasClanReward() : Boolean
      {
         if(clanRewards)
         {
            var _loc3_:int = 0;
            var _loc2_:* = clanRewards;
            for each(var _loc1_ in clanRewards)
            {
               return true;
            }
         }
         return false;
      }
   }
}
