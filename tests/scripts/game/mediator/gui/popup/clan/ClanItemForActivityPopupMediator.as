package game.mediator.gui.popup.clan
{
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import game.command.rpc.clan.CommandClanItemsForActivity;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.mediator.gui.component.SelectableInventoryItemValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanItemForActivityPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanItemForActivityPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var _selectedValue:int;
      
      private var selectedItemsAmounts:Dictionary;
      
      public const signal_progressUpdated:Signal = new Signal();
      
      public const inventoryItemListDataProvider:ListCollection = new ListCollection();
      
      public function ClanItemForActivityPopupMediator(param1:Player)
      {
         selectedItemsAmounts = new Dictionary();
         super(param1);
         updateItems();
         if(param1.clan.clan)
         {
            param1.clan.clan.stat.todayItemsActivity.signal_update.add(handler_todayItemsActivityUpdate);
         }
      }
      
      public function get dailyCap() : int
      {
         return DataStorage.rule.clanRule.itemsActivityDailyCap;
      }
      
      public function get selectedValue() : int
      {
         return Math.min(_selectedValue,dailyCap - todayAlready);
      }
      
      public function get todayAlready() : int
      {
         if(player && player.clan.clan)
         {
            return player.clan.clan.stat.todayItemsActivity.value;
         }
         return 0;
      }
      
      public function get canIncrease() : Boolean
      {
         return todayAlready + _selectedValue < dailyCap;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanItemForActivityPopup(this);
         return new ClanItemForActivityPopup(this);
      }
      
      public function action_confirm() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function clear() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function updateItems() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Vector.<ClanItemForActivityInventoryItemValueObject> = new Vector.<ClanItemForActivityInventoryItemValueObject>();
         var _loc7_:int = 0;
         var _loc6_:* = [InventoryItemType.GEAR,InventoryItemType.SCROLL];
         for each(var _loc5_ in [InventoryItemType.GEAR,InventoryItemType.SCROLL])
         {
            _loc4_ = player.inventory.getItemCollection().getCollectionByType(_loc5_).getArray();
            _loc1_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _addItem(_loc4_[_loc3_],_loc2_);
               _loc3_++;
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = [InventoryItemType.GEAR,InventoryItemType.SCROLL];
         for each(_loc5_ in [InventoryItemType.GEAR,InventoryItemType.SCROLL])
         {
            _loc4_ = player.inventory.getFragmentCollection().getCollectionByType(_loc5_).getArray();
            _loc1_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _addItem(_loc4_[_loc3_],_loc2_);
               _loc3_++;
            }
         }
         _loc2_.sort(SelectableInventoryItemValueObject.sort);
         inventoryItemListDataProvider.data = _loc2_;
      }
      
      private function _addItem(param1:InventoryItem, param2:Vector.<ClanItemForActivityInventoryItemValueObject>) : Boolean
      {
         var _loc3_:* = null;
         if(param1 && param1.item && !param1.item.hidden && (param1.item.enchantValue > 0 || param1.item.fragmentEnchantValue > 0))
         {
            _loc3_ = new ClanItemForActivityInventoryItemValueObject(player,param1,this);
            param2.push(_loc3_);
            _loc3_.signal_selectedAmountChanged.add(handler_selectedAmountChanged);
            return true;
         }
         return false;
      }
      
      private function handler_selectedAmountChanged(param1:ClanItemForActivityInventoryItemValueObject) : void
      {
         _selectedValue = _selectedValue - int(selectedItemsAmounts[param1]);
         selectedItemsAmounts[param1] = param1.selectedAmount * param1.value;
         _selectedValue = _selectedValue + int(selectedItemsAmounts[param1]);
         signal_progressUpdated.dispatch();
      }
      
      private function handler_todayItemsActivityUpdate(param1:int) : void
      {
         signal_progressUpdated.dispatch();
      }
   }
}
