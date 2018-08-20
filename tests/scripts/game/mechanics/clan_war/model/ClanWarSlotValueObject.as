package game.mechanics.clan_war.model
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.UserInfo;
   import org.osflash.signals.Signal;
   
   public class ClanWarSlotValueObject extends ClanWarSlotBase
   {
       
      
      private var _signal_updateTeamHP:Signal;
      
      protected var _property_isTierAvailable:BooleanPropertyWriteable;
      
      private var _pointsFarmed:int;
      
      private var _pointsTotal:int;
      
      private var _attackerId:String;
      
      public function ClanWarSlotValueObject(param1:int, param2:Object, param3:int, param4:PlayerClanWarData)
      {
         var _loc5_:* = null;
         _signal_updateTeamHP = new Signal(ClanWarSlotValueObject);
         _property_isTierAvailable = new BooleanPropertyWriteable();
         super(param1,param4);
         _attackerId = param2.attackerId;
         _pointsFarmed = param2.pointsFarmed;
         _pointsTotal = param2.totalPoints;
         _property_clanWarSlotState.value = ClanWarSlotState.getStatus(param2.status);
         if(param2.user)
         {
            _loc5_ = new UserInfo();
            _loc5_.parse(param2.user);
            _defender = new ClanWarDefenderValueObject(param2,param2.user.id,_loc5_,UnitUtils.createUnitEntryVectorFromRawData(param2.team[0]),isHeroSlot);
         }
         else if(param2.team[0])
         {
            _defender = new ClanWarDefenderValueObject(param2,null,null,UnitUtils.createUnitEntryVectorFromRawData(param2.team[0]),isHeroSlot);
         }
         if(_defender)
         {
            _defender.internal_setCurrentSlot(param1);
            _defender.signal_updateTeam.add(handler_teamUpdate);
         }
      }
      
      public function get title_leader() : String
      {
         return "^{252 252 249}^" + _clanWarData.playerClan.roleNames.displayedTitle_leader + "^{252 229 183}^";
      }
      
      public function get title_warlord() : String
      {
         return "^{252 252 249}^" + _clanWarData.playerClan.roleNames.displayedTitle_warlord + "^{252 229 183}^";
      }
      
      public function get playerPermission_warrior() : Boolean
      {
         return _clanWarData && _clanWarData.currentWar && _clanWarData.currentWar.playerPermission_warrior;
      }
      
      public function get signal_updateTeamHP() : Signal
      {
         return _signal_updateTeamHP;
      }
      
      public function get property_isTierAvailable() : BooleanProperty
      {
         return _property_isTierAvailable;
      }
      
      public function get pointsFarmed() : int
      {
         return _pointsFarmed;
      }
      
      public function get pointsTotal() : int
      {
         return _pointsTotal;
      }
      
      public function get attackerId() : String
      {
         return _attackerId;
      }
      
      function internal_setState(param1:ClanWarSlotState) : void
      {
         if(param1 == ClanWarSlotState.DEFEATED)
         {
            _pointsFarmed = _pointsTotal;
         }
         _property_clanWarSlotState.value = param1;
      }
      
      function internal_setTierAvailability(param1:Boolean) : void
      {
         _property_isTierAvailable.value = param1;
      }
      
      function internal_setDefenderTeamHP(param1:Object) : void
      {
      }
      
      public function internal_setPointsFarmed(param1:int) : void
      {
         _pointsFarmed = param1;
      }
      
      private function handler_teamUpdate(param1:ClanWarDefenderValueObject) : void
      {
         _signal_updateTeamHP.dispatch(this);
      }
   }
}
