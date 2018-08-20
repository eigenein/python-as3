package game.battle.gui
{
   import game.view.gui.tutorial.TutorialDarknessFragmentCircle;
   
   public class BattleGuiFragmentScreen extends TutorialDarknessFragmentCircle
   {
       
      
      public function BattleGuiFragmentScreen(param1:Number, param2:Number, param3:uint)
      {
         super(param1,param2,param3);
      }
      
      public function setup(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         circleR = param3;
         circleCenterX = param1;
         circleCenterY = param2;
         circleBlurBorder = param4;
      }
      
      public function clear() : void
      {
         circleR = 0;
      }
   }
}
