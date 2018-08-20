package game.model.user.subscription
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.reward.RewardData;
   
   public class PlayerSubscriptionZeppelinGiftValueObject
   {
       
      
      private var _reward:RewardData;
      
      private var _canFarm:BooleanPropertyWriteable;
      
      public function PlayerSubscriptionZeppelinGiftValueObject(param1:Object)
      {
         _canFarm = new BooleanPropertyWriteable();
         super();
         update(param1);
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get canFarm() : BooleanProperty
      {
         return _canFarm;
      }
      
      function update(param1:Object) : void
      {
         _canFarm.value = param1.available;
         _reward = new RewardData(param1);
      }
      
      function setCanFarm(param1:Boolean) : void
      {
         _canFarm.value = param1;
      }
   }
}
