package game.view.gui.components.tooltip
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitleAndDescriptionTooltipClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tooltip_layout:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public function TitleAndDescriptionTooltipClip()
      {
         tf_title = new ClipLabel();
         tf_desc = new ClipLabel();
         tooltip_layout = ClipLayout.verticalCenter(4,tf_title,tf_desc);
         bg = new GuiClipScale9Image();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tooltip_layout.height = NaN;
      }
   }
}
