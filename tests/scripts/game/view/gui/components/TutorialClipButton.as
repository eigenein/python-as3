package game.view.gui.components
{
   import game.view.gui.tutorial.ITutorialButtonBoundsProvider;
   
   public class TutorialClipButton extends ClipButton implements ITutorialButtonBoundsProvider
   {
       
      
      private var _tutorialButtonOffsetX:Number;
      
      private var _tutorialButtonOffsetY:Number;
      
      private var _tutorialButtonRadius:Number;
      
      public function TutorialClipButton(param1:Number, param2:Number, param3:Number)
      {
         super();
         _tutorialButtonOffsetX = param1;
         _tutorialButtonOffsetY = param2;
         _tutorialButtonRadius = param3;
      }
      
      public function get tutorialButtonOffsetX() : Number
      {
         return _tutorialButtonOffsetX;
      }
      
      public function get tutorialButtonOffsetY() : Number
      {
         return _tutorialButtonOffsetY;
      }
      
      public function get tutorialButtonRadius() : Number
      {
         return _tutorialButtonRadius;
      }
   }
}
