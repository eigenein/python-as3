package game.mechanics.clan_war.storage
{
   import game.data.reward.RewardData;
   
   public class ClanWarLeagueDivisionDescription
   {
       
      
      public var id:int;
      
      public var championsReward:RewardData;
      
      public var drawReward:RewardData;
      
      public var losersReward:RewardData;
      
      public var victoryReward:RewardData;
      
      public var weeklyReward:RewardData;
      
      public function ClanWarLeagueDivisionDescription(param1:int, param2:Object)
      {
         super();
         this.id = param1;
         weeklyReward = new RewardData(param2.weeklyReward);
         losersReward = new RewardData(param2.losersReward);
         drawReward = new RewardData(param2.drawReward);
         victoryReward = new RewardData(param2.victoryReward);
         championsReward = new RewardData(param2.championsReward);
         championsReward.add(victoryReward);
      }
   }
}
