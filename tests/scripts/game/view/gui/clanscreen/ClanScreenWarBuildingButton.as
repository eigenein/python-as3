package game.view.gui.clanscreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.homescreen.HomeScreenBuildingButton;
   
   public class ClanScreenWarBuildingButton extends HomeScreenBuildingButton
   {
       
      
      public var arena_sky_front:GuiAnimation;
      
      public function ClanScreenWarBuildingButton()
      {
         arena_sky_front = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         arena_sky_front.playbackSpeed = 0.2;
         arena_sky_front.graphics.touchable = false;
      }
   }
}
