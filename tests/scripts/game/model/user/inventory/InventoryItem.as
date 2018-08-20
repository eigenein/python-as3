package game.model.user.inventory
{
   import game.data.reward.RewardData;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import org.osflash.signals.Signal;
   
   public class InventoryItem
   {
       
      
      private var _updateSignal:Signal;
      
      protected var _item:InventoryItemDescription;
      
      protected var _amount:uint;
      
      public function InventoryItem(param1:InventoryItemDescription, param2:Number = 1)
      {
         super();
         _item = param1;
         _amount = param2;
      }
      
      public function get notification() : Boolean
      {
         if(item is ConsumableDescription && (item as ConsumableDescription).rewardType == "lootBox")
         {
            return true;
         }
         return false;
      }
      
      public function get signal_update() : Signal
      {
         if(!_updateSignal)
         {
            _updateSignal = new Signal(InventoryItem);
         }
         return _updateSignal;
      }
      
      public final function get item() : InventoryItemDescription
      {
         return _item;
      }
      
      public final function get id() : int
      {
         return item.id;
      }
      
      public function get name() : String
      {
         return _item.name;
      }
      
      public function get descText() : String
      {
         return _item.descText;
      }
      
      public function get amount() : Number
      {
         return _amount;
      }
      
      public function set amount(param1:Number) : void
      {
         if(_amount != param1)
         {
            _amount = param1;
            if(_updateSignal)
            {
               _updateSignal.dispatch(this);
            }
         }
      }
      
      public function get sellCost() : RewardData
      {
         return item.sellCost;
      }
      
      public function toString() : String
      {
         return item.name + " x" + amount;
      }
   }
}
