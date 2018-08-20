package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class HoverClipButton extends ClipButton
   {
       
      
      protected var tween:Tween;
      
      protected var _hoverAnimationIntensity:int = -1;
      
      public function HoverClipButton()
      {
         tween = new Tween(this,0.5);
         super();
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
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         hoverAnimationIntensity = 0;
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
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            tween.reset(this,0.5);
            tween.animate("hoverAnimationIntensity",100);
            Starling.juggler.add(tween);
         }
         else
         {
            tween.reset(this,0.5);
            tween.animate("hoverAnimationIntensity",0);
            Starling.juggler.add(tween);
         }
      }
   }
}
