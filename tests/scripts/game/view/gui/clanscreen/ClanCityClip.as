package game.view.gui.clanscreen
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.homescreen.HomeScreenBuildingButton;
   
   public class ClanCityClip extends GuiClipNestedContainer
   {
       
      
      public var block_clan_info:ClanScreenClanInfoBlock;
      
      public var container_heroes:GuiClipContainer;
      
      public var container_titanhall_titan:GuiClipContainer;
      
      public var button_dungeon:HomeScreenBuildingButton;
      
      public var button_summoncircle:ClanSummoningCircleBuildingButton;
      
      public var button_blacksmith:HomeScreenBuildingButton;
      
      public var button_titanhall:HomeScreenBuildingButton;
      
      public var button_war:ClanScreenWarBuildingButton;
      
      public var button_titanSoulShop:ClanScreenTitanSoulMerchantButton;
      
      public var button_titanArena:ClanScreenTitanArenaButton;
      
      public var untouchable_border_1:ClipSpriteUntouchable;
      
      public function ClanCityClip()
      {
         untouchable_border_1 = new ClipSpriteUntouchable();
         super();
      }
   }
}
