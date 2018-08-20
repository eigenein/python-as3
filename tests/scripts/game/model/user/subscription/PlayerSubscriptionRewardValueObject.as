package game.model.user.subscription
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.reward.RewardData;
   
   public class PlayerSubscriptionRewardValueObject
   {
       
      
      private var _canFarm:BooleanPropertyWriteable;
      
      private var _currentReward:RewardData;
      
      private var _dailyReward:RewardData;
      
      private var _notFarmedDays:int;
      
      public function PlayerSubscriptionRewardValueObject(param1:Object)
      {
         _canFarm = new BooleanPropertyWriteable();
         super();
         update(param1);
      }
      
      public function get canFarm() : BooleanProperty
      {
         return _canFarm;
      }
      
      public function get currentReward() : RewardData
      {
         return _currentReward;
      }
      
      public function get dailyReward() : RewardData
      {
         return _dailyReward;
      }
      
      public function get notFarmedDays() : int
      {
         return _notFarmedDays;
      }
      
      function update(param1:Object) : void
      {
         _canFarm.value = param1.availableFarm;
         _currentReward = new RewardData(param1.currentReward);
         _dailyReward = new RewardData(param1.dailyReward);
         _notFarmedDays = param1.notFarmedDays;
      }
      
      function setCanFarm(param1:Boolean) : void
      {
         _canFarm.value = param1;
      }
   }
}
