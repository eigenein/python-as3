package game.data.storage.titan
{
   import battle.BattleStats;
   import game.data.storage.enum.lib.TitanEvolutionStar;
   
   public class TitanStarEvolutionData
   {
       
      
      public var statGrowthData:BattleStats;
      
      public var star:TitanEvolutionStar;
      
      public var next:TitanStarEvolutionData;
      
      public var prev:TitanStarEvolutionData;
      
      public function TitanStarEvolutionData(param1:Object, param2:TitanEvolutionStar)
      {
         super();
         this.star = param2;
         statGrowthData = BattleStats.fromRawData(param1);
      }
   }
}
