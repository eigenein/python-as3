package game.mediator.gui.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.social.BillingBuyCommandBase;
   import game.command.social.SocialBillingBuyCommand;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.BillingConfirmPopup;
   import idv.cjcat.signals.Signal;
   
   public class BillingConfirmPopupMediator extends PopupMediator
   {
       
      
      private var billing:BillingPopupValueObject;
      
      public const signal_success:Signal = new Signal(SocialBillingBuyCommand);
      
      public const signal_refused:Signal = new Signal();
      
      public const billingBenefitDataProvider:ListCollection = new ListCollection();
      
      public function BillingConfirmPopupMediator(param1:Player, param2:BillingPopupValueObject)
      {
         var _loc6_:int = 0;
         super(param1);
         this.billing = param2;
         var _loc5_:Vector.<BillingBenefitValueObject> = new Vector.<BillingBenefitValueObject>();
         var _loc3_:int = param2.baseStarmoneyReward;
         if(param2.isSubscription)
         {
            _loc5_.push(benefitSubscriptionImmediately(_loc3_));
         }
         else if(_loc3_ > 0)
         {
            _loc5_.push(benefitBaseStarmoney(_loc3_));
         }
         var _loc4_:int = param2.reward.starmoney;
         if(param2.canHaveBonuses)
         {
            if(_loc4_ != _loc3_)
            {
               _loc5_.push(benefitStarmoney(_loc4_ - _loc3_,param2.bonusRewardComment));
            }
            _loc6_ = param2.vipBonusStarmoney;
            if(_loc6_ > 0)
            {
               _loc5_.push(benefitVipLevelStarmoney(_loc6_,param1.vipLevel.level));
            }
         }
         if(param2.isSubscription)
         {
            _loc5_.push(benefitSubscriptionStarmoney(param2.subscriptionRewardPerDay,param2.subscriptionDuration));
         }
         if(param2.vipPoints > 0)
         {
            _loc5_.push(benefitVipPoints(param2.vipPoints));
         }
         param1.specialOffer.hooks.adjustBillingBenefits(param2,_loc5_);
         billingBenefitDataProvider.data = _loc5_;
      }
      
      public function get isSubscription() : Boolean
      {
         return billing.isSubscription;
      }
      
      public function get isTransfer() : Boolean
      {
         return billing.isTransfer;
      }
      
      public function get cost() : String
      {
         return billing.cost;
      }
      
      public function get costString() : String
      {
         return billing.costString;
      }
      
      public function get gemCount() : int
      {
         return billing.mainStarmoneyReward;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BillingConfirmPopup(this);
         return _popup;
      }
      
      public function action_confirm() : void
      {
         var _loc1_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(billing);
         _loc1_.signal_paymentBoxError.add(handler_paymentError);
         _loc1_.signal_paymentSuccess.add(handler_paymentSuccess);
         close();
      }
      
      public function action_close() : void
      {
         signal_refused.dispatch();
         signal_success.clear();
         close();
      }
      
      private function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
         signal_refused.dispatch();
         signal_success.clear();
      }
      
      private function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
         signal_refused.clear();
         signal_success.dispatch(param1 as SocialBillingBuyCommand);
      }
      
      private function benefitBaseStarmoney(param1:int) : BillingBenefitValueObject
      {
         var _loc2_:String = Translate.translateArgs("COMMON_UI_EMERALDS",param1);
         if(billing.rewardComment)
         {
            _loc2_ = _loc2_ + (" " + billing.rewardComment);
         }
         if(billing.orderDuration)
         {
            _loc2_ = _loc2_ + (" " + billing.orderDuration);
         }
         return new BillingBenefitValueObject(true,String(param1),_loc2_);
      }
      
      private function benefitSubscriptionImmediately(param1:int) : BillingBenefitValueObject
      {
         var _loc2_:String = Translate.translateArgs("COMMON_UI_EMERALDS",param1);
         var _loc3_:String = Translate.translate("UI_DIALOG_BILLING_IMMEDIATELY");
         return new BillingBenefitValueObject(true,String(param1),_loc2_ + " " + _loc3_);
      }
      
      private function benefitSubscriptionStarmoney(param1:int, param2:int) : BillingBenefitValueObject
      {
         var _loc3_:* = param1;
         var _loc5_:String = Translate.translateArgs("COMMON_UI_EMERALDS",_loc3_);
         var _loc4_:String = Translate.translateArgs("UI_DIALOG_BILLING_FOR_DURATION_DAYS",param2);
         return new BillingBenefitValueObject(true,String(_loc3_),_loc5_ + " " + _loc4_);
      }
      
      private function benefitStarmoney(param1:int, param2:String) : BillingBenefitValueObject
      {
         return new BillingBenefitValueObject(true,"+" + param1,param2);
      }
      
      private function benefitVipLevelStarmoney(param1:int, param2:int) : BillingBenefitValueObject
      {
         return new BillingBenefitValueObject(true,"+" + param1,"(" + Translate.translate("UI_DIALOG_BILLING_BONUS"),param2,")");
      }
      
      private function benefitVipPoints(param1:int) : BillingBenefitValueObject
      {
         var _loc2_:String = Translate.translateArgs("UI_DIALOG_BILLING_POINTS",param1);
         return new BillingBenefitValueObject(false,String(param1),"",-1,_loc2_);
      }
   }
}
