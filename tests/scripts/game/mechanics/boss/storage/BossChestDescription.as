package game.mechanics.boss.storage
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   
   public class BossChestDescription
   {
      
      private static var skinCoinReward:RewardData = new RewardData();
       
      
      private var id:int;
      
      private var _cost:CostData;
      
      private var rewards:Vector.<RewardData>;
      
      private var skinCoinCount:int;
      
      public function BossChestDescription(param1:Object)
      {
         super();
         id = param1.id;
         _cost = new CostData(param1.cost);
         rewards = new Vector.<RewardData>();
         var _loc4_:int = 0;
         var _loc3_:* = param1.reward;
         for each(var _loc2_ in param1.reward)
         {
            if(_loc2_ && _loc2_.hasOwnProperty("skinCoin"))
            {
               rewards.push(skinCoinReward);
               skinCoinCount = _loc2_["skinCoin"];
            }
            else
            {
               rewards.push(new RewardData(_loc2_));
            }
         }
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get definedReward() : Boolean
      {
         return rewards.length == 1;
      }
      
      public function getRewardBySlot(param1:int, param2:BossTypeDescription) : RewardData
      {
         var _loc3_:* = null;
         if(param1 >= 0 && param1 <= rewards.length)
         {
            _loc3_ = rewards[param1];
            if(_loc3_ == skinCoinReward)
            {
               _loc3_ = new RewardData();
               _loc3_.addInventoryItem(DataStorage.coin.getCoinById(param2.coinId),skinCoinCount);
            }
            return _loc3_;
         }
         return null;
      }
   }
}
