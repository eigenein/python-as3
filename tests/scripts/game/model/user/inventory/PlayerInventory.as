package game.model.user.inventory
{
   import flash.utils.Dictionary;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.InventoryItemDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerInventory
   {
       
      
      private var counterProxyList:Dictionary;
      
      private const _signal_update:Signal = new Signal(Inventory,InventoryItem);
      
      private const inventoryItems:Inventory = new Inventory();
      
      private const inventoryItemFragments:FragmentInventory = new FragmentInventory();
      
      public function PlayerInventory()
      {
         counterProxyList = new Dictionary();
         super();
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function init(param1:Object) : void
      {
         inventoryItems.addRawData(param1);
         inventoryItemFragments.addRawData(param1);
         inventoryItems.updateSignal.add(inventoryUpdateHandler);
         inventoryItemFragments.updateSignal.add(fragmentInventoryUpdateHandler);
      }
      
      public function addItem(param1:InventoryItemDescription, param2:int) : void
      {
         inventoryItems.addItem(param1,param2);
      }
      
      public function getFragmentCollection() : Inventory
      {
         return inventoryItemFragments;
      }
      
      public function getItemCollection() : Inventory
      {
         return inventoryItems;
      }
      
      public function getItemCount(param1:InventoryItemDescription) : int
      {
         return inventoryItems.getCollectionByType(param1.type).getItemCount(param1);
      }
      
      public function getFragmentCount(param1:InventoryItemDescription) : int
      {
         return inventoryItemFragments.getCollectionByType(param1.type).getItemCount(param1);
      }
      
      public function getItemCounterProxy(param1:InventoryItemDescription, param2:Boolean) : InventoryItemCountProxy
      {
         var _loc4_:* = null;
         var _loc3_:InventoryItemCountProxy = new InventoryItemCountProxy(param1,param2,this);
         if(param2)
         {
            _loc4_ = getFragmentCollection().getItem(param1);
         }
         else
         {
            _loc4_ = getItemCollection().getItem(param1);
         }
         if(!_loc4_)
         {
            counterProxyList[_loc3_.uid] = _loc3_;
         }
         else
         {
            _loc3_.setInventoryItem(_loc4_);
         }
         return _loc3_;
      }
      
      function disposeItemCounterProxy(param1:InventoryItemCountProxy) : void
      {
      }
      
      function addItemCounterProxy(param1:InventoryItemCountProxy) : void
      {
         counterProxyList[param1.uid] = param1;
      }
      
      public function hasNotifications() : Boolean
      {
         return hasNotificationsByItemType(InventoryItemType.CONSUMABLE);
      }
      
      public function hasNotificationsByItemType(param1:InventoryItemType) : Boolean
      {
         var _loc3_:Array = inventoryItems.getCollectionByType(param1).getArray();
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.notification)
            {
               return true;
            }
         }
         return false;
      }
      
      private function inventoryUpdateHandler(param1:InventoryItem) : void
      {
         if(param1.amount > 0)
         {
            updateRegisteredProxies(param1);
         }
         _signal_update.dispatch(inventoryItems,param1);
      }
      
      private function fragmentInventoryUpdateHandler(param1:InventoryItem) : void
      {
         updateRegisteredProxies(param1);
         _signal_update.dispatch(inventoryItemFragments,param1);
      }
      
      private function updateRegisteredProxies(param1:InventoryItem) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = counterProxyList;
         for each(var _loc2_ in counterProxyList)
         {
            if(param1 is InventoryFragmentItem)
            {
               if(_loc2_.fragment && _loc2_.item == param1.item)
               {
                  _loc2_.setInventoryItem(param1);
                  delete counterProxyList[_loc2_.uid];
               }
            }
            else if(!_loc2_.fragment && _loc2_.item == param1.item)
            {
               _loc2_.setInventoryItem(param1);
               delete counterProxyList[_loc2_.uid];
            }
         }
      }
   }
}
