package game.data.storage.chest
{
   import game.data.storage.resource.InventoryItemDescription;
   
   public class ChestRewardPresentationValueObject
   {
       
      
      private var _item:InventoryItemDescription;
      
      private var _priority:int;
      
      private var _is_new:Boolean;
      
      private var _is_unique:Boolean;
      
      public function ChestRewardPresentationValueObject(param1:InventoryItemDescription, param2:int, param3:Boolean)
      {
         super();
         this._is_new = param3;
         this._priority = param2;
         this._item = param1;
      }
      
      public function get item() : InventoryItemDescription
      {
         return _item;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function get is_new() : Boolean
      {
         return _is_new;
      }
      
      public function get is_unique() : Boolean
      {
         return _is_unique;
      }
      
      public function set is_unique(param1:Boolean) : void
      {
         _is_unique = param1;
      }
   }
}
