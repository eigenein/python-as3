package game.mechanics.titan_arena.mediator.raid
{
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.titan_arena.mediator.TitanArenaRaidAttackTeamGatherPopupMediator;
   import game.mechanics.titan_arena.popup.raid.TitanArenaRaidStartPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class TitanArenaRaidStartPopupMediator extends PopupMediator
   {
       
      
      private var teamGatherPopupMedaitor:PopupMediator;
      
      private var attackersTeam:Vector.<UnitDescription>;
      
      public const signal_attackersChanged:Signal = new Signal();
      
      public const signal_defendersChanged:Signal = new Signal();
      
      public function TitanArenaRaidStartPopupMediator(param1:Player)
      {
         super(param1);
         attackersTeam = param1.heroes.teamData.getByActivity(MechanicStorage.TITAN_ARENA);
         param1.titanArenaData.signal_defenderTeamUpdate.add(handler_defenderTeamUpdate);
      }
      
      override protected function dispose() : void
      {
         player.titanArenaData.signal_defenderTeamUpdate.remove(handler_defenderTeamUpdate);
         super.dispose();
      }
      
      public function get attackers() : Vector.<UnitEntryValueObject>
      {
         return UnitUtils.unitDescriptionVectorToUnitEntryValueObjectVector(player,attackersTeam);
      }
      
      public function get defenders() : Vector.<UnitEntryValueObject>
      {
         return player.titanArenaData.defenders;
      }
      
      public function get canEditDefenders() : Boolean
      {
         return player.titanArenaData.canUpdateDefenders.value;
      }
      
      public function get stage() : int
      {
         return player.titanArenaData.property_tier.value;
      }
      
      public function get isFinalStage() : Boolean
      {
         return player.titanArenaData.isFinalStage;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaRaidStartPopup(this);
         return new TitanArenaRaidStartPopup(this);
      }
      
      public function action_changeAttackers() : void
      {
         var _loc1_:TitanArenaRaidAttackTeamGatherPopupMediator = new TitanArenaRaidAttackTeamGatherPopupMediator(player,attackersTeam);
         _loc1_.signal_teamGatherComplete.add(handler_attackersTeamGatherComplete);
         _loc1_.open(Stash.click("changeAttackers",popup.stashSourceClick));
      }
      
      public function action_changeDefenders() : void
      {
         player.titanArenaData.action_updateDefenders();
      }
      
      public function action_start() : void
      {
         new TitanArenaRaidPopupMediator(player,attackersTeam).open(Stash.click("start",popup.stashParams));
         close();
      }
      
      private function handler_attackersTeamUpdate() : void
      {
         signal_attackersChanged.dispatch();
      }
      
      private function handler_defenderTeamUpdate() : void
      {
         signal_defendersChanged.dispatch();
      }
      
      private function handler_attackersTeamGatherComplete(param1:TeamGatherPopupMediator) : void
      {
         attackersTeam = param1.descriptionList;
         param1.close();
         signal_attackersChanged.dispatch();
      }
   }
}
