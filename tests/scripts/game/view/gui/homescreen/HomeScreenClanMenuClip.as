package game.view.gui.homescreen
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class HomeScreenClanMenuClip extends GuiClipNestedContainer
   {
       
      
      public var btn_clan:HomeScreenClanIconButton;
      
      public var btn_chat:HomeScreenGuiClipButton;
      
      public function HomeScreenClanMenuClip()
      {
         btn_clan = new HomeScreenClanIconButton();
         btn_chat = new HomeScreenGuiClipButton();
         super();
      }
   }
}
