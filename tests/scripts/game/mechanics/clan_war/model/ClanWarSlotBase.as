package game.mechanics.clan_war.model
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mechanics.clan_war.storage.ClanWarSlotDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class ClanWarSlotBase
   {
       
      
      protected var _clanWarData:PlayerClanWarData;
      
      protected var _defender:ClanWarDefenderValueObject;
      
      protected var _id:int;
      
      protected var _property_clanWarSlotState:ObjectPropertyWriteable;
      
      public function ClanWarSlotBase(param1:int, param2:PlayerClanWarData)
      {
         _property_clanWarSlotState = new ObjectPropertyWriteable(ClanWarSlotState);
         super();
         this._id = param1;
         this._clanWarData = param2;
      }
      
      public function get defender() : ClanWarDefenderValueObject
      {
         return _defender;
      }
      
      public function get team() : Vector.<UnitEntryValueObject>
      {
         return !!_defender?_defender.team:null;
      }
      
      public function get fortificationDesc() : ClanWarFortificationDescription
      {
         return DataStorage.clanWar.getFortificationById(desc.fortificationId);
      }
      
      public function get isHeroSlot() : Boolean
      {
         return desc.isHeroSlot;
      }
      
      public function get desc() : ClanWarSlotDescription
      {
         return DataStorage.clanWar.getSlotById(id);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get property_clanWarSlotState() : ObjectProperty
      {
         return _property_clanWarSlotState;
      }
      
      public function get slotState() : ClanWarSlotState
      {
         return _property_clanWarSlotState.value as ClanWarSlotState;
      }
      
      public function get slotNumber() : int
      {
         return desc.index + 1;
      }
      
      public function get teamPower() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(team)
         {
            _loc1_ = team.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = _loc3_ + team[_loc2_].getPower();
               _loc2_++;
            }
         }
         return _loc3_;
      }
   }
}
