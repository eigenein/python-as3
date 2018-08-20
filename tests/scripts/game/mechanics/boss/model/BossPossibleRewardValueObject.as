package game.mechanics.boss.model
{
   import game.data.reward.RewardData;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class BossPossibleRewardValueObject
   {
       
      
      private var rawData:Array;
      
      private var list:Vector.<RewardData>;
      
      public function BossPossibleRewardValueObject(param1:Array)
      {
         list = new Vector.<RewardData>();
         super();
         this.rawData = param1;
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            list.push(new RewardData(_loc2_));
         }
      }
      
      public function get oneItem() : Boolean
      {
         return list.length == 1;
      }
      
      public function get possibleRewardItem1() : InventoryItem
      {
         return getRewardItem(0);
      }
      
      public function get possibleRewardItem2() : InventoryItem
      {
         return getRewardItem(1);
      }
      
      public function get possibleRewardItem3() : InventoryItem
      {
         return getRewardItem(2);
      }
      
      public function get heroDescription() : UnitDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function isEqual(param1:Array) : Boolean
      {
         return isEqualRecursive(rawData,param1);
      }
      
      private function isEqualRecursive(param1:*, param2:*) : Boolean
      {
         if(param1 == null || param1 is int || param1 is Number || param2 == null || param2 is int || param2 is Number)
         {
            return param1 == param2;
         }
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc4_++;
            if(isEqualRecursive(param1[_loc3_],param2[_loc3_]) == false)
            {
               return false;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = param2;
         for(_loc3_ in param2)
         {
            _loc4_--;
         }
         return _loc4_ == 0;
      }
      
      private function getRewardItem(param1:int) : InventoryItem
      {
         var _loc2_:* = undefined;
         if(param1 >= 0 && param1 < list.length)
         {
            _loc2_ = list[param1].outputDisplay;
            if(_loc2_.length > 0)
            {
               return _loc2_[0];
            }
         }
         return null;
      }
   }
}
