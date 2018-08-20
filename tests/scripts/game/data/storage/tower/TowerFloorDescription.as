package game.data.storage.tower
{
   import game.data.cost.CostData;
   
   public class TowerFloorDescription
   {
       
      
      private var _floor:int;
      
      private var _type:TowerFloorType;
      
      private var _chestCosts:Vector.<CostData>;
      
      private var _pointReward:int;
      
      public function TowerFloorDescription(param1:*)
      {
         var _loc3_:* = 0;
         super();
         _floor = param1.floor;
         _type = TowerFloorType.getByIdent(param1.type);
         if(_type == TowerFloorType.CHEST)
         {
            _chestCosts = new Vector.<CostData>();
            var _loc5_:int = 0;
            var _loc4_:* = param1.floorData.cost;
            for(_loc3_ in param1.floorData.cost)
            {
               if(_loc3_ > _chestCosts.length)
               {
                  _chestCosts.length = _loc3_;
               }
               _chestCosts[_loc3_ - 1] = new CostData(param1.floorData.cost[_loc3_]);
            }
         }
         else if(_type == TowerFloorType.BATTLE)
         {
            _pointReward = param1.pointReward;
         }
      }
      
      public function get floor() : int
      {
         return _floor;
      }
      
      public function get type() : TowerFloorType
      {
         return _type;
      }
      
      public function get pointReward() : int
      {
         return _pointReward;
      }
      
      public function getChestCost(param1:int) : CostData
      {
         if(param1 >= _chestCosts.length)
         {
            return null;
         }
         return _chestCosts[param1];
      }
   }
}
