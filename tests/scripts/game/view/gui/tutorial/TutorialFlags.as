package game.view.gui.tutorial
{
   import engine.context.GameContext;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class TutorialFlags
   {
       
      
      private var player:Player;
      
      private var manager:TutorialTaskManager;
      
      private var _tutorialBattleCounter:int;
      
      public function TutorialFlags()
      {
         super();
      }
      
      public function get mainTutorialCompleted() : Boolean
      {
         return player.tutorial.getUnlockerState("mainTutorialCompleted");
      }
      
      public function get clanScreenIsIntroduced() : Boolean
      {
         return player.tutorial.getUnlockerState("clanScreenIsIntroduced");
      }
      
      public function get tutorialMission() : Boolean
      {
         return _tutorialBattleCounter > 0;
      }
      
      public function get canSellHeroFragments() : Boolean
      {
         return manager.getUnlockerState("canSellHeroFragments");
      }
      
      public function get hideEnterMissionResources() : Boolean
      {
         return !manager.getUnlockerState("showPauseButton");
      }
      
      public function get hideBattleButtons() : Boolean
      {
         return !manager.getUnlockerState("tutorialBattlePassed");
      }
      
      public function get hideBattlePauseButton() : Boolean
      {
         return !manager.getUnlockerState("showPauseButton");
      }
      
      public function get hideChestReBuyButton() : Boolean
      {
         return !manager.getUnlockerState("showChestReBuyButton");
      }
      
      public function get showArenaPlace() : Boolean
      {
         return manager.getUnlockerState("showArenaPlace") || !manager.getUnlockerState("hideArenaPlace");
      }
      
      public function get autoBattleAvailable() : Boolean
      {
         return player.levelData.level.level >= 6;
      }
      
      public function get fastBattleAvailable() : Boolean
      {
         return GameContext.instance.consoleEnabled;
      }
      
      public function get dailyQuestsDimmerTutorialCompleted() : Boolean
      {
         return player.tutorial.getUnlockerState("dailyQuestsDimmerTutorialCompleted");
      }
      
      public function initialize(param1:TutorialTaskManager) : void
      {
         player = GameModel.instance.player;
         this.manager = param1;
      }
      
      public function toggle_tutorialBattle(param1:Boolean) : void
      {
         if(param1)
         {
            _tutorialBattleCounter = Number(_tutorialBattleCounter) + 1;
         }
         else
         {
            _tutorialBattleCounter = Number(_tutorialBattleCounter) - 1;
         }
      }
   }
}
