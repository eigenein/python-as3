package game.mechanics.clan_war.model
{
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import org.osflash.signals.Signal;
   
   public class ClanWarPlanSlotValueObject extends ClanWarSlotBase
   {
       
      
      public const signal_updateState:Signal = new Signal();
      
      public const signal_updatedTeam:Signal = new Signal(ClanWarPlanSlotValueObject);
      
      public function ClanWarPlanSlotValueObject(param1:int, param2:PlayerClanWarData)
      {
         super(param1,param2);
         _property_clanWarSlotState.value = ClanWarSlotState.EMPTY;
      }
      
      public function get playerIsAdmin() : Boolean
      {
         return _clanWarData.property_playerPermission_defenseManagement.value;
      }
      
      public function get canNotInteract() : Boolean
      {
         var _loc1_:Boolean = _clanWarData.property_playerIsWarrior.value;
         return !defender && (playerIsAdmin || _loc1_);
      }
      
      public function get canSetupUser() : Boolean
      {
         var _loc1_:Boolean = _clanWarData.property_playerIsWarrior.value;
         return !defender && (playerIsAdmin || _loc1_);
      }
      
      public function get canRemoveUser() : Boolean
      {
         var _loc1_:Boolean = _defender && _defender.userId == _clanWarData.playerId;
         return _defender && (playerIsAdmin || _loc1_);
      }
      
      function internal_setDefender(param1:ClanWarDefenderValueObject) : void
      {
         if(_defender)
         {
            _defender.signal_updateTeam.remove(handler_updatedTeam);
         }
         _defender = param1;
         _property_clanWarSlotState.value = !!_defender?ClanWarSlotState.READY:ClanWarSlotState.EMPTY;
         if(_defender)
         {
            _defender.signal_updateTeam.add(handler_updatedTeam);
         }
         signal_updateState.dispatch();
      }
      
      function internal_updatePermissions() : void
      {
         signal_updateState.dispatch();
      }
      
      private function handler_updatedTeam(param1:ClanWarDefenderValueObject) : void
      {
         signal_updatedTeam.dispatch(this);
      }
      
      private function handler_playerIsWarrior(param1:Boolean) : void
      {
         signal_updateState.dispatch();
      }
      
      private function handler_playerPermission_defenseManagement(param1:Boolean) : void
      {
         signal_updateState.dispatch();
      }
   }
}
