package game.mechanics.clan_war.model
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.model.user.clan.ClanMemberValueObject;
   import idv.cjcat.signals.Signal;
   
   public class ClanWarMemberFullInfoValueObject
   {
       
      
      public const signal_warriorStateUpdated:Signal = new Signal();
      
      private var _warrior:Boolean;
      
      private var _tries:IntPropertyWriteable;
      
      private var _triesMax:int;
      
      private var _user:ClanMemberValueObject;
      
      private var _defenderHeroes:ClanWarDefenderValueObject;
      
      private var _defenderTitans:ClanWarDefenderValueObject;
      
      public function ClanWarMemberFullInfoValueObject(param1:ClanMemberValueObject, param2:ClanWarDefenderValueObject, param3:ClanWarDefenderValueObject)
      {
         _tries = new IntPropertyWriteable();
         super();
         this._user = param1;
         this._defenderHeroes = param2;
         this._defenderTitans = param3;
      }
      
      public function get warrior() : Boolean
      {
         return _warrior;
      }
      
      public function set warrior(param1:Boolean) : void
      {
         _warrior = param1;
         signal_warriorStateUpdated.dispatch();
      }
      
      public function get tries() : IntProperty
      {
         return _tries;
      }
      
      public function get triesMax() : int
      {
         return _triesMax;
      }
      
      public function set triesMax(param1:int) : void
      {
         _triesMax = param1;
      }
      
      public function get user() : ClanMemberValueObject
      {
         return _user;
      }
      
      public function get defenderHeroes() : ClanWarDefenderValueObject
      {
         return _defenderHeroes;
      }
      
      public function get defenderTitans() : ClanWarDefenderValueObject
      {
         return _defenderTitans;
      }
      
      public function setTries(param1:int) : void
      {
         _tries.value = param1;
      }
      
      public function getHeroesAndTitansPower() : uint
      {
         return (!!defenderHeroes?defenderHeroes.teamPower:0) + (!!defenderTitans?defenderTitans.teamPower:0);
      }
   }
}
