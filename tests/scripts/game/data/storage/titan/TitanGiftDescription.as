package game.data.storage.titan
{
   import battle.BattleStats;
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   
   public class TitanGiftDescription
   {
       
      
      private var _level:uint;
      
      private var _cost:CostData;
      
      protected const battleStats:Dictionary = new Dictionary();
      
      public function TitanGiftDescription(param1:Object)
      {
         super();
         level = param1.level;
         cost = new CostData(param1.cost);
         var _loc4_:int = 0;
         var _loc3_:* = param1.battleStatBonus;
         for(var _loc2_ in param1.battleStatBonus)
         {
            if(param1.battleStatBonus[_loc2_] != null)
            {
               battleStats[_loc2_] = BattleStats.fromRawData(param1.battleStatBonus[_loc2_].battleStatData);
            }
         }
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function set level(param1:uint) : void
      {
         _level = param1;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function set cost(param1:CostData) : void
      {
         _cost = param1;
      }
      
      public function getBattleStatByBaseStat(param1:String) : BattleStats
      {
         return battleStats[param1];
      }
   }
}
