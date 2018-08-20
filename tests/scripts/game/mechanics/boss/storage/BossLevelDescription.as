package game.mechanics.boss.storage
{
   import game.data.reward.RewardData;
   
   public class BossLevelDescription
   {
       
      
      private var _bossLevel:int;
      
      private var _level:int;
      
      private var _stars:int;
      
      private var _color:int;
      
      private var _rawBattleStats:Object;
      
      private var _firstWinReward:RewardData;
      
      private var _everyWinReward:RewardData;
      
      private var _nextLevel:BossLevelDescription;
      
      public function BossLevelDescription(param1:Object)
      {
         super();
         var _loc2_:Object = param1.guiData;
         if(_loc2_)
         {
            _level = _loc2_.level;
            _stars = _loc2_.stars;
            _color = _loc2_.color;
         }
         _bossLevel = param1.bossLevel;
         _rawBattleStats = param1.battleData;
         if(_rawBattleStats == null)
         {
            trace("noStatsForThisLevel");
         }
         if(param1.firstWinReward)
         {
            _firstWinReward = new RewardData(param1.firstWinReward);
         }
         if(param1.everyWinReward)
         {
            _everyWinReward = new RewardData(param1.everyWinReward);
         }
      }
      
      public function get bossLevel() : int
      {
         return _bossLevel;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get stars() : int
      {
         return _stars;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function get battleStats() : Object
      {
         return _rawBattleStats;
      }
      
      public function get firstWinReward() : RewardData
      {
         return _firstWinReward;
      }
      
      public function get everyWinReward() : RewardData
      {
         return _everyWinReward;
      }
      
      public function get nextLevel() : BossLevelDescription
      {
         return _nextLevel;
      }
      
      function setNextLevel(param1:BossLevelDescription) : void
      {
         _nextLevel = param1;
      }
   }
}
