package game.model.user.specialoffer
{
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   import game.data.storage.chest.ChestDescription;
   
   public class PlayerSpecialOfferCostReplaceData
   {
       
      
      private var object:Object;
      
      private var modifiers:Dictionary;
      
      public function PlayerSpecialOfferCostReplaceData()
      {
         object = {};
         modifiers = new Dictionary();
         super();
      }
      
      public function addModifier(param1:int, param2:Object) : void
      {
         modifiers[param1] = param2;
         updateObject();
      }
      
      public function removeModifier(param1:int) : void
      {
         if(modifiers[param1])
         {
            delete modifiers[param1];
         }
         updateObject();
      }
      
      public function chestOne(param1:ChestDescription) : CostData
      {
         return costFromField(param1.cost,"chest",param1.ident,"one");
      }
      
      public function chestPack(param1:ChestDescription) : CostData
      {
         return costFromField(param1.packCost,"chest",param1.ident,"pack");
      }
      
      public function artifactChestX100(param1:CostData) : CostData
      {
         return costFromField(param1,"artifactChest",100);
      }
      
      public function artifactChestX10(param1:CostData) : CostData
      {
         return costFromField(param1,"artifactChest",10);
      }
      
      public function artifactChestX1(param1:CostData) : CostData
      {
         return costFromField(param1,"artifactChest",1);
      }
      
      public function artifactChestX10Free(param1:CostData) : CostData
      {
         return param1;
      }
      
      public function summoningCircleOpenSingle(param1:CostData, param2:int) : CostData
      {
         return param1;
      }
      
      public function summoningCircleOpenPack(param1:CostData, param2:int) : CostData
      {
         return costFromField(param1,"summoningCircle",param2,"pack");
      }
      
      public function summoningCircleOpenPack10(param1:CostData, param2:int) : CostData
      {
         return costFromField(param1,"summoningCircle",param2,"pack");
      }
      
      protected function updateObject() : void
      {
         object = {};
         var _loc3_:int = 0;
         var _loc2_:* = modifiers;
         for each(var _loc1_ in modifiers)
         {
            addModifierNonRecursive(object,_loc1_);
         }
      }
      
      protected function addModifierNonRecursive(param1:Object, param2:Object) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = param2;
         for(var _loc3_ in param2)
         {
            param1[_loc3_] = param2[_loc3_];
         }
      }
      
      private function costFromField(param1:CostData, ... rest) : CostData
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc6_:Object = object;
         var _loc5_:int = rest.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = rest[_loc4_];
            if(_loc6_[_loc3_])
            {
               _loc6_ = _loc6_[_loc3_];
               _loc4_++;
               continue;
            }
            return param1;
         }
         return new CostData(_loc6_);
      }
   }
}
