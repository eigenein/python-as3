package game.command.rpc.inventory
{
   import game.data.reward.RewardData;
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.component.RewardValueObject;
   import game.mediator.gui.component.RewardValueObjectList;
   
   public class LootBoxRewardValueObjectList extends RewardValueObjectList
   {
       
      
      private var item:ConsumableDescription;
      
      public function LootBoxRewardValueObjectList(param1:Vector.<RewardData>, param2:ConsumableDescription)
      {
         this.item = param2;
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
            if(_loc1_.heroCards && _loc1_.heroCards.length)
            {
               _hasShardedHeroes = true;
            }
            if(_loc1_.heroes && _loc1_.heroes.length)
            {
               _hasHeroes = true;
            }
            _merged.add(_loc1_);
            _rewardList = _rewardList.concat(_loc1_.outputDisplay);
            _loc2_++;
            _rewardValueObjectList.push(new LootBoxRewardValueObject(_loc1_,item,_loc2_));
         }
      }
   }
}
