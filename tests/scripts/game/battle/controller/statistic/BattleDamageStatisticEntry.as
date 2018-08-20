package game.battle.controller.statistic
{
   public class BattleDamageStatisticEntry
   {
       
      
      private var _id:int;
      
      private var _heroId:int;
      
      private var _damageDealt:int;
      
      public function BattleDamageStatisticEntry(param1:int, param2:int, param3:int)
      {
         super();
         _id = param1;
         _heroId = param2;
         _damageDealt = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get heroId() : int
      {
         return _heroId;
      }
      
      public function get damageDealt() : int
      {
         return _damageDealt;
      }
      
      public function set damageDealt(param1:int) : void
      {
         _damageDealt = param1;
      }
   }
}
