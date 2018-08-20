package game.mediator.gui.popup.billing.bundle
{
   import game.command.social.BillingBuyCommandBase;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.VipLevelUpPopupHandler;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.promo.RaidPromoExtendedPopup;
   import game.view.popup.billing.promo.RaidPromoPopup;
   
   public class RaidPromoPopupMediator extends PopupMediator
   {
       
      
      private var raidPromoBilling:BillingPopupValueObject;
      
      public function RaidPromoPopupMediator(param1:Player)
      {
         super(param1);
         raidPromoBilling = new BillingPopupValueObject(param1.billingData.getRaidPromoBilling(),param1);
      }
      
      public function get reward_potion_icon() : String
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<InventoryItem> = raidPromoBilling.reward.outputDisplay;
         var _loc1_:int = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc3_[_loc2_].item.type == InventoryItemType.CONSUMABLE)
            {
               return _loc3_[_loc2_].item.assetTexture;
            }
            _loc2_++;
         }
         return "";
      }
      
      public function get reward_potion_amount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<InventoryItem> = raidPromoBilling.reward.outputDisplay;
         var _loc1_:int = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc3_[_loc2_].item.type == InventoryItemType.CONSUMABLE)
            {
               return _loc3_[_loc2_].amount;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return raidPromoBilling.reward.outputDisplay;
      }
      
      public function get reward_vipPoints() : int
      {
         return raidPromoBilling.reward.vipPoints;
      }
      
      public function get costString() : String
      {
         return raidPromoBilling.costString;
      }
      
      public function get reward_skillPoints() : int
      {
         return raidPromoBilling.reward.skill_point;
      }
      
      public function get starmoney() : int
      {
         return raidPromoBilling.reward.starmoney;
      }
      
      override public function createPopup() : PopupBase
      {
         if(starmoney > 0)
         {
            _popup = new RaidPromoExtendedPopup(this);
         }
         else
         {
            _popup = new RaidPromoPopup(this);
         }
         return _popup;
      }
      
      public function action_buy() : void
      {
         var _loc1_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(raidPromoBilling);
         _loc1_.signal_paymentBoxError.add(handler_paymentError);
         _loc1_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc1_.signal_paymentSuccess.add(handler_paymentSuccess);
         VipLevelUpPopupHandler.instance.hold();
      }
      
      protected function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentConfirm(param1:BillingBuyCommandBase) : void
      {
         if(!disposed && player)
         {
            close();
         }
      }
      
      protected function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
         VipLevelUpPopupHandler.instance.release();
      }
   }
}
