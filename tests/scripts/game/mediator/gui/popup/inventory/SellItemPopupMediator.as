package game.mediator.gui.popup.inventory
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.inventory.SellItemPopup;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class SellItemPopupMediator extends PopupMediator
   {
       
      
      private var _amount:int;
      
      private var _item:InventoryItem;
      
      private var _signal_sell:Signal;
      
      private var _signal_amountUpdate:Signal;
      
      public function SellItemPopupMediator(param1:Player, param2:InventoryItem)
      {
         _signal_sell = new Signal();
         _signal_amountUpdate = new Signal();
         super(param1);
         _item = param2;
         _amount = 1;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_gold();
         if(item.sellCost && item.sellCost.outputDisplayFirst && item.sellCost.outputDisplayFirst.item is CoinDescription)
         {
            _loc1_.requre_coin(DataStorage.coin.getByIdent((item.sellCost.outputDisplayFirst.item as CoinDescription).ident));
         }
         return _loc1_;
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
      
      public function get sellCoinIcon() : Texture
      {
         if(_item.sellCost.gold > 0)
         {
            return AssetStorage.rsx.popup_theme.getTexture("icon_gold_coin");
         }
         return AssetStorage.rsx.popup_theme.getTexture(_item.sellCost.outputDisplayFirst.item.iconAssetTexture);
      }
      
      public function get sellProfit() : int
      {
         if(_item.sellCost.gold > 0)
         {
            return amount * _item.sellCost.gold;
         }
         return amount * _item.sellCost.outputDisplayFirst.amount;
      }
      
      public function get sellProfitBase() : int
      {
         if(_item.sellCost.gold > 0)
         {
            return _item.sellCost.gold;
         }
         return _item.sellCost.outputDisplayFirst.amount;
      }
      
      public function get desc() : InventoryItemDescription
      {
         return _item.item;
      }
      
      public function get signal_sell() : Signal
      {
         return _signal_sell;
      }
      
      public function get signal_amountUpdate() : Signal
      {
         return _signal_amountUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SellItemPopup(this);
         return _popup;
      }
      
      public function action_sell() : void
      {
         GameModel.instance.actionManager.inventory.inventorySell(desc,amount,_item is InventoryFragmentItem);
         _signal_sell.dispatch();
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
