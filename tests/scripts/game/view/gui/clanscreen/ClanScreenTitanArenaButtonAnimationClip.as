package game.view.gui.clanscreen
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClanScreenTitanArenaButtonAnimationClip extends GuiClipNestedContainer
   {
       
      
      public var totem_earth:ClanScreenTitanArenaButtonSpiritTotemClip;
      
      public var totem_fire:ClanScreenTitanArenaButtonSpiritTotemClip;
      
      public var totem_water:ClanScreenTitanArenaButtonSpiritTotemClip;
      
      public function ClanScreenTitanArenaButtonAnimationClip()
      {
         totem_earth = new ClanScreenTitanArenaButtonSpiritTotemClip();
         totem_fire = new ClanScreenTitanArenaButtonSpiritTotemClip();
         totem_water = new ClanScreenTitanArenaButtonSpiritTotemClip();
         super();
      }
   }
}
