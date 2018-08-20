package game.data.storage.level
{
   import game.data.cost.CostData;
   
   public class ClanLevel extends LevelBase
   {
       
      
      private var _levelUpCost:CostData;
      
      private var _maxPlayersCount:int;
      
      private var _activityPointsCap:int;
      
      public function ClanLevel(param1:Object)
      {
         super(param1);
         exp = param1.activityPointsCap;
         _levelUpCost = new CostData(param1.levelUpCost);
         _maxPlayersCount = param1.maxPlayersCount;
         _activityPointsCap = param1.activityPointsCap;
      }
      
      public function get levelUpCost() : CostData
      {
         return _levelUpCost;
      }
      
      public function get maxPlayersCount() : int
      {
         return _maxPlayersCount;
      }
      
      public function get activityPointsCap() : int
      {
         return _activityPointsCap;
      }
   }
}
