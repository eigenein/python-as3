package game.view.gui.homescreen
{
   import engine.core.clipgui.GuiClipHitTestImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class HomeScreenDoubleImageHitArea extends GuiClipNestedContainer
   {
       
      
      public var part_1:GuiClipHitTestImage;
      
      public var part_2:GuiClipHitTestImage;
      
      public function HomeScreenDoubleImageHitArea()
      {
         part_1 = new GuiClipHitTestImage();
         part_2 = new GuiClipHitTestImage();
         super();
      }
   }
}
