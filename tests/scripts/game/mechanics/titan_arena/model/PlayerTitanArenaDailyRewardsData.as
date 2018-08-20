package game.mechanics.titan_arena.model
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import org.osflash.signals.Signal;
   
   public class PlayerTitanArenaDailyRewardsData
   {
       
      
      public var place:uint;
      
      public var dailyScore:uint;
      
      public var weeklyScore:uint;
      
      public var notFarmedRewards:Vector.<PlayerTitanArenaDailyNotFarmedRewardData>;
      
      public var firstNotFarmedReward:PlayerTitanArenaDailyNotFarmedRewardData;
      
      private var _signal_farmReward:Signal;
      
      private var _signal_update:Signal;
      
      public function PlayerTitanArenaDailyRewardsData()
      {
         _signal_farmReward = new Signal();
         _signal_update = new Signal();
         super();
      }
      
      public function get signal_farmReward() : Signal
      {
         return _signal_farmReward;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:* = null;
         dailyScore = param1.dailyScore;
         weeklyScore = param1.weeklyScore;
         place = param1.place;
         notFarmedRewards = new Vector.<PlayerTitanArenaDailyNotFarmedRewardData>();
         firstNotFarmedReward = null;
         var _loc3_:Object = param1.rewards;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for(var _loc4_ in _loc3_)
         {
            _loc2_ = new PlayerTitanArenaDailyNotFarmedRewardData();
            _loc2_.points = _loc4_;
            _loc2_.reward = new RewardData(_loc3_[_loc4_]);
            notFarmedRewards.push(_loc2_);
         }
         if(notFarmedRewards.length)
         {
            notFarmedRewards.sort(sortRewards);
            firstNotFarmedReward = notFarmedRewards[0];
         }
         signal_update.dispatch();
      }
      
      public function farmNotFarmedRewardsComplete() : void
      {
         notFarmedRewards.length = 0;
         firstNotFarmedReward = null;
         signal_farmReward.dispatch();
         signal_update.dispatch();
      }
      
      public function addPoints(param1:uint) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         dailyScore = dailyScore + param1;
         weeklyScore = weeklyScore + param1;
         var _loc4_:Vector.<TitanArenaReward> = DataStorage.titanArena.getDailyRewardList();
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(dailyScore - param1 < _loc4_[_loc3_].tournamentPoints && dailyScore >= _loc4_[_loc3_].tournamentPoints)
            {
               _loc2_ = new PlayerTitanArenaDailyNotFarmedRewardData();
               _loc2_.points = _loc4_[_loc3_].tournamentPoints;
               _loc2_.reward = _loc4_[_loc3_].reward;
               notFarmedRewards.push(_loc2_);
            }
            _loc3_++;
         }
         if(notFarmedRewards.length)
         {
            notFarmedRewards.sort(sortRewards);
            firstNotFarmedReward = notFarmedRewards[0];
         }
         signal_update.dispatch();
      }
      
      private function sortRewards(param1:PlayerTitanArenaDailyNotFarmedRewardData, param2:PlayerTitanArenaDailyNotFarmedRewardData) : int
      {
         return param2.points - param1.points;
      }
   }
}
