package game.data.storage.rule
{
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.artifact.ArtifactChestDropItem;
   import game.data.storage.artifact.ArtifactChestLevel;
   
   public class ArtifactChestRule
   {
       
      
      private var _paidSlotsCount:uint;
      
      private var _weightMainOther:uint;
      
      private var _openCostX1:CostData;
      
      private var _openCostX10:CostData;
      
      private var _openCostX10Free:CostData;
      
      private var _openCostX100:CostData;
      
      private var _core:RewardData;
      
      private var _artifactTypeChance:Dictionary;
      
      private var _chestLevels:Vector.<ArtifactChestLevel>;
      
      private var _dropItems:Vector.<ArtifactChestDropItem>;
      
      public function ArtifactChestRule(param1:Object, param2:Object)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         super();
         _artifactTypeChance = new Dictionary();
         _artifactTypeChance["book"] = Number(param1.artifactTypeChance["book"]);
         _artifactTypeChance["ring"] = Number(param1.artifactTypeChance["ring"]);
         _artifactTypeChance["weapon"] = Number(param1.artifactTypeChance["weapon"]);
         _paidSlotsCount = param1.paidSlotsCount;
         _weightMainOther = param1.weightMainOther;
         if(param1.openCost && param1.openCost.free)
         {
            _openCostX1 = new CostData(param1.openCost.free.x1);
            _openCostX10Free = new CostData(param1.openCost.free.x10);
         }
         if(param1.openCost && param1.openCost.paid)
         {
            _openCostX10 = new CostData(param1.openCost.paid.x10);
            _openCostX100 = new CostData(param1.openCost.paid.x100);
         }
         _core = new RewardData(param1.core);
         _chestLevels = new Vector.<ArtifactChestLevel>();
         if(param1.chestLevel)
         {
            var _loc8_:int = 0;
            var _loc7_:* = param1.chestLevel;
            for(var _loc5_ in param1.chestLevel)
            {
               _loc3_ = new ArtifactChestLevel(_loc5_);
               _loc3_.deserialize(param1.chestLevel[_loc5_]);
               chestLevels.push(_loc3_);
            }
         }
         _dropItems = new Vector.<ArtifactChestDropItem>();
         if(param2.items)
         {
            var _loc10_:int = 0;
            var _loc9_:* = param2.items;
            for(var _loc6_ in param2.items)
            {
               _dropItems.push(new ArtifactChestDropItem(param2.items[_loc6_]));
            }
         }
      }
      
      public function get paidSlotsCount() : uint
      {
         return _paidSlotsCount;
      }
      
      public function get weightMainOther() : uint
      {
         return _weightMainOther;
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
      
      public function get core() : RewardData
      {
         return _core;
      }
      
      public function get artifactTypeChance() : Dictionary
      {
         return _artifactTypeChance;
      }
      
      public function get chestLevels() : Vector.<ArtifactChestLevel>
      {
         return _chestLevels;
      }
      
      public function get dropItems() : Vector.<ArtifactChestDropItem>
      {
         return _dropItems;
      }
      
      public function getChestLelevById(param1:uint) : ArtifactChestLevel
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < chestLevels.length)
         {
            if(chestLevels[_loc2_].level == param1)
            {
               return chestLevels[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
