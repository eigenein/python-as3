package game.view.popup.titanspiritartifact
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.popup.artifacts.PlayerTitanArtifactItemRenderer;
   
   public class TitanSpiritArtifactListRendererClip extends GuiClipNestedContainer
   {
       
      
      public var item:PlayerTitanArtifactItemRenderer;
      
      public var icon_red_dot:GuiClipImage;
      
      public var selected_frame:GuiClipImage;
      
      public var selected_arrow:GuiClipImage;
      
      public function TitanSpiritArtifactListRendererClip()
      {
         item = new PlayerTitanArtifactItemRenderer();
         icon_red_dot = new GuiClipImage();
         selected_frame = new GuiClipImage();
         selected_arrow = new GuiClipImage();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         container.useHandCursor = true;
      }
   }
}
