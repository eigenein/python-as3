package game.model.user.inventory
{
   import game.data.storage.resource.InventoryItemDescription;
   import idv.cjcat.signals.Signal;
   
   public class InventoryItemCountProxy
   {
      
      private static var _guid:int;
       
      
      private var inventory:PlayerInventory;
      
      private var inventoryItem:InventoryItem;
      
      private var _uid:int;
      
      private var _fragment:Boolean;
      
      private var _item:InventoryItemDescription;
      
      private var _signal_update:Signal;
      
      public function InventoryItemCountProxy(param1:InventoryItemDescription, param2:Boolean, param3:PlayerInventory)
      {
         _signal_update = new Signal(InventoryItemCountProxy);
         super();
         this.inventory = param3;
         this._fragment = param2;
         this._item = param1;
         _guid = Number(_guid) + 1;
         _uid = Number(_guid);
      }
      
      public function get amount() : int
      {
         return !!inventoryItem?inventoryItem.amount:0;
      }
      
      public function get uid() : int
      {
         return _uid;
      }
      
      public function get fragment() : Boolean
      {
         return _fragment;
      }
      
      public function get item() : InventoryItemDescription
      {
         return _item;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      function setInventoryItem(param1:InventoryItem) : void
      {
         if(inventoryItem != param1)
         {
            inventoryItem = param1;
            inventoryItem.signal_update.add(handler_amountUpdate);
            _signal_update.dispatch(this);
         }
      }
      
      public function dispose() : void
      {
         inventory.disposeItemCounterProxy(this);
         if(inventoryItem)
         {
            inventoryItem.signal_update.remove(handler_amountUpdate);
            inventoryItem = null;
         }
         _signal_update.clear();
         inventory = null;
      }
      
      private function handler_amountUpdate(param1:InventoryItem) : void
      {
         if(param1.amount == 0)
         {
            inventory.addItemCounterProxy(this);
         }
         _signal_update.dispatch(this);
      }
   }
}
