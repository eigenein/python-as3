package game.view.popup.activity
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.RotatingGlowImageFilter;
   
   public class ChainQuestsListRendererClip extends GuiClipNestedContainer
   {
       
      
      public var bg:GuiClipScale9Image;
      
      public var bg_selected:GuiClipScale9Image;
      
      public var animation_highlight:GuiClipScale9Image;
      
      public var tf_text:ClipLabel;
      
      public var tf_text_selected:ClipLabel;
      
      public var layout_text:ClipLayout;
      
      public function ChainQuestsListRendererClip()
      {
         bg = new GuiClipScale9Image();
         bg_selected = new GuiClipScale9Image();
         animation_highlight = new GuiClipScale9Image();
         tf_text = new ClipLabel();
         tf_text_selected = new ClipLabel();
         layout_text = ClipLayout.horizontalMiddleCentered(0,tf_text,tf_text_selected);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation_highlight.graphics.blendMode = "add";
         animation_highlight.graphics.filter = new RotatingGlowImageFilter();
         animation_highlight.graphics.visible = false;
      }
   }
}
