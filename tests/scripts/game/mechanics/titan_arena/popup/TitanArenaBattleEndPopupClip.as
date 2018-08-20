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
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class TitanArenaBattleEndPopupClip extends ClipAnimatedContainer
   {
       
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var okButton:ClipButtonLabeled;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_points:SpecialClipLabel;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var glowspot_reward:ClipSprite;
      
      public var icon_vs:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var player_portrait_1:PlayerPortraitClip;
      
      public var player_portrait_2:PlayerPortraitClip;
      
      public var team_1:MiniHeroTeamRenderer;
      
      public var team_2:MiniHeroTeamRendererWithHP;
      
      public var team_3:MiniHeroTeamRendererWithHP;
      
      public var team_4:MiniHeroTeamRenderer;
      
      public var trophy_icon_inst1:ClipSprite;
      
      public var GlowRed_100_100_2_inst0:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst1:GuiClipScale3Image;
      
      public var layout_reward:ClipLayout;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_result_improved:ClipLabel;
      
      public var layout_size:ClipLayout;
      
      public var reward_item_1:InventoryItemRenderer;
      
      public var tf_label_result_round_1:ClipLabel;
      
      public var tf_label_result_round_2:ClipLabel;
      
      public var tf_label_attacker_1:ClipLabel;
      
      public var tf_label_attacker_2:ClipLabel;
      
      public var tf_label_defender_1:ClipLabel;
      
      public var tf_label_defender_2:ClipLabel;
      
      public var tf_name_1:ClipLabel;
      
      public var tf_name_2:ClipLabel;
      
      public var icon_victoryPoint_1:ClipSprite;
      
      public var icon_victoryPoint_2:ClipSprite;
      
      public var tf_points_1:ClipLabel;
      
      public var tf_points_2:ClipLabel;
      
      public var tf_points_improve_1:ClipLabel;
      
      public var tf_points_improve_2:ClipLabel;
      
      public var tf_label_points_1:ClipLabel;
      
      public var tf_label_points_2:ClipLabel;
      
      public function TitanArenaBattleEndPopupClip()
      {
         button_stats_inst0 = new ClipButtonLabeled();
         okButton = new ClipButtonLabeled();
         tf_label_header = new ClipLabel();
         tf_label_points = new SpecialClipLabel();
         animation_EpicRays_inst0 = new ClipSprite();
         glowspot_reward = new ClipSprite();
         icon_vs = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         player_portrait_1 = new PlayerPortraitClip();
         player_portrait_2 = new PlayerPortraitClip();
         team_1 = new MiniHeroTeamRenderer();
         team_2 = new MiniHeroTeamRendererWithHP();
         team_3 = new MiniHeroTeamRendererWithHP();
         team_4 = new MiniHeroTeamRenderer();
         trophy_icon_inst1 = new ClipSprite();
         GlowRed_100_100_2_inst0 = new GuiClipScale3Image(100,2);
         GlowRed_100_100_2_inst1 = new GuiClipScale3Image(100,2);
         layout_reward = ClipLayout.horizontalMiddleCentered(4);
         tf_label_reward = new ClipLabel();
         tf_label_result_improved = new ClipLabel();
         layout_size = ClipLayout.none();
         reward_item_1 = new InventoryItemRenderer();
         tf_label_result_round_1 = new ClipLabel();
         tf_label_result_round_2 = new ClipLabel();
         tf_label_attacker_1 = new ClipLabel();
         tf_label_attacker_2 = new ClipLabel();
         tf_label_defender_1 = new ClipLabel();
         tf_label_defender_2 = new ClipLabel();
         tf_name_1 = new ClipLabel();
         tf_name_2 = new ClipLabel();
         icon_victoryPoint_1 = new ClipSprite();
         icon_victoryPoint_2 = new ClipSprite();
         tf_points_1 = new ClipLabel();
         tf_points_2 = new ClipLabel();
         tf_points_improve_1 = new ClipLabel();
         tf_points_improve_2 = new ClipLabel();
         tf_label_points_1 = new ClipLabel();
         tf_label_points_2 = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         player_portrait_2.portrait.direction = -1;
      }
   }
}
