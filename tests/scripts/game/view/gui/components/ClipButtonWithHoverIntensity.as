package game.view.gui.components
{
   import engine.core.clipgui.GuiAnimation;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class ClipButtonWithHoverIntensity extends ClipButton
   {
       
      
      protected var tween:Tween;
      
      protected var _hoverAnimationIntensity:int = -1;
      
      public function ClipButtonWithHoverIntensity()
      {
         super();
         createTween();
      }
      
      public function get hoverAnimationIntensity() : int
      {
         return _hoverAnimationIntensity;
      }
      
      public function set hoverAnimationIntensity(param1:int) : void
      {
         if(_hoverAnimationIntensity == param1)
         {
            return;
         }
         _hoverAnimationIntensity = param1;
         handler_hoverAnimationIntensitUpdate(param1);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            tween.reset(this,tween.totalTime);
            tween.animate("hoverAnimationIntensity",100);
            Starling.juggler.add(tween);
         }
         else
         {
            tween.reset(this,tween.totalTime);
            tween.animate("hoverAnimationIntensity",0);
            Starling.juggler.add(tween);
         }
      }
      
      protected function handler_hoverAnimationIntensitUpdate(param1:int) : void
      {
      }
      
      protected function adjustIntensity(param1:GuiAnimation, param2:int) : void
      {
         if(param1)
         {
            param1.graphics.alpha = param2 / 100;
            param1.graphics.visible = param2 > 0;
            if(param2 > 0 && !param1.isPlaying)
            {
               param1.play();
            }
            else if(param2 == 0 && param1.isPlaying)
            {
               param1.stop();
            }
         }
      }
      
      protected function createTween() : void
      {
         tween = new Tween(this,0.5);
      }
   }
}
