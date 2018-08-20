package game.mediator.gui.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import game.command.social.BillingBuyCommandBase;
   import game.data.storage.bundle.BundleDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.PopupSideBarMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class BundlePopupMediator extends PopupMediator
   {
       
      
      protected var bundle:BundleDescription;
      
      protected var thisInstanceWasShown:Boolean = false;
      
      protected var _signal_updateBundleTimeLeft:Signal;
      
      protected var _reward:Vector.<InventoryItem>;
      
      protected var _oldPrice:String;
      
      protected var _discountValue:int = 80;
      
      protected var _billing:BillingPopupValueObject;
      
      public const sideBarMediator:PopupSideBarMediator = new PopupSideBarMediator();
      
      public function BundlePopupMediator(param1:Player)
      {
         super(param1);
         _signal_updateBundleTimeLeft = new Signal();
         param1.billingData.bundleData.signal_updateBundleTimeLeft.add(handler_updateTimer);
         var _loc2_:int = param1.billingData.bundleData.activeBundle.id;
         bundle = param1.billingData.bundleData.activeBundle.desc;
         _billing = new BillingPopupValueObject(param1.billingData.getByBundleId(_loc2_),param1);
         _reward = bundle.getRewardList(param1);
         param1.billingData.bundleData.signal_update.add(handler_bundleUpdate);
         param1.billingData.bundleData.signal_bundleWasShown.add(handler_someBundleWasShown);
         sideBarMediator.addValueObjectSource(param1.specialOffer.hooks.bundleSideBarValueObjects);
      }
      
      override protected function dispose() : void
      {
         _signal_updateBundleTimeLeft.clear();
         if(player)
         {
            player.billingData.bundleData.signal_updateBundleTimeLeft.remove(handler_updateTimer);
            player.billingData.bundleData.signal_update.remove(handler_bundleUpdate);
            player.billingData.bundleData.signal_bundleWasShown.remove(handler_someBundleWasShown);
         }
         sideBarMediator.dispose();
         super.dispose();
      }
      
      public function get bundleId() : int
      {
         return !!bundle?bundle.id:0;
      }
      
      public function get signal_updateBundleTimeLeft() : Signal
      {
         return _signal_updateBundleTimeLeft;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _reward;
      }
      
      public function get hasTimer() : Boolean
      {
         return player.billingData.bundleData.needTimer;
      }
      
      public function get bundleTimeLeft() : String
      {
         return player.billingData.bundleData.bundleTimeLeft;
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
         if(Translate.has(bundle.desc_locale_key))
         {
            return Translate.translate(bundle.desc_locale_key);
         }
         return "";
      }
      
      public function get bundleTitle() : String
      {
         return Translate.translate(bundle.title_locale_key);
      }
      
      public function get dialogType() : String
      {
         return bundle.dialogType;
      }
      
      public function action_notifyShown() : void
      {
         var _loc1_:PlayerBillingBundleEntry = player.billingData.bundleData.activeBundle;
         if(_loc1_ && _loc1_.desc == bundle)
         {
            thisInstanceWasShown = true;
            player.billingData.bundleData.activeBundleWashShown();
         }
      }
      
      public function action_buy() : void
      {
         Stash.click("bundle_buy:" + bundleId,_popup.stashParams);
         var _loc1_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(billing);
         _loc1_.signal_paymentBoxError.add(handler_paymentError);
         _loc1_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc1_.signal_paymentSuccess.add(handler_paymentSuccess);
      }
      
      public function registerSpecialOfferSpot(param1:ClipLayout) : void
      {
         player.specialOffer.hooks.registerBundlePopupSpecialOffer(param1);
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
         var _loc4_:HeroBundleRewardPopupDescription = new HeroBundleRewardPopupDescription();
         _loc4_.title = bundleTitle;
         _loc4_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         _loc4_.description = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         var _loc3_:Vector.<InventoryItem> = param1.reward.outputDisplay;
         _loc4_.reward = _loc3_;
         var _loc2_:HeroBundleRewardPopup = new HeroBundleRewardPopup(_loc4_);
         _loc2_.open();
      }
      
      protected function handler_bundleUpdate(param1:Boolean) : void
      {
         if(!player.billingData.bundleData.activeBundle || player.billingData.bundleData.activeBundle.desc != bundle)
         {
            close();
         }
      }
      
      private function handler_updateTimer() : void
      {
         _signal_updateBundleTimeLeft.dispatch();
      }
      
      protected function handler_someBundleWasShown(param1:BundleDescription) : void
      {
         if(this.bundle == param1 && !thisInstanceWasShown)
         {
            close();
         }
      }
   }
}
