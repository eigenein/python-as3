package game.mediator.gui.popup.rune
{
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.component.SelectableInventoryItemValueObject;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   
   public class HeroRunePopupInventoryItemValueObject extends SelectableInventoryItemValueObject
   {
       
      
      protected var mediator:HeroRunePopupMediator;
      
      public function HeroRunePopupInventoryItemValueObject(param1:Player, param2:InventoryItem, param3:HeroRunePopupMediator)
      {
         super(param1,param2);
         this.mediator = param3;
         _sortValue = value * 100 + item.color.id * 2;
         if(!(param2 is InventoryFragmentItem))
         {
            _sortValue = Number(_sortValue) + 1;
         }
      }
      
      override public function get value() : int
      {
         var _loc2_:* = null;
         var _loc1_:InventoryItem = inventoryItem;
         if(item is ConsumableDescription)
         {
            _loc2_ = item as ConsumableDescription;
            if(_loc2_.rewardType == "enchantValue")
            {
               return _loc2_.rewardAmount;
            }
            return 0;
         }
         if(_loc1_ is InventoryFragmentItem)
         {
            return _loc1_.item.fragmentEnchantValue;
         }
         return _loc1_.item.enchantValue;
      }
      
      override public function increaseAmount() : void
      {
         if(!canIncrease || !mediator.enchantProgress.canIncrease)
         {
            return;
         }
         _selectedAmount = Number(_selectedAmount) + 1;
         signal_selectedAmountChanged.dispatch(this);
      }
   }
}
