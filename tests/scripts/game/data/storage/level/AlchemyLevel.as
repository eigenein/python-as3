package game.data.storage.level
{
   import game.data.cost.CostData;
   
   public class AlchemyLevel extends LevelBase
   {
       
      
      private var _cost:CostData;
      
      private var baseGold:int;
      
      private var k:int;
      
      public function AlchemyLevel(param1:Object)
      {
         super(param1);
         level = param1.id;
         exp = param1.id;
         _cost = new CostData(param1.cost);
         baseGold = param1.baseGold;
         k = param1.k;
      }
      
      public function getGoldAtTeamLevel(param1:PlayerTeamLevel) : int
      {
         return baseGold * param1.goldConst;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
   }
}
