package game.view.popup.artifacts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class TitanArtifactListRendererClip extends GuiClipNestedContainer
   {
       
      
      public var item:PlayerTitanArtifactItemRenderer;
      
      public var icon_red_dot:GuiClipImage;
      
      public var bg:GuiClipScale3Image;
      
      public var bg_over:GuiClipImage;
      
      public var bg_selected:GuiClipImage;
      
      public function TitanArtifactListRendererClip()
      {
         item = new PlayerTitanArtifactItemRenderer();
         icon_red_dot = new GuiClipImage();
         bg = new GuiClipScale3Image();
         bg_over = new GuiClipImage();
         bg_selected = new GuiClipImage();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         container.useHandCursor = true;
         item.container.touchable = false;
         bg_over.graphics.visible = false;
      }
   }
}
