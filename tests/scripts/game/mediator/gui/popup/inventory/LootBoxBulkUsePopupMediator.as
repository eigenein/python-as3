package game.mediator.gui.popup.inventory
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.rpc.inventory.CommandConsumableUseLootBox;
   import game.data.storage.DataStorage;
   import game.data.storage.loot.LootBoxDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.ConsumableEffectDescriptionLootBox;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.inventory.LootBoxBulkUsePopup;
   import game.view.popup.reward.multi.MultiRewardGroupedPopup;
   
   public class LootBoxBulkUsePopupMediator extends PopupMediator
   {
       
      
      public var dropTable:ListCollection;
      
      private var _item:InventoryItem;
      
      private var _property_rewardIndex:IntPropertyWriteable;
      
      private var _property_amount:IntPropertyWriteable;
      
      private var _property_amountInStock:IntPropertyWriteable;
      
      public function LootBoxBulkUsePopupMediator(param1:Player, param2:InventoryItem)
      {
         var _loc5_:int = 0;
         _property_rewardIndex = new IntPropertyWriteable(-1);
         _property_amount = new IntPropertyWriteable();
         super(param1);
         this._item = param2;
         dropTable = new ListCollection();
         var _loc4_:String = ((_item.item as ConsumableDescription).effectDescription as ConsumableEffectDescriptionLootBox).lootBoxIdent;
         var _loc6_:LootBoxDescription = DataStorage.lootBox.getByIdent(_loc4_);
         var _loc3_:int = _loc6_.drop.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            dropTable.addItem(_loc6_.drop[_loc5_].reward.outputDisplay[0]);
            _loc5_++;
         }
         _property_amountInStock = new IntPropertyWriteable(int(_item.amount));
         _item.signal_update.add(handler_amountUpdate);
      }
      
      override protected function dispose() : void
      {
         _item.signal_update.remove(handler_amountUpdate);
         super.dispose();
      }
      
      public function get item() : InventoryItem
      {
         return _item;
      }
      
      public function get property_rewardIndex() : IntProperty
      {
         return _property_rewardIndex;
      }
      
      public function get property_amount() : IntPropertyWriteable
      {
         return _property_amount;
      }
      
      public function get desc() : InventoryItemDescription
      {
         return _item.item;
      }
      
      public function get property_amountInStock() : IntProperty
      {
         return _property_amountInStock;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new LootBoxBulkUsePopup(this);
         return _popup;
      }
      
      public function action_use() : void
      {
         var _loc1_:CommandConsumableUseLootBox = GameModel.instance.actionManager.inventory.consumableUseLootBox(desc as ConsumableDescription,_property_amount.value,_property_rewardIndex.value);
         _loc1_.signal_complete.addOnce(handler_lootBoxOpened);
      }
      
      public function action_increaseAmount() : void
      {
         if(_property_amount.value < property_amountInStock.value)
         {
            _property_amount.value++;
         }
      }
      
      public function action_decreaseAmount() : void
      {
         if(_property_amount.value > 1)
         {
            _property_amount.value--;
         }
      }
      
      public function action_setMaxAmount() : void
      {
         _property_amount.value = property_amountInStock.value;
      }
      
      public function action_setAmount(param1:int) : void
      {
         _property_amount.value = param1;
      }
      
      public function action_selectIndex(param1:int) : void
      {
         _property_rewardIndex.value = param1;
      }
      
      private function handler_lootBoxOpened(param1:CommandConsumableUseLootBox) : void
      {
         var _loc2_:MultiRewardGroupedPopup = new MultiRewardGroupedPopup(param1.lootBoxRewardValueObjectList,null);
         PopUpManager.addPopUp(_loc2_);
      }
      
      private function handler_amountUpdate(param1:InventoryItem) : void
      {
         if(_item.amount == 0)
         {
            close();
            return;
         }
         _property_amountInStock.value = int(param1.amount);
      }
   }
}
