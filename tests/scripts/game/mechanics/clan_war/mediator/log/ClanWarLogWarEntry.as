package game.mechanics.clan_war.mediator.log
{
   import game.mechanics.clan_war.model.ClanWarDayValueObject;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   
   public class ClanWarLogWarEntry
   {
       
      
      private var _day:ClanWarDayValueObject;
      
      private var _attack:Vector.<ClanWarLogBattleEntry>;
      
      private var _defence:Vector.<ClanWarLogBattleEntry>;
      
      private var _attacker:ClanWarParticipantValueObject;
      
      private var _defender:ClanWarParticipantValueObject;
      
      public function ClanWarLogWarEntry(param1:ClanWarDayValueObject, param2:Vector.<ClanWarLogBattleEntry>, param3:Vector.<ClanWarLogBattleEntry>, param4:ClanWarParticipantValueObject, param5:ClanWarParticipantValueObject)
      {
         super();
         this._day = param1;
         this._attack = param2;
         this._defence = param3;
         _attacker = param4;
         _defender = param5;
      }
      
      public function get day() : ClanWarDayValueObject
      {
         return _day;
      }
      
      public function get attack() : Vector.<ClanWarLogBattleEntry>
      {
         return _attack;
      }
      
      public function get defence() : Vector.<ClanWarLogBattleEntry>
      {
         return _defence;
      }
      
      public function get attacker() : ClanWarParticipantValueObject
      {
         return _attacker;
      }
      
      public function get defender() : ClanWarParticipantValueObject
      {
         return _defender;
      }
   }
}
