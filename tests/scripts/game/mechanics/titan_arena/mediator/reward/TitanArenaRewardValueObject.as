package game.mechanics.titan_arena.mediator.reward
{
   import game.data.reward.RewardData;
   import game.mediator.gui.component.RewardValueObject;
   
   public class TitanArenaRewardValueObject extends RewardValueObject
   {
       
      
      public var points:uint;
      
      public function TitanArenaRewardValueObject(param1:RewardData)
      {
         super(param1);
      }
   }
}
