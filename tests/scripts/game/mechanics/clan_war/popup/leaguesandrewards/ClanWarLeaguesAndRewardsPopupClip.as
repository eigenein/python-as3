package game.mechanics.clan_war.popup.leaguesandrewards
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarLeaguesAndRewardsPopupClip extends PopupClipBase
   {
       
      
      public var title_tf:ClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function ClanWarLeaguesAndRewardsPopupClip()
      {
         title_tf = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
