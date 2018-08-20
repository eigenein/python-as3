package game.mechanics.clan_war.mediator.log
{
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.storage.ClanWarSlotDescription;
   import game.util.DateFormatter;
   
   public class ClanWarLogBattleValueObjectBase
   {
       
      
      protected var mediator:ClanWarLogBattlePopupMediator;
      
      protected var entry:ClanWarLogBattleEntry;
      
      public function ClanWarLogBattleValueObjectBase(param1:ClanWarLogBattlePopupMediator, param2:ClanWarLogBattleEntry)
      {
         super();
         this.mediator = param1;
         this.entry = param2;
      }
      
      public function get dateString() : String
      {
         return DateFormatter.HHMMSS(entry.timestamp);
      }
      
      public function get position() : String
      {
         var _loc1_:ClanWarSlotDescription = DataStorage.clanWar.getSlotById(entry.slotId);
         return !!_loc1_?_loc1_.fortificationDesc.name:"";
      }
      
      public function get positionIndex() : String
      {
         var _loc1_:ClanWarSlotDescription = DataStorage.clanWar.getSlotById(entry.slotId);
         return !!_loc1_?String(_loc1_.fortificationDesc.teamSlots.indexOf(_loc1_) + 1):"?";
      }
      
      public function get points() : int
      {
         return entry.slotPoints;
      }
      
      public function get wasEmpty() : Boolean
      {
         return false;
      }
      
      public function get fortificationIsCaptured() : Boolean
      {
         return false;
      }
   }
}
