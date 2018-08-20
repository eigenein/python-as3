package game.data.reward
{
   import game.data.storage.subscription.SubscriptionDescription;
   
   public class RewardSubscription
   {
       
      
      private var _subscription:SubscriptionDescription;
      
      private var _farmSubscription:Boolean;
      
      private var _amount:int;
      
      public function RewardSubscription(param1:SubscriptionDescription, param2:int, param3:Boolean = false)
      {
         super();
         this._subscription = param1;
         this._amount = param2;
         this._farmSubscription = param3;
      }
      
      public function get subscription() : SubscriptionDescription
      {
         return _subscription;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get isSubscriptionFarm() : Boolean
      {
         return _farmSubscription;
      }
   }
}
