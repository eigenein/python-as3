package game.mechanics.clan_war.popup.members
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.battle.gui.BattleGuiToggleButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarMemberItemRendererEditableClip extends GuiClipNestedContainer
   {
       
      
      public var nickname_tf:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var check_box:BattleGuiToggleButton;
      
      public var heroes_tf:ClipLabel;
      
      public var heroes_power_tf:ClipLabel;
      
      public var heroes_power_icon:ClipSprite;
      
      public var titans_tf:ClipLabel;
      
      public var titans_power_tf:ClipLabel;
      
      public var titans_power_icon:ClipSprite;
      
      public var layout_heroes:ClipLayout;
      
      public var layout_titans:ClipLayout;
      
      public var timeout_lock_icon:ClipSprite;
      
      public var timeout_tf:ClipLabel;
      
      public var layout_timeout:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public function ClanWarMemberItemRendererEditableClip()
      {
         nickname_tf = new ClipLabel();
         portrait = new PlayerPortraitClip();
         check_box = new BattleGuiToggleButton();
         heroes_tf = new ClipLabel(true);
         heroes_power_tf = new ClipLabel(true);
         heroes_power_icon = new ClipSprite();
         titans_tf = new ClipLabel(true);
         titans_power_tf = new ClipLabel(true);
         titans_power_icon = new ClipSprite();
         layout_heroes = ClipLayout.horizontalTopLeft(5);
         layout_titans = ClipLayout.horizontalTopLeft(5);
         timeout_lock_icon = new ClipSprite();
         timeout_tf = new ClipLabel(true);
         layout_timeout = ClipLayout.horizontalMiddleCentered(5,timeout_lock_icon,timeout_tf);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
