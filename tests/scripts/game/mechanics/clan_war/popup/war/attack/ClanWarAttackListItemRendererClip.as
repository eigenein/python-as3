package game.mechanics.clan_war.popup.war.attack
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.MiniHeroTeamRendererWithHP;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarAttackListItemRendererClip extends ClipAnimatedContainer
   {
       
      
      public var button_attack:ClipButtonLabeled;
      
      public var button_setup:ClipButtonLabeled;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var tf_label_free:ClipLabel;
      
      public var tf_team_status:ClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var powerIconSmall_inst0:ClipSprite;
      
      public var team:MiniHeroTeamRendererWithHP;
      
      public var points_glow:ClipSprite;
      
      public var icon_VP:ClipSprite;
      
      public var team_layout:ClipLayout;
      
      public var layout_name:ClipLayout;
      
      public var layout_points:ClipLayout;
      
      public var cannot_attack:ClanWarCannotAttackClip;
      
      public var layout_none:ClipLayout;
      
      public var layout_free:ClipLayout;
      
      public function ClanWarAttackListItemRendererClip()
      {
         button_attack = new ClipButtonLabeled();
         button_setup = new ClipButtonLabeled();
         tf_label_power = new ClipLabel();
         tf_name = new ClipLabel(true);
         tf_power = new ClipLabel(true);
         tf_label_free = new ClipLabel();
         tf_team_status = new ClipLabel();
         tf_points = new ClipLabel(true);
         player_portrait = new PlayerPortraitClip();
         powerIconSmall_inst0 = new ClipSprite();
         team = new MiniHeroTeamRendererWithHP();
         points_glow = new ClipSprite();
         icon_VP = new ClipSprite();
         team_layout = ClipLayout.horizontal(0,team);
         layout_name = ClipLayout.horizontal(4,tf_name,powerIconSmall_inst0,tf_power);
         layout_points = ClipLayout.horizontalMiddleCentered(4,icon_VP,tf_points);
         cannot_attack = new ClanWarCannotAttackClip();
         layout_none = new ClipLayoutNone([button_attack,tf_label_power,tf_name,tf_power,player_portrait,powerIconSmall_inst0,team,team_layout,layout_name,cannot_attack]);
         layout_free = ClipLayout.horizontalMiddleCentered(10,tf_label_free,button_setup);
         super();
      }
   }
}
