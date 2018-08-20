package game.mechanics.grand.mediator
{
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.view.popup.PopupBase;
   import game.view.popup.team.GrandAttackTeamGatherPopup;
   
   public class GrandAttackTeamGatherPopupMediator extends GrandDefendersTeamGatherPopupMedaitor
   {
       
      
      private var _enemy:PlayerArenaEnemy;
      
      public function GrandAttackTeamGatherPopupMediator(param1:Player, param2:PlayerArenaEnemy)
      {
         _enemy = param2;
         super(param1,param1.heroes.teamData.grandTeams);
         _signal_teamGatherComplete.addOnce(handler_teamGatherComplete);
      }
      
      public function get enemyTeamTooltip() : String
      {
         var _loc1_:int = 0;
         while(_enemy.getTeam(_loc1_).length != 0)
         {
            _loc1_++;
         }
         return DataStorage.rule.arenaRule.resolveGrandHideTopMessage(_loc1_);
      }
      
      public function get enemy() : PlayerArenaEnemy
      {
         return _enemy;
      }
      
      public function get enemyHeroes() : Vector.<UnitEntryValueObject>
      {
         return _enemy.getTeam(_selectedTeam.value);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new GrandAttackTeamGatherPopup(this);
         _popup.stashParams.windowName = "team_gather:grandArena_defense";
         return _popup;
      }
      
      private function handler_teamGatherComplete(param1:GrandAttackTeamGatherPopupMediator) : void
      {
         player.heroes.teamData.grandTeams = teams;
      }
   }
}
