package game.data.storage.rule
{
   import game.data.cost.CostData;
   
   public class TitanArtifactChestRule
   {
       
      
      private var _openCostX1:CostData;
      
      private var _openCostX10:CostData;
      
      private var _openCostX10Free:CostData;
      
      private var _openCostX100:CostData;
      
      public function TitanArtifactChestRule(param1:Object)
      {
         super();
         _openCostX1 = new CostData(param1.cost[1]);
         _openCostX10 = new CostData(param1.cost[10]);
         _openCostX100 = new CostData(param1.cost[100]);
         _openCostX10Free = new CostData(param1.cost[1]);
         _openCostX10Free.multiply(10);
      }
      
      public function get openCostX1() : CostData
      {
         return _openCostX1;
      }
      
      public function get openCostX10() : CostData
      {
         return _openCostX10;
      }
      
      public function get openCostX10Free() : CostData
      {
         return _openCostX10Free;
      }
      
      public function get openCostX100() : CostData
      {
         return _openCostX100;
      }
   }
}
