package game.model.user.hero.watch
{
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.ConsumableDescription;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   
   public class PlayerInventoryWatcherState
   {
       
      
      private var invalidated:Boolean = true;
      
      public var runeEnchantPointsAvailable:int;
      
      public var runeEnchantConsumables:Vector.<InventoryItem>;
      
      public function PlayerInventoryWatcherState()
      {
         runeEnchantConsumables = new Vector.<InventoryItem>(0);
         super();
      }
      
      public function invalidate() : void
      {
         invalidated = true;
      }
      
      public function validate(param1:Player) : void
      {
         if(!invalidated)
         {
            return;
         }
         invalidated = false;
         runeEnchantPointsAvailable = getRuneEnchantPointsAvailable(param1);
      }
      
      protected function getRuneEnchantPointsAvailable(param1:Player) : int
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         runeEnchantConsumables.length = 0;
         var _loc2_:Array = param1.inventory.getItemCollection().getCollectionByType(InventoryItemType.CONSUMABLE).getArray();
         var _loc6_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_ = _loc2_[_loc4_];
            _loc7_ = _loc3_.item as ConsumableDescription;
            if(_loc7_ != null && _loc7_.rewardType == "enchantValue")
            {
               _loc5_ = _loc5_ + _loc7_.rewardAmount * _loc3_.amount;
               runeEnchantConsumables.push(_loc3_);
            }
            _loc4_++;
         }
         runeEnchantConsumables.sort(sort_consumableByValue);
         return _loc5_;
      }
      
      private function sort_consumableByValue(param1:InventoryItem, param2:InventoryItem) : int
      {
         return (param1.item as ConsumableDescription).rewardAmount - (param2.item as ConsumableDescription).rewardAmount;
      }
   }
}
