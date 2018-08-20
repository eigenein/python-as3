package game.view.gui.tutorial
{
   import game.data.storage.tutorial.TutorialTaskDescription;
   
   public class CustomTutorialTask extends TutorialTask
   {
       
      
      public function CustomTutorialTask(param1:TutorialTaskDescription, param2:TutorialTaskChain)
      {
         super(param1,param2);
      }
      
      public function next(param1:CustomTutorialTask) : CustomTutorialTask
      {
         task = param1;
         signal_onComplete.add(function(param1:TutorialTask):void
         {
            Tutorial.startCustomTask(task);
         });
         return task;
      }
   }
}
