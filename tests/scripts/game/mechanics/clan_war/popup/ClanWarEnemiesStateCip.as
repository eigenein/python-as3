package game.mechanics.clan_war.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClanWarEnemiesStateCip extends GuiClipNestedContainer
   {
       
      
      public var attacker_info:ClanWarFlagRenderer;
      
      public var defender_info:ClanWarFlagRenderer;
      
      public function ClanWarEnemiesStateCip()
      {
         attacker_info = new ClanWarFlagRenderer(false);
         defender_info = new ClanWarFlagRenderer(true);
         super();
      }
   }
}
