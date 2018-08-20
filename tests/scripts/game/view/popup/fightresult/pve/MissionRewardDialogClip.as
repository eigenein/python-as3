package game.view.popup.fightresult.pve
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.theme.LabelStyle;
   import starling.display.Image;
   
   public class MissionRewardDialogClip extends GuiClipNestedContainer
   {
       
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var marker_icon_gold_coin_inst0:GuiClipContainer;
      
      public var tf_label_header:ClipLabel;
      
      public var label_exp:GuiClipLabel;
      
      public var label_level:GuiClipLabel;
      
      public var label_gold_number:GuiClipLabel;
      
      public var label_exp_number:GuiClipLabel;
      
      public var label_level_number:GuiClipLabel;
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var townButton:ClipButtonLabeled;
      
      public var campaignButton:ClipButtonLabeled;
      
      public var okButton:ClipButtonLabeled;
      
      public var layout_buttons:ClipLayout;
      
      public var hero_list_layout_container:GuiClipLayoutContainer;
      
      public var item_list_layout_container:GuiClipLayoutContainer;
      
      public var glowspot_inst0:ClipSprite;
      
      public var glowspot_inst1:ClipSprite;
      
      public var glowspot_inst2:ClipSprite;
      
      public var glowspot_inst3:ClipSprite;
      
      public var FlatGlow_150_150_2_inst0:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst0:GuiClipScale3Image;
      
      public var winBG_18_18_4_4_inst0:GuiClipScale9Image;
      
      public var GlowOrange_48_48_2_inst0:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst1:GuiClipScale3Image;
      
      public var GlowOrange_48_48_2_inst1:GuiClipScale3Image;
      
      public var GlowOrange_48_48_2_inst2:GuiClipScale3Image;
      
      public var GlowBigRed_218_218_2_inst0:GuiClipScale3Image;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var tf_reward_label:ClipLabel;
      
      public var tf_reward_empty:ClipLabel;
      
      public var star_animation_1:GuiAnimation;
      
      public var star_animation_2:GuiAnimation;
      
      public var star_animation_3:GuiAnimation;
      
      public var star_empty_1:ClipSprite;
      
      public var star_empty_2:ClipSprite;
      
      public var star_empty_3:ClipSprite;
      
      public function MissionRewardDialogClip()
      {
         tf_label_header = new ClipLabel();
         townButton = new ClipButtonLabeled();
         campaignButton = new ClipButtonLabeled();
         okButton = new ClipButtonLabeled();
         layout_buttons = ClipLayout.horizontalMiddleCentered(10,townButton,campaignButton,okButton);
         tf_reward_label = new ClipLabel();
         tf_reward_empty = new ClipLabel();
         star_animation_1 = new GuiAnimation();
         star_animation_2 = new GuiAnimation();
         star_animation_3 = new GuiAnimation();
         star_empty_1 = new ClipSprite();
         star_empty_2 = new ClipSprite();
         star_empty_3 = new ClipSprite();
         super();
         hero_list_layout_container = new GuiClipLayoutContainer();
         item_list_layout_container = new GuiClipLayoutContainer();
         glowspot_inst0 = new ClipSprite();
         glowspot_inst1 = new ClipSprite();
         glowspot_inst2 = new ClipSprite();
         glowspot_inst3 = new ClipSprite();
         FlatGlow_150_150_2_inst0 = new GuiClipScale3Image(150,2);
         GlowRed_100_100_2_inst0 = new GuiClipScale3Image(100,2);
         winBG_18_18_4_4_inst0 = new GuiClipScale9Image(new Rectangle(18,18,4,4));
         GlowOrange_48_48_2_inst0 = new GuiClipScale3Image(48,2);
         GlowRed_100_100_2_inst1 = new GuiClipScale3Image(100,2);
         GlowOrange_48_48_2_inst1 = new GuiClipScale3Image(48,2);
         GlowOrange_48_48_2_inst2 = new GuiClipScale3Image(48,2);
         ribbon_154_154_2_inst0 = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         label_exp = new GuiClipLabel(LabelStyle.label_size18_center);
         label_level = new GuiClipLabel(LabelStyle.label_size18_center);
         label_gold_number = new GuiClipLabel(LabelStyle.label_size24_number);
         label_exp_number = new GuiClipLabel(LabelStyle.label_size24_number);
         label_level_number = new GuiClipLabel(LabelStyle.label_size24_number);
      }
      
      public function dispose() : void
      {
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         marker_icon_gold_coin_inst0.container.addChild(new Image(AssetStorage.rsx.popup_theme.getTexture("icon_gold_coin")));
      }
   }
}
