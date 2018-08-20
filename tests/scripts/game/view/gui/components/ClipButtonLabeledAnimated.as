package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   
   public class ClipButtonLabeledAnimated extends ClipButtonLabeled
   {
       
      
      public var animation_highlight:GuiClipScale9Image;
      
      public function ClipButtonLabeledAnimated()
      {
         animation_highlight = new GuiClipScale9Image();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation_highlight.graphics.blendMode = "add";
         animation_highlight.graphics.filter = new RotatingGlowImageFilter();
      }
   }
}
