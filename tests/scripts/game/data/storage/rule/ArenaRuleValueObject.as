package game.data.storage.rule
{
   import com.progrestar.common.lang.Translate;
   import game.data.reward.RewardData;
   
   public class ArenaRuleValueObject
   {
       
      
      private var _grandHideTop:Vector.<int>;
      
      private var _arenaBattlegroundAsset:int;
      
      private var _grandBattlegroundAsset:int;
      
      private var _arenaRankingLockedWinCount:int;
      
      private var _arenaRankingLockedRegistrationTime:int;
      
      private var _arenaEnemiesExpiredDelay:Number;
      
      private var _arenaEnemiesPlayerInactiveDelay:Number;
      
      private var _arenaEnemiesRerollIfNoEnemiesAvailable:Boolean;
      
      private var _arenaEnemiesRerollCooldown:Number;
      
      private var _arenaVictoryReward:RewardData;
      
      public function ArenaRuleValueObject(param1:Object)
      {
         super();
         _grandHideTop = Vector.<int>(param1.grandHideTop);
         _arenaBattlegroundAsset = param1.arenaBattlegroundAsset;
         _grandBattlegroundAsset = param1.grandBattlegroundAsset;
         _arenaRankingLockedWinCount = param1.arenaRankingLockedWinCount;
         _arenaRankingLockedRegistrationTime = param1.arenaRankingLockedRegistrationTime;
         _arenaEnemiesExpiredDelay = param1.arenaEnemiesExpiredDelay;
         _arenaEnemiesPlayerInactiveDelay = param1.arenaEnemiesPlayerInactiveDelay;
         _arenaEnemiesRerollIfNoEnemiesAvailable = param1.arenaEnemiesRerollIfNoEnemiesAvailable;
         _arenaEnemiesRerollCooldown = param1.arenaEnemiesRerollCooldown;
         _arenaVictoryReward = new RewardData(param1.arenaVictoryReward);
      }
      
      public function get arenaVictoryReward() : RewardData
      {
         return _arenaVictoryReward;
      }
      
      public function get arenaRankingLockedWinCount() : int
      {
         return _arenaRankingLockedWinCount;
      }
      
      public function get arenaRankingLockedRegistrationTime() : int
      {
         return _arenaRankingLockedRegistrationTime;
      }
      
      public function get grandHideTop() : Vector.<int>
      {
         return _grandHideTop;
      }
      
      public function get arenaBattlegroundAsset() : int
      {
         return _arenaBattlegroundAsset;
      }
      
      public function get grandBattlegroundAsset() : int
      {
         return _grandBattlegroundAsset;
      }
      
      public function get arenaEnemiesExpiredDelay() : Number
      {
         return _arenaEnemiesExpiredDelay;
      }
      
      public function get arenaEnemiesPlayerInactiveDelay() : Number
      {
         return _arenaEnemiesPlayerInactiveDelay;
      }
      
      public function get arenaEnemiesRerollIfNoEnemiesAvailable() : Boolean
      {
         return _arenaEnemiesRerollIfNoEnemiesAvailable;
      }
      
      public function get arenaEnemiesRerollCooldown() : Number
      {
         return _arenaEnemiesRerollCooldown;
      }
      
      public function resolveGrandHideTopMessage(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1 >= 0 && param1 < _grandHideTop.length)
         {
            if(param1 > 0)
            {
               _loc3_ = _grandHideTop[param1 - 1];
               _loc2_ = _grandHideTop[param1];
               return Translate.translateArgs("UI_TOOLTIP_GRAND_TEAM_HIDE_" + param1,_loc3_ + 1,_loc2_);
            }
            return Translate.translate("UI_TOOLTIP_GRAND_TEAM_HIDE_0");
         }
         return null;
      }
   }
}
