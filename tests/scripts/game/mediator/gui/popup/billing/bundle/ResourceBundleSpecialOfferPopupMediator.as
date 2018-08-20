package game.mediator.gui.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import game.command.social.BillingBuyCommandBase;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import game.view.popup.billing.bundle.ResourceBundleSpecialOfferPopup;
   import idv.cjcat.signals.Signal;
   
   public class ResourceBundleSpecialOfferPopupMediator extends PopupMediator
   {
       
      
      private var _desc:ResourceBundleSpecialofferDescription;
      
      protected var thisInstanceWasShown:Boolean = false;
      
      protected var _signal_updateBundleTimeLeft:Signal;
      
      protected var _reward:Vector.<InventoryItem>;
      
      protected var _oldPrice:String;
      
      protected var _discountValue:int = 80;
      
      protected var _billing:BillingPopupValueObject;
      
      public function ResourceBundleSpecialOfferPopupMediator(param1:Player, param2:ResourceBundleSpecialofferDescription)
      {
         super(param1);
         this._desc = param2;
         _signal_updateBundleTimeLeft = new Signal();
         param2.signal_updateTimeLeft.add(handler_updateTimer);
         _billing = param2.billing;
         _reward = param2.rewardList;
         _desc.signal_removed.add(handler_remove);
      }
      
      override protected function dispose() : void
      {
         _desc.signal_click.removeAll();
         _desc.signal_removed.remove(handler_remove);
         _desc.signal_updateTimeLeft.remove(handler_updateTimer);
         super.dispose();
      }
      
      public function get signal_updateBundleTimeLeft() : Signal
      {
         return _signal_updateBundleTimeLeft;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _reward;
      }
      
      public function get bundleTimeLeft() : String
      {
         return !!_desc.timeLeftMethod?_desc.timeLeftMethod():"-";
      }
      
      public function get oldPrice() : String
      {
         var _loc3_:String = billing.costString;
         var _loc2_:Array = _loc3_.split(" ");
         var _loc1_:Number = _loc2_[0];
         _loc1_ = _loc1_ * (100 / (100 - _discountValue));
         if(Math.round(_loc1_) != _loc1_)
         {
            return _loc1_.toFixed(2) + " " + _loc2_[1];
         }
         return _loc1_ + " " + _loc2_[1];
      }
      
      public function get discountValue() : int
      {
         return _discountValue;
      }
      
      public function get billing() : BillingPopupValueObject
      {
         return _billing;
      }
      
      public function get bundleDescription() : String
      {
         if(Translate.has(_desc.description))
         {
            return Translate.translate(_desc.description);
         }
         return "";
      }
      
      public function get bundleTitle() : String
      {
         return Translate.translate(_desc.title);
      }
      
      override public function createPopup() : PopupBase
      {
         var _loc1_:* = null;
         if(_desc.PopupClass == null)
         {
            _popup = new ResourceBundleSpecialOfferPopup(this);
         }
         else
         {
            _loc1_ = _desc.PopupClass;
            _popup = new _loc1_(this);
         }
         return _popup;
      }
      
      public function action_buy() : void
      {
         Stash.click("billing_buy:" + _desc.billing.desc.id,_popup.stashParams);
         var _loc1_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(billing);
         _loc1_.signal_paymentBoxError.add(handler_paymentError);
         _loc1_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc1_.signal_paymentSuccess.add(handler_paymentSuccess);
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
         var _loc3_:HeroBundleRewardPopupDescription = new HeroBundleRewardPopupDescription();
         _loc3_.title = bundleTitle;
         _loc3_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         _loc3_.description = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         _loc3_.reward = param1.reward.outputDisplay;
         var _loc2_:HeroBundleRewardPopup = new HeroBundleRewardPopup(_loc3_);
         _loc2_.open();
      }
      
      private function handler_updateTimer() : void
      {
         _signal_updateBundleTimeLeft.dispatch();
      }
      
      private function handler_remove() : void
      {
         close();
      }
   }
}
