package game.mechanics.clan_war.popup.members
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ActiveClanWarMembersPopupClip extends PopupClipBase
   {
       
      
      public var layout_banner:ClipLayout;
      
      public var tf_guild_name:ClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var desc_tf:SpecialClipLabel;
      
      public var points_tf:ClipLabel;
      
      public var member_tf:ClipLabel;
      
      public var commands_tf:ClipLabel;
      
      public var attempts_tf:ClipLabel;
      
      public var attempts_counter_tf:SpecialClipLabel;
      
      public var layout_attemps:ClipLayout;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function ActiveClanWarMembersPopupClip()
      {
         layout_banner = ClipLayout.none();
         tf_guild_name = new ClipLabel(true);
         title_tf = new ClipLabel();
         desc_tf = new SpecialClipLabel();
         points_tf = new ClipLabel();
         member_tf = new ClipLabel();
         commands_tf = new ClipLabel();
         attempts_tf = new ClipLabel(true);
         attempts_counter_tf = new SpecialClipLabel(true);
         layout_attemps = ClipLayout.horizontalMiddleCentered(5,attempts_tf,attempts_counter_tf);
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
