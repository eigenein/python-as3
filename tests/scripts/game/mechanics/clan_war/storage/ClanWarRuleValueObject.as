package game.mechanics.clan_war.storage
{
   public class ClanWarRuleValueObject
   {
       
      
      private var _matchmakingMinOccupiedSlots:int;
      
      private var _victoryPointsPerFortificationTeam:int;
      
      private var _personalAttackLimit:int;
      
      private var _clanAttackLimit:int;
      
      private var _maxWarriors:int;
      
      private var _firstSeason:String;
      
      private var _seasonPromoMatch:int;
      
      private var _heroBattlegroundAsset:int;
      
      private var _titanBattlegroundAsset:int;
      
      public function ClanWarRuleValueObject(param1:Object)
      {
         super();
         _victoryPointsPerFortificationTeam = param1.victoryPointsPerFortificationTeam;
         _personalAttackLimit = param1.personalAttackLimit;
         _clanAttackLimit = param1.clanAttackLimit;
         _maxWarriors = param1.maxWarriors;
         _firstSeason = param1.firstSeason;
         _seasonPromoMatch = param1.seasonPromoMatch;
         _matchmakingMinOccupiedSlots = param1.matchmakingMinOccupiedSlots;
         _heroBattlegroundAsset = param1.heroBattlegroundAsset;
         _titanBattlegroundAsset = param1.titanBattlegroundAsset;
      }
      
      public function get matchmakingMinOccupiedSlots() : int
      {
         return _matchmakingMinOccupiedSlots;
      }
      
      public function get victoryPointsPerFortificationTeam() : int
      {
         return _victoryPointsPerFortificationTeam;
      }
      
      public function get personalAttackLimit() : int
      {
         return _personalAttackLimit;
      }
      
      public function get clanAttackLimit() : int
      {
         return _clanAttackLimit;
      }
      
      public function get maxWarriors() : int
      {
         return _maxWarriors;
      }
      
      public function get firstSeason() : String
      {
         return _firstSeason;
      }
      
      public function get seasonPromoMatch() : int
      {
         return _seasonPromoMatch;
      }
      
      public function get heroBattlegroundAsset() : int
      {
         return _heroBattlegroundAsset;
      }
      
      public function get titanBattlegroundAsset() : int
      {
         return _titanBattlegroundAsset;
      }
   }
}
