package game.mechanics.clan_war.popup.victory
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mechanics.clan_war.popup.ClanWarFlagRenderer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.gui.components.MiniHeroTeamRendererWithHP;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarBattleVictoryPopupClip extends ClipAnimatedContainer
   {
       
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var okButton:ClipButtonLabeled;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_points_base:SpecialClipLabel;
      
      public var tf_label_points_building:SpecialClipLabel;
      
      public var tf_name_1:ClipLabel;
      
      public var tf_name_2:ClipLabel;
      
      public var tf_points_base:SpecialClipLabel;
      
      public var tf_points_building:SpecialClipLabel;
      
      public var attacker_info:ClanWarFlagRenderer;
      
      public var defender_info:ClanWarFlagRenderer;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var glowspot_reward:ClipSprite;
      
      public var icon_vs:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var player_portrait_1:PlayerPortraitClip;
      
      public var player_portrait_2:PlayerPortraitClip;
      
      public var team_1:MiniHeroTeamRenderer;
      
      public var team_2:MiniHeroTeamRendererWithHP;
      
      public var trophy_icon_inst0:ClipSprite;
      
      public var trophy_icon_inst1:ClipSprite;
      
      public var GlowRed_100_100_2_inst0:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst1:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst2:GuiClipScale3Image;
      
      public var layout_points_base:ClipLayout;
      
      public var layout_points_building:ClipLayout;
      
      public var layout_size:ClipLayout;
      
      public function ClanWarBattleVictoryPopupClip()
      {
         button_stats_inst0 = new ClipButtonLabeled();
         okButton = new ClipButtonLabeled();
         tf_label_header = new ClipLabel();
         tf_label_points_base = new SpecialClipLabel();
         tf_label_points_building = new SpecialClipLabel();
         tf_name_1 = new ClipLabel();
         tf_name_2 = new ClipLabel();
         tf_points_base = new SpecialClipLabel(true);
         tf_points_building = new SpecialClipLabel(true);
         attacker_info = new ClanWarFlagRenderer(true);
         defender_info = new ClanWarFlagRenderer(false);
         animation_EpicRays_inst0 = new ClipSprite();
         glowspot_reward = new ClipSprite();
         icon_vs = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         player_portrait_1 = new PlayerPortraitClip();
         player_portrait_2 = new PlayerPortraitClip();
         team_1 = new MiniHeroTeamRenderer();
         team_2 = new MiniHeroTeamRendererWithHP();
         trophy_icon_inst0 = new ClipSprite();
         trophy_icon_inst1 = new ClipSprite();
         GlowRed_100_100_2_inst0 = new GuiClipScale3Image(100,2);
         GlowRed_100_100_2_inst1 = new GuiClipScale3Image(100,2);
         GlowRed_100_100_2_inst2 = new GuiClipScale3Image(100,2);
         layout_points_base = ClipLayout.horizontalMiddleCentered(4,tf_points_base,trophy_icon_inst1);
         layout_points_building = ClipLayout.horizontalMiddleCentered(4,tf_points_building,trophy_icon_inst0);
         layout_size = ClipLayout.none();
         super();
      }
   }
}
