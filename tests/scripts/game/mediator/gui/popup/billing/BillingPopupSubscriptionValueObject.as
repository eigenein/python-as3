package game.mediator.gui.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.subscription.PlayerSubscriptionData;
   import idv.cjcat.signals.Signal;
   
   public class BillingPopupSubscriptionValueObject extends BillingPopupValueObject
   {
       
      
      private var _signal_updated:Signal;
      
      public function BillingPopupSubscriptionValueObject(param1:PlayerBillingDescription, param2:Player)
      {
         _signal_updated = new Signal();
         super(param1,param2);
         param2.subscription.signal_updated.add(handler_subscriptionUpdated);
      }
      
      override public function dispose() : void
      {
         player.subscription.signal_updated.remove(handler_subscriptionUpdated);
      }
      
      override public function get signal_updated() : Signal
      {
         return _signal_updated;
      }
      
      public function get durationLeft() : String
      {
         return getTimeLeft(player.subscription.subscriptionInfo.hoursLeft);
      }
      
      public function get toRewnewLeft() : String
      {
         return getTimeLeft(player.subscription.subscriptionInfo.secondsLeftToRenew);
      }
      
      override public function get orderDuration() : String
      {
         if(player.subscription.subscriptionInfo.current)
         {
            return player.subscription.subscriptionInfo.localeTimeLeft;
         }
         return _desc.localeData.orderDuration;
      }
      
      override public function get mainStarmoneyReward() : Number
      {
         if(player.subscription.subscriptionInfo.hasCurrent)
         {
            return subscriptionRewardPerDay;
         }
         return reward.starmoney + vipBonusStarmoney + subscriptionRewardPerDay * subscriptionDuration;
      }
      
      override public function get rewardComment() : String
      {
         if(player.subscription.subscriptionInfo.hasCurrent)
         {
            return Translate.translate("UI_DIALOG_BILLING_IN_A_DAY");
         }
         return _desc.localeData.rewardComment;
      }
      
      override public function get available() : Boolean
      {
         return player.subscription.subscriptionInfo.buyAvailable;
      }
      
      private function getTimeLeft(param1:int) : String
      {
         if(param1 > 24)
         {
            return Translate.translateArgs("UI_DIALOG_BILLING_SUBSCRIPTION_DAYS",int(param1 / 24));
         }
         if(param1 > 0)
         {
            return Translate.translateArgs("UI_DIALOG_BILLING_SUBSCRIPTION_HOURS",param1);
         }
         return Translate.translate("UI_DIALOG_BILLING_SUBSCRIPTION_LESS_THAN_AN_HOUR");
      }
      
      private function handler_subscriptionUpdated(param1:PlayerSubscriptionData) : void
      {
         _signal_updated.dispatch();
      }
   }
}
