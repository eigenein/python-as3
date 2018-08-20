package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class TitanArenaEnemyPopupClipPortraitGroup extends GuiClipNestedContainer
   {
       
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var clan_icon_bg:ClipSprite;
      
      public var portrait:PlayerPortraitClip;
      
      public function TitanArenaEnemyPopupClipPortraitGroup()
      {
         clan_icon = new ClanIconWithFrameClip();
         clan_icon_bg = new ClipSprite();
         portrait = new PlayerPortraitClip();
         super();
      }
   }
}
