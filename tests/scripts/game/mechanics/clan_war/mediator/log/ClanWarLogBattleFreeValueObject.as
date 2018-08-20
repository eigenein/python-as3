package game.mechanics.clan_war.mediator.log
{
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.storage.ClanWarSlotDescription;
   
   public class ClanWarLogBattleFreeValueObject extends ClanWarLogBattleValueObjectBase
   {
       
      
      private var _slotsCapturedFree:int = 0;
      
      public function ClanWarLogBattleFreeValueObject(param1:ClanWarLogBattlePopupMediator, param2:ClanWarLogBattleEntry, param3:int)
      {
         super(param1,param2);
         this._slotsCapturedFree = param3;
      }
      
      override public function get wasEmpty() : Boolean
      {
         return true;
      }
      
      override public function get fortificationIsCaptured() : Boolean
      {
         return false;
      }
      
      public function get fortificationSlotsTotal() : int
      {
         var _loc1_:ClanWarSlotDescription = DataStorage.clanWar.getSlotById(entry.slotId);
         return !!_loc1_?_loc1_.fortificationDesc.teamSlots.length:0;
      }
      
      public function get slotsCapturedFree() : int
      {
         return _slotsCapturedFree;
      }
      
      override public function get points() : int
      {
         return super.points * _slotsCapturedFree;
      }
   }
}
