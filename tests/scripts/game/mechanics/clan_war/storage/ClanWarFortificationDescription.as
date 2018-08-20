package game.mechanics.clan_war.storage
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DescriptionBase;
   
   public class ClanWarFortificationDescription extends DescriptionBase
   {
       
      
      private var _teamSlots:Vector.<ClanWarSlotDescription>;
      
      private var _pointReward:int;
      
      private var _tier:int;
      
      private var _tierUnlock:int;
      
      public function ClanWarFortificationDescription(param1:Object)
      {
         _teamSlots = new Vector.<ClanWarSlotDescription>();
         super();
         _id = param1.id;
         _pointReward = param1.pointReward;
         _tier = param1.tier;
         _tierUnlock = param1.tierUnlock;
      }
      
      public function get teamSlots() : Vector.<ClanWarSlotDescription>
      {
         return _teamSlots;
      }
      
      public function get pointReward() : int
      {
         return _pointReward;
      }
      
      public function get tier() : int
      {
         return _tier;
      }
      
      public function get tierUnlock() : int
      {
         return _tierUnlock;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_CLANWAR_FORTIFICATION_" + _id);
      }
      
      function addSlot(param1:ClanWarSlotDescription) : void
      {
         _teamSlots.push(param1);
      }
   }
}
