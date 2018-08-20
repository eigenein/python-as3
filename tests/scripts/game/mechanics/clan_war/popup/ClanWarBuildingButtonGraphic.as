package game.mechanics.clan_war.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClanWarBuildingButtonGraphic extends GuiClipNestedContainer
   {
       
      
      public var over:GuiAnimation;
      
      public var up:GuiAnimation;
      
      public function ClanWarBuildingButtonGraphic()
      {
         over = new GuiAnimation();
         up = new GuiAnimation();
         super();
      }
   }
}
