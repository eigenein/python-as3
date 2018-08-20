package game.view.gui.tutorial
{
   import game.view.gui.tutorial.condition.TutorialCondition;
   
   public interface ITutorialConditionListener
   {
       
      
      function triggerCondition(param1:TutorialCondition) : void;
   }
}
