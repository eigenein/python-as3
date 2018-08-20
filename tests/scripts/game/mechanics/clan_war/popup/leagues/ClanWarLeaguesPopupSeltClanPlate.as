package game.mechanics.clan_war.popup.leagues
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanWarLeaguesPopupSeltClanPlate extends GuiClipNestedContainer
   {
       
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var name_tf:ClipLabel;
      
      public var league_tf:ClipLabel;
      
      public var points_tf:ClipLabel;
      
      public var icon_VP:ClipSprite;
      
      public var layout_vp:ClipLayout;
      
      public function ClanWarLeaguesPopupSeltClanPlate()
      {
         clan_icon = new ClanIconWithFrameClip();
         name_tf = new ClipLabel();
         league_tf = new ClipLabel();
         points_tf = new ClipLabel(true);
         icon_VP = new ClipSprite();
         layout_vp = ClipLayout.horizontalMiddleLeft(3,points_tf,icon_VP);
         super();
      }
      
      public function dispose() : void
      {
         if(clan_icon)
         {
            clan_icon.dispose();
         }
         graphics.dispose();
      }
   }
}
