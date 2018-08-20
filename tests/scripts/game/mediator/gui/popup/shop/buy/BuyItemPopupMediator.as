package game.mediator.gui.popup.shop.buy
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.shop.CommandShopBuy;
   import game.data.cost.CostData;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.reward.RewardPopup;
   import game.view.popup.shop.buy.BuyItemPopup;
   import idv.cjcat.signals.Signal;
   
   public class BuyItemPopupMediator extends PopupMediator
   {
       
      
      private var _shop:ShopDescription;
      
      private var _slot:ShopSlotValueObject;
      
      private var _minItemsAmount:int;
      
      private var _maxItemsAmount:int;
      
      private var _amount:int;
      
      private var _signal_amountUpdate:Signal;
      
      public function BuyItemPopupMediator(param1:Player, param2:ShopDescription, param3:ShopSlotValueObject)
      {
         _signal_amountUpdate = new Signal();
         super(param1);
         _shop = param2;
         _slot = param3;
         _minItemsAmount = _slot.reward.outputDisplayFirst.amount;
         _maxItemsAmount = _slot.reward.outputDisplayFirst.amount * Math.floor(param1.inventory.getItemCount(_slot.cost.outputDisplayFirst.item) / _slot.cost.outputDisplayFirst.amount);
      }
      
      public function get slot() : ShopSlotValueObject
      {
         return _slot;
      }
      
      public function get priceBase() : CostData
      {
         return slot.cost;
      }
      
      public function get price() : CostData
      {
         var _loc1_:CostData = new CostData();
         _loc1_.add(priceBase);
         _loc1_.multiply(slotsAmount);
         return _loc1_;
      }
      
      public function get minItemsAmount() : int
      {
         return _minItemsAmount;
      }
      
      public function get maxItemsAmount() : int
      {
         return _maxItemsAmount;
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
      
      public function get slotsAmount() : int
      {
         return Math.floor(_amount / slot.reward.outputDisplayFirst.amount);
      }
      
      public function get signal_amountUpdate() : Signal
      {
         return _signal_amountUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BuyItemPopup(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(slot.cost.outputDisplayFirst.item as CoinDescription);
         return _loc1_;
      }
      
      public function action_increaseAmount() : void
      {
         if(_amount < maxItemsAmount)
         {
            amount = amount + minItemsAmount;
         }
      }
      
      public function action_decreaseAmount() : void
      {
         if(_amount > minItemsAmount)
         {
            amount = amount - minItemsAmount;
         }
      }
      
      public function action_setAmount(param1:Number) : void
      {
         amount = param1;
      }
      
      public function action_buySlot() : void
      {
         var _loc1_:CommandShopBuy = GameModel.instance.actionManager.shop.shopBuy(_shop,slot,slotsAmount);
         _loc1_.onClientExecute(onShopBuyComplete);
         close();
      }
      
      private function onShopBuyComplete(param1:CommandShopBuy) : void
      {
         var _loc2_:* = null;
         if(param1.reward.outputDisplayFirst && param1.reward.outputDisplayFirst.item.type != InventoryItemType.SKIN)
         {
            _loc2_ = new RewardPopup(param1.reward.outputDisplay,"shopBuyItemReward");
            _loc2_.header = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
            _loc2_.label = "";
            _loc2_.open();
         }
      }
   }
}
