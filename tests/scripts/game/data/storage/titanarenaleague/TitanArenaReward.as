package game.data.storage.titanarenaleague
{
   import game.data.reward.RewardData;
   
   public class TitanArenaReward
   {
       
      
      public var tournamentPoints:uint;
      
      public var reward:RewardData;
      
      public function TitanArenaReward(param1:Object)
      {
         super();
         this.tournamentPoints = param1.tournamentPoints;
         this.reward = new RewardData(param1.reward);
      }
   }
}
