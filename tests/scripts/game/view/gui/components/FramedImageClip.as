package game.view.gui.components
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   
   public class FramedImageClip extends GuiClipNestedContainer
   {
       
      
      public var image:GuiClipImage;
      
      public var frame:GuiClipScale9Image;
      
      public function FramedImageClip()
      {
         image = new GuiClipImage();
         frame = new GuiClipScale9Image(new Rectangle(18,18,1,1));
         super();
      }
   }
}
