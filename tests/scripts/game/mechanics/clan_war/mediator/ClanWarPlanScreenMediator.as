package game.mechanics.clan_war.mediator
{
   import engine.core.utils.property.BooleanGroupProperty;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.IBooleanGroupProperty;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   import game.mechanics.clan_war.popup.plan.ClanWarPlanScreen;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class ClanWarPlanScreenMediator extends ClanPopupMediatorBase
   {
      
      private static var _instance:ClanWarPlanScreenMediator;
       
      
      private var _participant_us:ClanWarParticipantValueObject;
      
      private var _nextWarIsTomorrow:Boolean;
      
      private var _properties_permissions:BooleanGroupProperty;
      
      public function ClanWarPlanScreenMediator(param1:Player)
      {
         super(param1);
         _instance = this;
         _participant_us = new ClanWarParticipantValueObject(param1.clan.clan,null);
         param1.clan.clanWarData.action_updateDefenderData();
      }
      
      public static function get instance() : ClanWarPlanScreenMediator
      {
         return _instance;
      }
      
      override protected function dispose() : void
      {
         _instance = null;
         if(_properties_permissions)
         {
            _properties_permissions.dispose();
         }
         super.dispose();
      }
      
      public function get title_leader() : String
      {
         return "^{252 252 249}^" + player.clan.clan.roleNames.displayedTitle_leader + "^{252 229 183}^";
      }
      
      public function get title_warlord() : String
      {
         return "^{252 252 249}^" + player.clan.clan.roleNames.displayedTitle_warlord + "^{252 229 183}^";
      }
      
      public function get participant_us() : ClanWarParticipantValueObject
      {
         return _participant_us;
      }
      
      public function get playerPermission_defenseManagement() : Boolean
      {
         return player.clan.clanWarData.property_playerPermission_defenseManagement.value;
      }
      
      public function get playerPermission_warrior() : Boolean
      {
         return player.clan.clanWarData.playerPermission_warrior;
      }
      
      public function get defendersInitialized() : Boolean
      {
         return player.clan.clanWarData.defendersInitialized;
      }
      
      public function get signal_defendersUpdate() : org.osflash.signals.Signal
      {
         return player.clan.clanWarData.signal_defendersUpdate;
      }
      
      public function get signal_roleUpdate() : idv.cjcat.signals.Signal
      {
         return player.clan.signal_roleUpdate;
      }
      
      public function get nextWarIsTomorrow() : Boolean
      {
         return _nextWarIsTomorrow;
      }
      
      public function get properties_permissions() : IBooleanGroupProperty
      {
         if(_properties_permissions)
         {
            return _properties_permissions;
         }
         var _loc1_:BooleanProperty = player.clan.clanWarData.property_playerIsWarrior;
         var _loc2_:BooleanProperty = player.clan.clanWarData.property_playerPermission_defenseManagement;
         _properties_permissions = new BooleanGroupProperty(_loc1_,_loc2_);
         return new BooleanGroupProperty(_loc1_,_loc2_);
      }
      
      public function get redMarkerState_canAssignMoreChampions() : Boolean
      {
         var _loc1_:Boolean = player.clan.playerRole.code == 255 || player.clan.playerRole.code == 4;
         return _loc1_ && player.clan.clanWarData.redMarkerState_canAssignMoreChampions;
      }
      
      public function get signal_warriorsUpdate() : org.osflash.signals.Signal
      {
         return player.clan.clanWarData.signal_warriorsUpdate;
      }
      
      public function action_assignChampions() : void
      {
         var _loc1_:ClanWarAssignChampionsPopupMediator = new ClanWarAssignChampionsPopupMediator(player);
         _loc1_.open(Stash.click("warriors",_popup.stashParams));
      }
      
      public function action_selectPlanBuilding(param1:ClanWarFortificationDescription) : void
      {
         var _loc2_:ClanWarBuildingPlanPopupMediator = new ClanWarBuildingPlanPopupMediator(player,param1,getSlots(param1));
         _loc2_.open(Stash.click("building:" + param1.id,_popup.stashParams));
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarPlanScreen(this);
         return _popup;
      }
      
      public function getSlots(param1:ClanWarFortificationDescription) : Vector.<ClanWarPlanSlotValueObject>
      {
         return player.clan.clanWarData.getSlots(param1);
      }
   }
}
