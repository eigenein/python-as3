package game.view.gui.tutorial
{
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   
   public interface ITutorialActionProvider
   {
       
      
      function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder;
   }
}
