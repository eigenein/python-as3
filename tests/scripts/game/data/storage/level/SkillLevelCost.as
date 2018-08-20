package game.data.storage.level
{
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   
   public class SkillLevelCost extends LevelBase
   {
       
      
      private var tierCost:Dictionary;
      
      public function SkillLevelCost(param1:Object)
      {
         var _loc2_:* = null;
         super(param1);
         tierCost = new Dictionary();
         if(param1.tierCost)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1.tierCost;
            for(var _loc3_ in param1.tierCost)
            {
               _loc2_ = new CostData();
               _loc2_.gold = param1.tierCost[_loc3_];
               tierCost[_loc3_] = _loc2_;
            }
         }
      }
      
      public function getTierCost(param1:int) : CostData
      {
         return tierCost[param1];
      }
   }
}
