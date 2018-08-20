package game.mechanics
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.FramedImageClipLoader;
   
   public class MechanicNotEnoughLevelPopupRenderer extends GuiClipNestedContainer
   {
       
      
      public var image:FramedImageClipLoader;
      
      public function MechanicNotEnoughLevelPopupRenderer()
      {
         image = new FramedImageClipLoader();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         image.graphics.touchable = false;
      }
   }
}
