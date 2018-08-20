package game.mechanics.clan_war.popup.war
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClanWarMapsClip extends GuiClipNestedContainer
   {
       
      
      public var enemy_map:ClanWarMapClip;
      
      public var my_map:ClanWarMapClip;
      
      public function ClanWarMapsClip()
      {
         enemy_map = new ClanWarMapClip();
         my_map = new ClanWarMapClip();
         super();
      }
   }
}
