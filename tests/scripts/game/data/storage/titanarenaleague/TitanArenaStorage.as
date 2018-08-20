package game.data.storage.titanarenaleague
{
   import flash.utils.Dictionary;
   
   public class TitanArenaStorage
   {
       
      
      protected const _leagues:Dictionary = new Dictionary();
      
      protected const _victoryRewards:Dictionary = new Dictionary();
      
      protected const _dailyRewards:Dictionary = new Dictionary();
      
      protected const _tournamentRewards:Vector.<TitanArenaTournamentReward> = new Vector.<TitanArenaTournamentReward>();
      
      public function TitanArenaStorage()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1.league;
         for each(_loc3_ in param1.league)
         {
            _loc4_ = new TitanArenaLeagueDescription(_loc3_);
            _leagues[_loc4_.id] = _loc4_;
         }
         var _loc8_:int = 0;
         var _loc7_:* = param1.victoryReward;
         for each(_loc3_ in param1.victoryReward)
         {
            _loc2_ = new TitanArenaReward(_loc3_);
            _victoryRewards[_loc2_.tournamentPoints] = _loc2_;
         }
         var _loc10_:int = 0;
         var _loc9_:* = param1.dailyReward;
         for each(_loc3_ in param1.dailyReward)
         {
            _loc2_ = new TitanArenaReward(_loc3_);
            _dailyRewards[_loc2_.tournamentPoints] = _loc2_;
         }
         var _loc12_:int = 0;
         var _loc11_:* = param1.tournamentReward;
         for each(_loc3_ in param1.tournamentReward)
         {
            _tournamentRewards.push(new TitanArenaTournamentReward(_loc3_));
         }
      }
      
      public function getLeagueById(param1:int) : TitanArenaLeagueDescription
      {
         return _leagues[param1];
      }
      
      public function getLeaguesList() : Vector.<TitanArenaLeagueDescription>
      {
         var _loc2_:Vector.<TitanArenaLeagueDescription> = new Vector.<TitanArenaLeagueDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _leagues;
         for each(var _loc1_ in _leagues)
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.sort(sortArenaLeagues);
         return _loc2_;
      }
      
      public function getVictoryRewardList() : Vector.<TitanArenaReward>
      {
         var _loc2_:Vector.<TitanArenaReward> = new Vector.<TitanArenaReward>();
         var _loc4_:int = 0;
         var _loc3_:* = _victoryRewards;
         for each(var _loc1_ in _victoryRewards)
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.sort(sortArenaRewards);
         return _loc2_;
      }
      
      public function getDailyRewardList() : Vector.<TitanArenaReward>
      {
         var _loc2_:Vector.<TitanArenaReward> = new Vector.<TitanArenaReward>();
         var _loc4_:int = 0;
         var _loc3_:* = _dailyRewards;
         for each(var _loc1_ in _dailyRewards)
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.sort(sortArenaRewards);
         return _loc2_;
      }
      
      public function getTournamentRewardList() : Vector.<TitanArenaTournamentReward>
      {
         _tournamentRewards.sort(sortTournamentRewards);
         return _tournamentRewards;
      }
      
      public function getTournamentRewardListByCupId(param1:uint) : Vector.<TitanArenaTournamentReward>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<TitanArenaTournamentReward> = new Vector.<TitanArenaTournamentReward>();
         _loc3_ = 0;
         while(_loc3_ < _tournamentRewards.length)
         {
            if(_tournamentRewards[_loc3_].cup == param1)
            {
               _loc2_.push(_tournamentRewards[_loc3_]);
            }
            _loc3_++;
         }
         _loc2_.sort(sortTournamentRewards);
         return _loc2_;
      }
      
      private function sortArenaLeagues(param1:TitanArenaLeagueDescription, param2:TitanArenaLeagueDescription) : int
      {
         return param1.id - param2.id;
      }
      
      private function sortArenaRewards(param1:TitanArenaReward, param2:TitanArenaReward) : int
      {
         return param1.tournamentPoints - param2.tournamentPoints;
      }
      
      private function sortTournamentRewards(param1:TitanArenaTournamentReward, param2:TitanArenaTournamentReward) : int
      {
         return param1.placeFrom - param2.placeFrom;
      }
   }
}
