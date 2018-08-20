package game.model.user.subscription
{
   import idv.cjcat.signals.Signal;
   
   public class PlayerSubscriptionData
   {
       
      
      public const signal_updated:Signal = new Signal(PlayerSubscriptionData);
      
      private var _dailyReward:PlayerSubscriptionRewardValueObject;
      
      private var _currentZeppelinGift:PlayerSubscriptionZeppelinGiftValueObject;
      
      private var _subscriptionInfo:PlayerSubscriptionInfoValueObject;
      
      public function PlayerSubscriptionData()
      {
         super();
      }
      
      public function get dailyReward() : PlayerSubscriptionRewardValueObject
      {
         return _dailyReward;
      }
      
      public function get currentZeppelinGift() : PlayerSubscriptionZeppelinGiftValueObject
      {
         return _currentZeppelinGift;
      }
      
      public function get subscriptionInfo() : PlayerSubscriptionInfoValueObject
      {
         return _subscriptionInfo;
      }
      
      public function init(param1:Object, param2:Object) : void
      {
         _dailyReward = new PlayerSubscriptionRewardValueObject(param1.dailyReward);
         _subscriptionInfo = new PlayerSubscriptionInfoValueObject(param1.subscription);
         _currentZeppelinGift = new PlayerSubscriptionZeppelinGiftValueObject(param2);
         _subscriptionInfo.signal_update.add(handler_suscriptionUpdate);
         signal_updated.dispatch(this);
      }
      
      public function update(param1:Object) : void
      {
         _subscriptionInfo.update(param1.subscription);
         _dailyReward.update(param1.dailyReward);
      }
      
      public function action_markGiftsAsFarmed() : void
      {
         currentZeppelinGift.setCanFarm(false);
         _dailyReward.setCanFarm(false);
      }
      
      public function action_markVKSubscriptionAsResumed() : void
      {
         _subscriptionInfo.action_VKResume();
      }
      
      private function handler_suscriptionUpdate() : void
      {
         if(!subscriptionInfo.isActive)
         {
            _dailyReward.setCanFarm(false);
         }
         signal_updated.dispatch(this);
      }
   }
}
