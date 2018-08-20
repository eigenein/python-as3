package game.mediator.gui.popup.resourcepanel
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   
   public class ResourcePanelValueObjectGroup
   {
       
      
      private var player:Player;
      
      private var emptyInventoryItems:Dictionary;
      
      private var _data:Vector.<ResourcePanelValueObject>;
      
      public var stashSource:PopupStashEventParams;
      
      public function ResourcePanelValueObjectGroup(param1:Player)
      {
         emptyInventoryItems = new Dictionary();
         super();
         _data = new Vector.<ResourcePanelValueObject>();
         this.player = param1;
         param1.signal_update.initSignal.add(handler_playerInit);
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         player.signal_update.initSignal.remove(handler_playerInit);
         player.signal_update.stamina.remove(handler_updateStamina);
         player.signal_update.gold.remove(handler_updateGold);
         player.signal_update.starmoney.remove(handler_updateStarmoney);
         var _loc1_:int = _data.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _data[_loc2_].signal_amountUpdate.clear();
            _data[_loc2_].signal_refill.clear();
            _loc2_++;
         }
         _data = null;
      }
      
      public function get data() : Vector.<ResourcePanelValueObject>
      {
         return _data;
      }
      
      public function requre_starmoney(param1:Boolean = true) : void
      {
         var _loc2_:ResourcePanelValueObject = new ResourcePanelValueObject(DataStorage.pseudo.STARMONEY,param1);
         _loc2_.signal_refill.add(handler_starmoneyRefill);
         _loc2_.amount = player.starmoney;
         player.signal_update.starmoney.add(handler_updateStarmoney);
         _loc2_.addTooltipData(new ResourcePanelTooltipData(_loc2_));
         add(_loc2_);
      }
      
      public function requre_gold(param1:Boolean = true) : void
      {
         var _loc3_:ResourcePanelValueObject = new ResourcePanelValueObject(DataStorage.pseudo.COIN,param1);
         _loc3_.signal_refill.add(handler_goldRefill);
         _loc3_.amount = player.gold;
         player.signal_update.gold.add(handler_updateGold);
         var _loc2_:PlayerRefillableEntry = player.refillable.getById(DataStorage.refillable.ALCHEMY.id);
         _loc3_.addTooltipData(new ResourcePanelRefillableTooltipData(_loc3_,_loc2_));
         add(_loc3_);
      }
      
      public function requre_stamina(param1:Boolean = true) : void
      {
         var _loc3_:ResourcePanelValueObject = new ResourcePanelValueObject(DataStorage.pseudo.STAMINA,param1);
         var _loc2_:PlayerRefillableEntry = player.refillable.stamina;
         _loc3_.signal_refill.add(handler_staminaRefill);
         _loc3_.amount = player.stamina;
         _loc3_.addTooltipData(new ResourcePanelRefillableTooltipData(_loc3_,_loc2_));
         add(_loc3_);
         player.signal_update.stamina.add(handler_updateStamina);
      }
      
      public function requre_coin(param1:CoinDescription) : ResourcePanelValueObject
      {
         var _loc3_:ResourcePanelValueObject = new ResourcePanelValueObject(param1,false);
         var _loc2_:InventoryItemCountProxy = player.inventory.getItemCounterProxy(param1,false);
         _loc3_.counter = _loc2_;
         _loc3_.addTooltipData(new ResourcePanelTooltipData(_loc3_));
         add(_loc3_);
         return _loc3_;
      }
      
      public function requre_consumable(param1:ConsumableDescription) : ResourcePanelValueObject
      {
         var _loc3_:ResourcePanelValueObject = new ResourcePanelValueObject(param1,false);
         var _loc2_:InventoryItemCountProxy = player.inventory.getItemCounterProxy(param1,false);
         _loc3_.counter = _loc2_;
         _loc3_.addTooltipData(new ResourcePanelTooltipData(_loc3_));
         add(_loc3_);
         return _loc3_;
      }
      
      private function add(param1:ResourcePanelValueObject) : void
      {
         _data.push(param1);
         _data.sort(_sortData);
      }
      
      private function _sortData(param1:ResourcePanelValueObject, param2:ResourcePanelValueObject) : int
      {
         return param2.sortValue - param1.sortValue;
      }
      
      private function handler_playerInit() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc2_ = null;
         handler_updateGold();
         handler_updateStarmoney();
         handler_updateStamina();
         var _loc1_:int = _data.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_data[_loc3_].item == DataStorage.pseudo.STAMINA)
            {
               _loc2_ = player.refillable.stamina;
               (_data[_loc3_].tooltipData as ResourcePanelRefillableTooltipData).setRefillable(_loc2_);
            }
            if(_data[_loc3_].item == DataStorage.pseudo.COIN)
            {
               _loc2_ = player.refillable.getById(DataStorage.refillable.ALCHEMY.id);
               (_data[_loc3_].tooltipData as ResourcePanelRefillableTooltipData).setRefillable(_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function setValueObjectCount(param1:InventoryItemDescription, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = _data.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_data[_loc4_].item == param1)
            {
               _data[_loc4_].amount = param2;
               break;
            }
            _loc4_++;
         }
      }
      
      private function handler_updateGold() : void
      {
         setValueObjectCount(DataStorage.pseudo.COIN,player.gold);
      }
      
      private function handler_updateStarmoney() : void
      {
         setValueObjectCount(DataStorage.pseudo.STARMONEY,player.starmoney);
      }
      
      private function handler_updateStamina() : void
      {
         setValueObjectCount(DataStorage.pseudo.STAMINA,player.stamina);
      }
      
      private function handler_goldRefill(param1:ResourcePanelValueObject) : void
      {
         Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("alchemy"),Stash.click("bank_gold",stashSource));
      }
      
      private function handler_starmoneyRefill(param1:ResourcePanelValueObject) : void
      {
         PopupList.instance.dialog_bank(stashSource);
      }
      
      private function handler_staminaRefill(param1:ResourcePanelValueObject) : void
      {
         Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("stamina"),Stash.click("refill_stamina",stashSource));
      }
   }
}
