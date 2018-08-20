package game.mediator.gui.popup.inventory
{
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.inventory.UseStaminaItemPopup;
   import idv.cjcat.signals.Signal;
   
   public class UseStaminaItemPopUpMediator extends PopupMediator
   {
       
      
      private var _amount:int;
      
      private var _item:InventoryItem;
      
      private var _signal_use:Signal;
      
      private var _signal_amountUpdate:Signal;
      
      public function UseStaminaItemPopUpMediator(param1:Player, param2:InventoryItem)
      {
         _signal_use = new Signal();
         _signal_amountUpdate = new Signal();
         super(param1);
         _item = param2;
         _amount = 1;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(param1:int) : void
      {
         if(_amount == param1)
         {
            return;
         }
         _amount = param1;
         _signal_amountUpdate.dispatch();
      }
      
      public function get item() : InventoryItem
      {
         return _item;
      }
      
      public function get amountInStock() : int
      {
         return _item.amount;
      }
      
      public function get staminaProfit() : int
      {
         return amount * staminaProfitBase;
      }
      
      public function get staminaProfitBase() : int
      {
         return desc.rewardAmount;
      }
      
      public function get desc() : ConsumableDescription
      {
         return _item.item as ConsumableDescription;
      }
      
      public function get signal_use() : Signal
      {
         return _signal_use;
      }
      
      public function get signal_amountUpdate() : Signal
      {
         return _signal_amountUpdate;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_stamina();
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new UseStaminaItemPopup(this);
         return _popup;
      }
      
      public function action_use() : void
      {
         GameModel.instance.actionManager.inventory.inventoryUseStamina(desc,amount);
         _signal_use.dispatch();
         close();
      }
      
      public function action_increaseAmount() : void
      {
         if(_amount < amountInStock)
         {
            amount = Number(amount) + 1;
         }
      }
      
      public function action_decreaseAmount() : void
      {
         if(_amount > 1)
         {
            amount = Number(amount) - 1;
         }
      }
      
      public function action_setMaxAmount() : void
      {
         amount = amountInStock;
      }
      
      public function action_setAmount(param1:Number) : void
      {
         amount = param1;
      }
   }
}
