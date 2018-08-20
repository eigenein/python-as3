package game.view.gui.homescreen
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipHitTestImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class HomeScreenExpeditionsButtonZeppelinClip extends GuiClipNestedContainer
   {
       
      
      public var hitTest_image:GuiClipHitTestImage;
      
      public var animation:GuiAnimation;
      
      public var hover_front:GuiAnimation;
      
      public function HomeScreenExpeditionsButtonZeppelinClip()
      {
         hitTest_image = new GuiClipHitTestImage();
         animation = new GuiAnimation();
         hover_front = new GuiAnimation();
         super();
      }
   }
}
