package game.mechanics.clan_war.mediator.log
{
   import com.progrestar.common.lang.Translate;
   import game.mechanics.clan_war.model.ClanWarDayValueObject;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.model.PlayerClanWarCurrentInfo;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.model.user.Player;
   
   public class ClanWarLogItem
   {
       
      
      private var _isCurrent:Boolean;
      
      private var entry:ClanWarLogEntry;
      
      private var self:ClanWarParticipantValueObject;
      
      private var enemy:ClanWarParticipantValueObject;
      
      public function ClanWarLogItem(param1:Player, param2:ClanWarLogEntry)
      {
         super();
         this.entry = param2;
         var _loc3_:PlayerClanWarCurrentInfo = param1.clan.clanWarData.currentWar;
         _isCurrent = _loc3_ && _loc3_.day.isEqual(param2.day);
         if(_isCurrent)
         {
            self = param1.clan.clanWarData.currentWar.participant_us;
            enemy = param1.clan.clanWarData.currentWar.participant_them;
         }
         else
         {
            self = param2.createSelf(param1.clan.clan);
            enemy = param2.createEnemy();
         }
      }
      
      public function get attacker() : ClanWarParticipantValueObject
      {
         return self;
      }
      
      public function get defender() : ClanWarParticipantValueObject
      {
         return enemy;
      }
      
      public function get league() : ClanWarLeagueDescription
      {
         return entry.league;
      }
      
      public function get isCurrent() : Boolean
      {
         return _isCurrent;
      }
      
      public function get isVictory() : Boolean
      {
         return !_isCurrent && self.pointsEarned > enemy.pointsEarned;
      }
      
      public function get isDefeat() : Boolean
      {
         return !_isCurrent && self.pointsEarned < enemy.pointsEarned;
      }
      
      public function get isDraw() : Boolean
      {
         return !_isCurrent && self.pointsEarned == enemy.pointsEarned;
      }
      
      public function get isDecider() : Boolean
      {
         return entry.isDecider;
      }
      
      public function get isUpward() : Boolean
      {
         return entry.isUpward;
      }
      
      public function get dayVo() : ClanWarDayValueObject
      {
         return entry.day;
      }
      
      public function get dateString() : String
      {
         return entry.day.date;
      }
      
      public function get dayString() : String
      {
         var _loc1_:int = entry.day.day;
         return Translate.translate("DAY_OF_WEEK_" + _loc1_);
      }
      
      public function get seasonNum() : int
      {
         return entry.day.week;
      }
   }
}
