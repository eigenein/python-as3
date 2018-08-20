package game.data.storage.hero
{
   import battle.BattleStats;
   import game.data.storage.enum.lib.EvolutionStar;
   
   public class HeroStarEvolutionData
   {
       
      
      public var statGrowthData:BattleStats;
      
      public var star:EvolutionStar;
      
      public var next:HeroStarEvolutionData;
      
      public var prev:HeroStarEvolutionData;
      
      public function HeroStarEvolutionData(param1:Object, param2:EvolutionStar)
      {
         super();
         this.star = param2;
         statGrowthData = BattleStats.fromRawData(param1);
      }
   }
}
