package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class ClipButtonLabeledGlow extends ClipButtonLabeled
   {
       
      
      public var button_glow:GuiClipScale9Image;
      
      private var _glow:Boolean = true;
      
      private var tween:Tween;
      
      public function ClipButtonLabeledGlow()
      {
         super();
      }
      
      override protected function handler_disposed() : void
      {
         super.handler_disposed();
         Starling.juggler.remove(tween);
      }
      
      public function get glow() : Boolean
      {
         return _glow;
      }
      
      public function set glow(param1:Boolean) : void
      {
         if(_glow == param1)
         {
            return;
         }
         _glow = param1;
         if(_glow)
         {
            Starling.juggler.add(tween);
            button_glow.graphics.alpha = 1;
         }
         else
         {
            Starling.juggler.remove(tween);
            button_glow.graphics.alpha = 0;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tween = new Tween(button_glow.graphics,0.35);
         tween.animate("alpha",0);
         tween.repeatCount = 0;
         tween.reverse = true;
         Starling.juggler.add(tween);
      }
   }
}
