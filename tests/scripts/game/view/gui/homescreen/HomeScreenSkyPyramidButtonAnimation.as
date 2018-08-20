package game.view.gui.homescreen
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class HomeScreenSkyPyramidButtonAnimation extends GuiClipNestedContainer
   {
       
      
      public var fire_hover:GuiAnimation;
      
      public var fire_idle:GuiAnimation;
      
      public var stars_hover:GuiAnimation;
      
      public var stars_idle:GuiAnimation;
      
      public var triangle_down:GuiAnimation;
      
      public var triangle_up:GuiAnimation;
      
      public function HomeScreenSkyPyramidButtonAnimation()
      {
         fire_hover = new GuiAnimation();
         fire_idle = new GuiAnimation();
         stars_hover = new GuiAnimation();
         stars_idle = new GuiAnimation();
         triangle_down = new GuiAnimation();
         triangle_up = new GuiAnimation();
         super();
      }
   }
}
