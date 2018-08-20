package game.data.storage.titanarenaleague
{
   import game.data.reward.RewardData;
   
   public class TitanArenaTournamentReward
   {
       
      
      public var placeFrom:uint;
      
      public var placeTo:uint;
      
      public var cup:uint;
      
      public var winnerReward:RewardData;
      
      public var bestOnServer:RewardData;
      
      public var bestGuildMember:RewardData;
      
      public function TitanArenaTournamentReward(param1:Object)
      {
         super();
         this.placeFrom = param1.placeFrom;
         this.placeTo = param1.placeTo;
         this.cup = param1.cup;
         if(param1.rewards)
         {
            this.winnerReward = new RewardData(param1.rewards.winnerReward);
            this.bestOnServer = new RewardData(param1.rewards.bestOnServer);
            this.bestGuildMember = new RewardData(param1.rewards.bestGuildMember);
         }
      }
   }
}
