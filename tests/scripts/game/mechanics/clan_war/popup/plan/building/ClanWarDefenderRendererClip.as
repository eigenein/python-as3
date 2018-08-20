package game.mechanics.clan_war.popup.plan.building
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarDefenderRendererClip extends GuiClipNestedContainer
   {
       
      
      public var button_remove:ClipButton;
      
      public var button_setup:ClipButtonLabeled;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var powerIconSmall_inst0:ClipSprite;
      
      public var team:MiniHeroTeamRenderer;
      
      public var layout_name:ClipLayout;
      
      public var tf_warning:ClipLabel;
      
      public var tf_warning_not_warrior:ClipLabel;
      
      public var layout_no_team:ClipLayout;
      
      public function ClanWarDefenderRendererClip()
      {
         button_remove = new ClipButton();
         button_setup = new ClipButtonLabeled();
         tf_label_power = new ClipLabel();
         tf_name = new ClipLabel(true);
         tf_power = new ClipLabel();
         player_portrait = new PlayerPortraitClip();
         powerIconSmall_inst0 = new ClipSprite();
         team = new MiniHeroTeamRenderer();
         layout_name = ClipLayout.horizontal(4,tf_name,powerIconSmall_inst0,tf_power);
         tf_warning = new ClipLabel();
         tf_warning_not_warrior = new ClipLabel();
         layout_no_team = ClipLayout.verticalMiddleCenter(5,tf_warning,tf_warning_not_warrior,button_setup);
         super();
      }
   }
}
