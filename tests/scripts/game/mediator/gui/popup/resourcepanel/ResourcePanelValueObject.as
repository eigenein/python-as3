package game.mediator.gui.popup.resourcepanel
{
   import game.data.storage.DataStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.GameModel;
   import game.model.user.inventory.InventoryItemCountProxy;
   import idv.cjcat.signals.Signal;
   
   public class ResourcePanelValueObject
   {
       
      
      private var refillable:Boolean;
      
      private var _animateChanges:Boolean;
      
      private var _counter:InventoryItemCountProxy;
      
      private var _tooltipData:ResourcePanelTooltipData;
      
      private var _amount:int;
      
      private var _item:InventoryItemDescription;
      
      private var _signal_refill:Signal;
      
      private var _signal_amountUpdate:Signal;
      
      public function ResourcePanelValueObject(param1:InventoryItemDescription, param2:Boolean)
      {
         _signal_refill = new Signal(ResourcePanelValueObject);
         _signal_amountUpdate = new Signal(ResourcePanelValueObject);
         super();
         this._tooltipData = tooltipData;
         this.refillable = param2;
         this._item = param1;
      }
      
      public function dispose() : void
      {
         _counter.dispose();
      }
      
      public function get animateChanges() : Boolean
      {
         return _animateChanges;
      }
      
      public function set animateChanges(param1:Boolean) : void
      {
         if(_animateChanges == param1)
         {
            return;
         }
         _animateChanges = param1;
      }
      
      public function get counter() : InventoryItemCountProxy
      {
         return _counter;
      }
      
      public function set counter(param1:InventoryItemCountProxy) : void
      {
         if(_counter == param1)
         {
            return;
         }
         if(_counter)
         {
            _counter.signal_update.remove(handler_itemCountUpdate);
         }
         _counter = param1;
         _counter.signal_update.add(handler_itemCountUpdate);
         amount = param1.amount;
      }
      
      public function addTooltipData(param1:ResourcePanelTooltipData) : void
      {
         _tooltipData = param1;
      }
      
      public function get tooltipData() : ResourcePanelTooltipData
      {
         return _tooltipData;
      }
      
      public function get canRefill() : Boolean
      {
         return refillable;
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
         _signal_amountUpdate.dispatch(this);
      }
      
      public function get item() : InventoryItemDescription
      {
         return _item;
      }
      
      public function get signal_refill() : Signal
      {
         return _signal_refill;
      }
      
      public function get signal_amountUpdate() : Signal
      {
         return _signal_amountUpdate;
      }
      
      public function get sortValue() : int
      {
         if(_item == DataStorage.pseudo.STARMONEY)
         {
            return 5;
         }
         if(_item == DataStorage.pseudo.COIN)
         {
            return 4;
         }
         if(_item == DataStorage.pseudo.STAMINA)
         {
            return 3;
         }
         return 0;
      }
      
      public function get useRedColor() : Boolean
      {
         return _item == DataStorage.pseudo.STAMINA && GameModel.instance.player.stamina >= GameModel.instance.player.refillable.stamina.maxValue;
      }
      
      public function action_refill() : void
      {
         _signal_refill.dispatch(this);
      }
      
      private function handler_itemCountUpdate(param1:InventoryItemCountProxy) : void
      {
         amount = param1.amount;
      }
   }
}
