package game.view.gui
{
   import engine.context.GameContext;
   import game.mediator.gui.popup.GamePopupManager;
   import game.screen.FullScreenController;
   import game.view.gui.tutorial.Tutorial;
   import starling.core.Starling;
   import starling.core.StatsDisplay;
   import starling.display.Stage;
   import starling.events.KeyboardEvent;
   
   public class GlobalKeyboardController
   {
       
      
      private var stage:Stage;
      
      public function GlobalKeyboardController()
      {
         super();
      }
      
      public function init(param1:Stage) : void
      {
         this.stage = param1;
         param1.addEventListener("keyDown",onKeyDown);
         Starling.current.showStatsAt("right","bottom");
         if(!GameContext.instance.consoleEnabled)
         {
            StatsDisplay.customOutput.VER = heroes.SVN_PROPS.revision;
            Starling.current.showStats = false;
         }
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 192 && param1.ctrlKey)
         {
            toggleShowStats();
            param1.stopImmediatePropagation();
         }
         else if(param1.keyCode == 70 && param1.ctrlKey)
         {
            FullScreenController.instance.fullScreenOn();
         }
         else if(param1.keyCode == 192)
         {
            if(!GameContext.instance.consoleEnabled)
            {
               toggleShowStats();
            }
         }
         else if(param1.keyCode == 27)
         {
            if(!Tutorial.inputIsBlocked && Game.instance.screen.isOnDialogs)
            {
               GamePopupManager.tryCloseTopMost();
            }
         }
         else if(param1.keyCode == 84 && param1.ctrlKey && param1.shiftKey)
         {
         }
      }
      
      private function toggleShowStats() : void
      {
         Starling.current.showStats = !Starling.current.showStats;
      }
   }
}
