package game.mechanics.clan_war.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClanWarScreenView_VSClip extends GuiClipNestedContainer
   {
       
      
      public var attacker_info:ClanWarFlagRenderer;
      
      public var defender_info:ClanWarFlagRenderer;
      
      public function ClanWarScreenView_VSClip()
      {
         attacker_info = new ClanWarFlagRenderer(true);
         defender_info = new ClanWarFlagRenderer(false);
         super();
      }
   }
}
