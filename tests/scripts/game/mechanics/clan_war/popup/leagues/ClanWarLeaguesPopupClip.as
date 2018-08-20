package game.mechanics.clan_war.popup.leagues
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarLeaguesPopupClip extends PopupClipBase
   {
       
      
      public var clan_self:ClanWarLeaguesPopupSeltClanPlate;
      
      public var league_tf:ClipLabel;
      
      public var league_desc_tf:ClipLabel;
      
      public var league_desc_layout:ClipLayout;
      
      public var empty_tf:ClipLabel;
      
      public var button_rewards:ClipButtonLabeled;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var layout_tabs:ClipLayout;
      
      public function ClanWarLeaguesPopupClip()
      {
         clan_self = new ClanWarLeaguesPopupSeltClanPlate();
         league_tf = new ClipLabel();
         league_desc_tf = new ClipLabel();
         league_desc_layout = ClipLayout.horizontalMiddleCentered(0,league_desc_tf);
         empty_tf = new ClipLabel();
         button_rewards = new ClipButtonLabeled();
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
   }
}
