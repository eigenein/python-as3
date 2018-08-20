package game.model.user.tower
{
   import engine.core.utils.property.IntPropertyWriteable;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.GameModel;
   import game.model.user.inventory.InventoryItemCountProxy;
   
   public class InventoryItemCountProperty extends IntPropertyWriteable
   {
       
      
      private var proxy:InventoryItemCountProxy;
      
      public function InventoryItemCountProperty(param1:InventoryItemDescription, param2:Boolean)
      {
         proxy = GameModel.instance.player.inventory.getItemCounterProxy(param1,param2);
         proxy.signal_update.add(handler_inventoryCountUpdated);
         super(proxy.amount);
      }
      
      override public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
      }
      
      private function handler_inventoryCountUpdated(param1:InventoryItemCountProxy) : void
      {
         signal_update.dispatch(param1.amount);
      }
   }
}
