package game.mechanics.clan_war.mediator.log
{
   import engine.core.utils.property.IntProperty;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.model.ClanWarDayValueObject;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.model.user.clan.ClanBasicInfoValueObject;
   
   public class ClanWarLogEntry
   {
      
      public static const TYPE_REGULAR:int = 0;
      
      public static const TYPE_UPWARD:int = 1;
      
      public static const TYPE_DOWNWARD:int = 2;
       
      
      private var _attackersId:int;
      
      private var _defendersId:int;
      
      private var _league:ClanWarLeagueDescription;
      
      private var _points:int;
      
      private var _enemyPoints:int;
      
      private var _enemyClan:ClanBasicInfoValueObject;
      
      private var _type:int;
      
      public const day:ClanWarDayValueObject = new ClanWarDayValueObject();
      
      public function ClanWarLogEntry(param1:Object)
      {
         super();
         day.updateFromRawData(param1);
         _league = DataStorage.clanWar.getLeagueById(int(param1.league));
         _attackersId = param1.attackersId;
         _defendersId = param1.defendersId;
         _points = param1.points;
         _enemyPoints = param1.enemyPoints;
         _enemyClan = new ClanBasicInfoValueObject(param1.enemyClan);
         _type = param1.type;
      }
      
      public function get league() : ClanWarLeagueDescription
      {
         return _league;
      }
      
      public function get isDecider() : Boolean
      {
         return _type == 1 || _type == 2;
      }
      
      public function get isUpward() : Boolean
      {
         return _type == 1;
      }
      
      public function createEnemy() : ClanWarParticipantValueObject
      {
         return new ClanWarParticipantValueObject(_enemyClan,new IntProperty(_enemyPoints));
      }
      
      public function createSelf(param1:ClanBasicInfoValueObject) : ClanWarParticipantValueObject
      {
         return new ClanWarParticipantValueObject(param1,new IntProperty(_points));
      }
   }
}
