package game.mediator.gui.component
{
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   import idv.cjcat.signals.Signal;
   
   public class SelectableInventoryItemValueObject extends InventoryItemValueObject
   {
       
      
      protected var _sortValue:int;
      
      protected var _selectedAmount:int;
      
      public const signal_selectedAmountChanged:Signal = new Signal(SelectableInventoryItemValueObject);
      
      public function SelectableInventoryItemValueObject(param1:Player, param2:InventoryItem)
      {
         super(param1,param2);
      }
      
      public static function sort(param1:SelectableInventoryItemValueObject, param2:SelectableInventoryItemValueObject) : int
      {
         return param1._sortValue - param2._sortValue;
      }
      
      public function get value() : int
      {
         return 0;
      }
      
      public function get selectedAmount() : int
      {
         return _selectedAmount;
      }
      
      public function get canIncrease() : Boolean
      {
         return _selectedAmount < ownedAmount;
      }
      
      public function get canDecrease() : Boolean
      {
         return _selectedAmount > 0;
      }
      
      public function increaseAmount() : void
      {
         if(!canIncrease)
         {
            return;
         }
         _selectedAmount = Number(_selectedAmount) + 1;
         signal_selectedAmountChanged.dispatch(this);
      }
      
      public function decreaseAmount() : void
      {
         if(!canDecrease)
         {
            return;
         }
         _selectedAmount = Number(_selectedAmount) - 1;
         signal_selectedAmountChanged.dispatch(this);
      }
      
      public function clearAmount() : void
      {
         if(_selectedAmount == 0)
         {
            return;
         }
         _selectedAmount = 0;
         signal_selectedAmountChanged.dispatch(this);
      }
   }
}
