package game.battle.controller.statistic
{
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class BattleDamageStatisticsValueObject
   {
       
      
      private var stat:BattleDamageStatisticEntry;
      
      private var _hero:UnitEntryValueObject;
      
      private var _maxDamage:int;
      
      public function BattleDamageStatisticsValueObject(param1:UnitEntryValueObject, param2:BattleDamageStatisticEntry)
      {
         super();
         this.stat = param2;
         this._hero = param1;
      }
      
      public function get hero() : UnitEntryValueObject
      {
         return _hero;
      }
      
      public function get name() : String
      {
         return hero.name;
      }
      
      public function get damage() : int
      {
         return !!stat?stat.damageDealt:0;
      }
      
      public function get level() : int
      {
         return hero.level;
      }
      
      public function get maxDamage() : int
      {
         return _maxDamage;
      }
      
      public function set maxDamage(param1:int) : void
      {
         _maxDamage = param1;
      }
   }
}
