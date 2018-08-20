package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.model.PlayerTitanArenaDailyNotFarmedRewardData;
   import game.model.user.Player;
   
   public class CommandTitanArenaFarmDailyReward extends CostCommand
   {
       
      
      public var farmedRewards:Vector.<PlayerTitanArenaDailyNotFarmedRewardData>;
      
      public function CommandTitanArenaFarmDailyReward()
      {
         super();
         rpcRequest = new RpcRequest("titanArenaFarmDailyReward");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(farmedRewards && farmedRewards.length)
         {
            param1.titanArenaData.dailyRewardsData.farmNotFarmedRewardsComplete();
         }
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         var _loc1_:* = null;
         _reward = new RewardData();
         farmedRewards = new Vector.<PlayerTitanArenaDailyNotFarmedRewardData>();
         var _loc2_:Object = result.body;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            _loc1_ = new PlayerTitanArenaDailyNotFarmedRewardData();
            _loc1_.points = _loc3_;
            _loc1_.reward = new RewardData(_loc2_[_loc3_]);
            farmedRewards.push(_loc1_);
            _reward.add(_loc1_.reward);
         }
         if(farmedRewards.length)
         {
            farmedRewards.sort(sortRewards);
         }
         super.successHandler();
      }
      
      private function sortRewards(param1:PlayerTitanArenaDailyNotFarmedRewardData, param2:PlayerTitanArenaDailyNotFarmedRewardData) : int
      {
         return param1.points - param2.points;
      }
   }
}
