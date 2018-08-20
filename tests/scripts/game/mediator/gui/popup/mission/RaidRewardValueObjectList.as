package game.mediator.gui.popup.mission
{
   import game.data.reward.RewardData;
   import game.mediator.gui.component.RewardValueObject;
   import game.mediator.gui.component.RewardValueObjectList;
   
   public class RaidRewardValueObjectList extends RewardValueObjectList
   {
       
      
      private var raidReward:RewardData;
      
      public function RaidRewardValueObjectList(param1:Vector.<RewardData>, param2:RewardData)
      {
         this.raidReward = param2;
         super(param1);
      }
      
      override protected function createValueObjectList() : void
      {
         var _loc2_:int = 1;
         _rewardValueObjectList = new Vector.<RewardValueObject>();
         var _loc4_:int = 0;
         var _loc3_:* = _rewards;
         for each(var _loc1_ in _rewards)
         {
            _merged.add(_loc1_);
            _rewardList = _rewardList.concat(_loc1_.outputDisplay);
            _loc2_++;
            _rewardValueObjectList.push(new RaidRewardValueObject(_loc1_,_loc2_));
         }
         _rewardValueObjectList.push(new RaidRewardValueObject(raidReward,-1));
      }
   }
}
