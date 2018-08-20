package game.view.gui.overlay.offer
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class BundleButtonTextBlockClip extends GuiClipNestedContainer
   {
       
      
      public const tf_single_line:ClipLabel = new ClipLabel();
      
      public const tf_single_line_14:ClipLabel = new ClipLabel();
      
      public const tf_time:SpecialClipLabel = new SpecialClipLabel();
      
      public const tf_txt_line_1:ClipLabel = new ClipLabel();
      
      public const tf_txt_line_2:ClipLabel = new ClipLabel();
      
      public const layout_single_line:ClipLayout = ClipLayout.horizontalMiddleCentered(0);
      
      public const flag_sprite:GuiAnimation = new GuiAnimation();
      
      public function BundleButtonTextBlockClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         flag_sprite.stop();
      }
   }
}
