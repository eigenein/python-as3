package game.mechanics.titan_arena.mediator.reward
{
   import game.mechanics.titan_arena.model.PlayerTitanArenaDailyNotFarmedRewardData;
   import game.mediator.gui.component.RewardValueObject;
   import game.mediator.gui.component.RewardValueObjectList;
   
   public class TitanArenaRewardValueObjectList extends RewardValueObjectList
   {
       
      
      private var farmedRewards:Vector.<PlayerTitanArenaDailyNotFarmedRewardData>;
      
      public function TitanArenaRewardValueObjectList(param1:Vector.<PlayerTitanArenaDailyNotFarmedRewardData>)
      {
         this.farmedRewards = param1;
         super(null);
      }
      
      override protected function createValueObjectList() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _rewardValueObjectList = new Vector.<RewardValueObject>();
         _loc2_ = 0;
         while(_loc2_ < farmedRewards.length)
         {
            _loc1_ = new TitanArenaRewardValueObject(farmedRewards[_loc2_].reward);
            _loc1_.points = farmedRewards[_loc2_].points;
            _rewardValueObjectList.push(_loc1_);
            _loc2_++;
         }
      }
   }
}
