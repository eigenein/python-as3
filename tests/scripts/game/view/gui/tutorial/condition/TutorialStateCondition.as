package game.view.gui.tutorial.condition
{
   import com.progrestar.common.util.assert;
   import game.view.gui.tutorial.TutorialTask;
   
   public class TutorialStateCondition
   {
       
      
      private var checkMethod:Function;
      
      public function TutorialStateCondition(param1:Function)
      {
         super();
         assert(param1.length == 1);
         this.checkMethod = param1;
      }
      
      public function check(param1:TutorialTask) : Boolean
      {
         return checkMethod(param1);
      }
   }
}
