package game.model.user.inventory
{
   import game.data.cost.CostData;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.resource.ScrollItemDescription;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class InventoryItemValueObject
   {
       
      
      private var _counter:InventoryItemCountProxy;
      
      private var _player:Player;
      
      private var _ii:InventoryItem;
      
      public const signal_amountUpdate:Signal = new Signal();
      
      public function InventoryItemValueObject(param1:Player, param2:InventoryItem)
      {
         super();
         this._player = param1;
         this._ii = param2;
         if(!(param2.item is PseudoResourceDescription))
         {
            _counter = param1.inventory.getItemCounterProxy(param2.item,param2 is InventoryFragmentItem);
            _counter.signal_update.add(handler_itemAmountUpdate);
         }
      }
      
      public function dispose() : void
      {
         if(_counter)
         {
            _counter.dispose();
         }
      }
      
      public function get stateAsHeroSlotState() : int
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(ownedAmount >= amount)
         {
            return 0;
         }
         _loc3_ = item as GearItemDescription;
         _loc2_ = item as ScrollItemDescription;
         if(_loc3_)
         {
            _loc1_ = _loc3_.craftRecipe;
         }
         else if(_loc2_)
         {
            _loc1_ = _loc2_.fragmentMergeCost;
         }
         if(!_loc1_ && _loc3_ && !(_ii is InventoryFragmentItem))
         {
            _loc1_ = _loc3_.fragmentMergeCost;
         }
         if(_loc1_ && !_loc1_.isEmpty)
         {
            return 4;
         }
         return 3;
      }
      
      public function get inventoryItem() : InventoryItem
      {
         return _ii;
      }
      
      public function get item() : InventoryItemDescription
      {
         return _ii.item;
      }
      
      public function get amount() : int
      {
         return _ii.amount;
      }
      
      public function get ownedAmount() : int
      {
         if(_ii is InventoryFragmentItem || _ii.item is UnitDescription)
         {
            return _player.inventory.getFragmentCount(_ii.item);
         }
         return _player.inventory.getItemCount(_ii.item);
      }
      
      public function get owned() : Boolean
      {
         return amount <= ownedAmount;
      }
      
      public function get name() : String
      {
         return inventoryItem.name;
      }
      
      private function handler_itemAmountUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_amountUpdate.dispatch();
      }
   }
}
