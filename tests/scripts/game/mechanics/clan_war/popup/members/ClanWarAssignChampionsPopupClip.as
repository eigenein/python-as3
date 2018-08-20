package game.mechanics.clan_war.popup.members
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanWarAssignChampionsPopupClip extends PopupClipBase
   {
       
      
      public var layout_banner:ClipLayout;
      
      public var tf_guild_name:ClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var desc_tf:SpecialClipLabel;
      
      public var member_tf:ClipLabel;
      
      public var status_tf:ClipLabel;
      
      public var status_counter_tf:SpecialClipLabel;
      
      public var commands_tf:ClipLabel;
      
      public var layout_heroes:ClipLayout;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function ClanWarAssignChampionsPopupClip()
      {
         layout_banner = ClipLayout.none();
         tf_guild_name = new ClipLabel(true);
         title_tf = new ClipLabel();
         desc_tf = new SpecialClipLabel();
         member_tf = new ClipLabel();
         status_tf = new ClipLabel(true);
         status_counter_tf = new SpecialClipLabel(true);
         commands_tf = new ClipLabel();
         layout_heroes = ClipLayout.horizontalMiddleCentered(5,status_tf,status_counter_tf);
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
