package game.mechanics.clan_war.model
{
   public class PlayerClanWarCurrentBattle
   {
       
      
      private var inBattle:Boolean = false;
      
      private var _slot:ClanWarSlotValueObject;
      
      private var _endTime:Number;
      
      public function PlayerClanWarCurrentBattle()
      {
         super();
      }
      
      public function get hasCurrentBattle() : Boolean
      {
         return inBattle;
      }
      
      public function get slot() : ClanWarSlotValueObject
      {
         return _slot;
      }
      
      public function get endTime() : Number
      {
         return _endTime;
      }
      
      public function startCurrentBattle(param1:ClanWarSlotValueObject, param2:Number) : void
      {
         inBattle = true;
         this._slot = param1;
         this._endTime = param2;
      }
      
      public function endCurrentBattle() : void
      {
         inBattle = false;
      }
   }
}
