package game.mechanics.titan_arena.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.gui.components.MiniHeroTeamRendererWithHP;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class TitanArenaRoundEndPopupClip extends ClipAnimatedContainer
   {
       
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var button_continue:ClipButtonLabeled;
      
      public var button_skip_defense:ClipButtonLabeled;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_points:SpecialClipLabel;
      
      public var tf_name_1:ClipLabel;
      
      public var tf_name_2:ClipLabel;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var glowspot_reward:ClipSprite;
      
      public var icon_vs:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var player_portrait_1:PlayerPortraitClip;
      
      public var player_portrait_2:PlayerPortraitClip;
      
      public var team_1:MiniHeroTeamRenderer;
      
      public var team_2:MiniHeroTeamRendererWithHP;
      
      public var GlowRed_100_100_2_inst0:GuiClipScale3Image;
      
      public var reward_item:QuestRewardItemRenderer;
      
      public var layout_points_base:ClipLayout;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_result_improved:ClipLabel;
      
      public var layout_size:ClipLayout;
      
      public function TitanArenaRoundEndPopupClip()
      {
         button_stats_inst0 = new ClipButtonLabeled();
         button_continue = new ClipButtonLabeled();
         button_skip_defense = new ClipButtonLabeled();
         tf_label_header = new ClipLabel();
         tf_label_points = new SpecialClipLabel();
         tf_name_1 = new ClipLabel();
         tf_name_2 = new ClipLabel();
         animation_EpicRays_inst0 = new ClipSprite();
         glowspot_reward = new ClipSprite();
         icon_vs = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         player_portrait_1 = new PlayerPortraitClip();
         player_portrait_2 = new PlayerPortraitClip();
         team_1 = new MiniHeroTeamRenderer();
         team_2 = new MiniHeroTeamRendererWithHP();
         GlowRed_100_100_2_inst0 = new GuiClipScale3Image(100,2);
         reward_item = new QuestRewardItemRenderer();
         layout_points_base = ClipLayout.horizontalMiddleCentered(4,reward_item);
         tf_label_reward = new ClipLabel();
         tf_label_result_improved = new ClipLabel();
         layout_size = ClipLayout.none();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         player_portrait_2.portrait.direction = -1;
      }
   }
}
