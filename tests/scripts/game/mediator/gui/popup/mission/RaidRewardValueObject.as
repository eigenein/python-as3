package game.mediator.gui.popup.mission
{
   import game.data.reward.RewardData;
   import game.mediator.gui.component.RewardValueObject;
   
   public class RaidRewardValueObject extends RewardValueObject
   {
       
      
      private var _index:int;
      
      public function RaidRewardValueObject(param1:RewardData, param2:int)
      {
         super(param1);
         this._index = param2;
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}
