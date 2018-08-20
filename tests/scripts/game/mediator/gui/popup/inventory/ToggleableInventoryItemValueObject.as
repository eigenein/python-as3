package game.mediator.gui.popup.inventory
{
   import game.mediator.gui.component.ToggleComponent;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   
   public class ToggleableInventoryItemValueObject extends InventoryItemValueObject
   {
       
      
      public const toggle:ToggleComponent = new ToggleComponent(this);
      
      public function ToggleableInventoryItemValueObject(param1:Player, param2:InventoryItem)
      {
         super(param1,param2);
      }
   }
}
