package game.mediator.gui.popup.arena
{
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.team.SingleTeamGatherWithEnemyPopupMediator;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   
   public class ArenaAttackTeamGatherPopupMediator extends SingleTeamGatherWithEnemyPopupMediator
   {
       
      
      private var _enemy:PlayerArenaEnemy;
      
      public function ArenaAttackTeamGatherPopupMediator(param1:Player, param2:PlayerArenaEnemy)
      {
         var _loc3_:MechanicDescription = MechanicStorage.ARENA;
         super(param1,_loc3_);
         _enemy = param2;
      }
      
      public function get enemy() : PlayerArenaEnemy
      {
         return _enemy;
      }
      
      override public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         return _enemy.getTeam(0);
      }
      
      override public function get enemyTeamPower() : int
      {
         return _enemy.power;
      }
      
      override public function get tutorialStartAction() : TutorialNode
      {
         return TutorialNavigator.ACTION_START_ARENA_BATTLE;
      }
      
      override public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TEAM_GATHER_ARENA;
      }
   }
}
