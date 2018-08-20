package game.mechanics.expedition.model
{
   import game.model.user.inventory.InventoryItem;
   
   public class SubscriptionRewardPopupValueObject
   {
       
      
      private var _item:InventoryItem;
      
      private var _desc:String;
      
      public function SubscriptionRewardPopupValueObject(param1:InventoryItem, param2:String)
      {
         super();
         this._item = param1;
         this._desc = param2;
      }
      
      public function get item() : InventoryItem
      {
         return _item;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
   }
}
