package game.mediator.gui.popup.shop.soul
{
   import game.command.rpc.inventory.CommandInventoryExchangeStones;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.CoinDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.shop.soul.SoulShopSellFragmentsPopup;
   import idv.cjcat.signals.Signal;
   
   public class SoulShopSellFragmentsPopupMediator extends PopupMediator
   {
       
      
      private var _notEnoughCoins:Boolean;
      
      private var _rewardPerSoulStone:InventoryItem;
      
      private var _reward:InventoryItem;
      
      private var _collection:Vector.<InventoryItem>;
      
      public const signal_update:Signal = new Signal();
      
      public function SoulShopSellFragmentsPopupMediator(param1:Player, param2:Boolean)
      {
         super(param1);
         this._notEnoughCoins = param2;
         _rewardPerSoulStone = DataStorage.rule.shopRule.rewardPerSoulStone;
         _reward = new InventoryItem(_rewardPerSoulStone.item,1);
         updateCollection();
         param1.inventory.signal_update.add(handler_inventoryUpdate);
      }
      
      override protected function dispose() : void
      {
         player.inventory.signal_update.remove(handler_inventoryUpdate);
         super.dispose();
      }
      
      public function get collection() : Vector.<InventoryItem>
      {
         return _collection;
      }
      
      public function get reward() : InventoryItem
      {
         return _reward;
      }
      
      public function get notEnoughCoins() : Boolean
      {
         return _notEnoughCoins;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(_reward.item as CoinDescription);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SoulShopSellFragmentsPopup(this);
         return new SoulShopSellFragmentsPopup(this);
      }
      
      public function action_sell() : void
      {
         var _loc1_:CommandInventoryExchangeStones = GameModel.instance.actionManager.inventory.inventoryExchangeStones();
         _loc1_.onClientExecute(handler_commandSellComplete);
      }
      
      private function updateCollection() : void
      {
         var _loc4_:int = 0;
         _collection = new Vector.<InventoryItem>();
         var _loc2_:Vector.<InventoryItem> = SoulShopUtils.getFragmentsToSell(player);
         var _loc3_:int = _loc2_.length;
         var _loc1_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc1_ + _loc2_[_loc4_].amount;
            _collection.push(_loc2_[_loc4_]);
            _loc4_++;
         }
         _reward.amount = _loc1_ * _rewardPerSoulStone.amount;
         signal_update.dispatch();
      }
      
      private function handler_inventoryUpdate(param1:Inventory, param2:InventoryItem) : void
      {
         updateCollection();
      }
      
      private function handler_commandSellComplete(param1:CommandInventoryExchangeStones) : void
      {
         close();
      }
   }
}
