package game.view.popup.fightresult.pve
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TowerRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_bonus:ClipLabel;
      
      public var tf_label_points:ClipLabel;
      
      public var tf_label_total:ClipLabel;
      
      public var tf_points_base:ClipLabel;
      
      public var tf_points_total:ClipLabel;
      
      public var tf_reward_label:ClipLabel;
      
      public var tf_skulls_base:ClipLabel;
      
      public var tf_skulls_total:ClipLabel;
      
      public var tf_star_count_1:ClipLabel;
      
      public var tf_star_count_2:ClipLabel;
      
      public var layout_points:ClipLayout;
      
      public var SkullMediumIcon_inst0:ClipSprite;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_animation_1:GuiAnimation;
      
      public var star_animation_2:GuiAnimation;
      
      public var star_animation_3:GuiAnimation;
      
      public var star_empty_1:ClipSprite;
      
      public var star_empty_2:ClipSprite;
      
      public var star_empty_3:ClipSprite;
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var GlowRed_100_100_2_inst1:GuiClipScale3Image;
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var okButton:ClipButtonLabeled;
      
      public function TowerRewardPopupClip()
      {
         tf_label_header = new ClipLabel();
         tf_label_bonus = new ClipLabel();
         tf_label_points = new ClipLabel();
         tf_label_total = new ClipLabel();
         tf_points_base = new ClipLabel();
         tf_points_total = new ClipLabel();
         tf_reward_label = new ClipLabel();
         tf_skulls_base = new ClipLabel();
         tf_skulls_total = new ClipLabel();
         tf_star_count_1 = new ClipLabel();
         tf_star_count_2 = new ClipLabel();
         layout_points = ClipLayout.horizontalMiddleCentered(0,tf_label_points);
         SkullMediumIcon_inst0 = new ClipSprite();
         animation_EpicRays_inst0 = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_animation_1 = new GuiAnimation();
         star_animation_2 = new GuiAnimation();
         star_animation_3 = new GuiAnimation();
         star_empty_1 = new ClipSprite();
         star_empty_2 = new ClipSprite();
         star_empty_3 = new ClipSprite();
         bounds_layout_container = new GuiClipLayoutContainer();
         GlowRed_100_100_2_inst1 = new GuiClipScale3Image();
         super();
      }
   }
}
