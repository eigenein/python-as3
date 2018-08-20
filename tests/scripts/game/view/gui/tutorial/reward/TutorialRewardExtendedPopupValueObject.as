package game.view.gui.tutorial.reward
{
   import game.model.user.inventory.InventoryItem;
   
   public class TutorialRewardExtendedPopupValueObject
   {
       
      
      private var _item:InventoryItem;
      
      private var _desc:String;
      
      private var _isHighlighted:Boolean;
      
      public function TutorialRewardExtendedPopupValueObject(param1:InventoryItem, param2:String, param3:Boolean)
      {
         super();
         this._item = param1;
         this._desc = param2;
         this._isHighlighted = param3;
      }
      
      public function get item() : InventoryItem
      {
         return _item;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get isHighlighted() : Boolean
      {
         return _isHighlighted;
      }
   }
}
