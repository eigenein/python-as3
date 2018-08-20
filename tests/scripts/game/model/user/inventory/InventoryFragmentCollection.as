package game.model.user.inventory
{
   import game.data.storage.resource.InventoryItemDescription;
   
   public class InventoryFragmentCollection extends InventoryCollection
   {
       
      
      public function InventoryFragmentCollection()
      {
         super();
      }
      
      override protected function _addItem_createNewItem(param1:InventoryItemDescription, param2:Number) : InventoryItem
      {
         return new InventoryFragmentItem(param1,param2);
      }
   }
}
