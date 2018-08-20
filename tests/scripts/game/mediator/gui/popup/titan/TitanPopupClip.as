package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonLabeledGlow;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.artifacts.PlayerTitanArtifactSmallMarkeredItemRenderer;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class TitanPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var titan_position:GuiClipContainer;
      
      public var ribbon_image:GuiClipScale3Image;
      
      public var star_epic:GuiAnimation;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_4:ClipSprite;
      
      public var star_5:ClipSprite;
      
      public var layout_starCounter:ClipLayout;
      
      public var label_name:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public var tf_artifacts:ClipLabel;
      
      public var artifact_:Vector.<PlayerTitanArtifactSmallMarkeredItemRenderer>;
      
      public var tf_artifact_spirit:ClipLabel;
      
      public var artifact_spirit:PlayerTitanArtifactSmallMarkeredItemRenderer;
      
      public var tf_skills:ClipLabel;
      
      public var skills_layout:ClipLayout;
      
      public var tf_attack:SpecialClipLabel;
      
      public var tf_health:SpecialClipLabel;
      
      public var tf_label_element:SpecialClipLabel;
      
      public var element_icon:GuiClipImage;
      
      public var tf_power_label:ClipLabel;
      
      public var power_icon:ClipSprite;
      
      public var tf_power:SpecialClipLabel;
      
      public var layout_power:ClipLayout;
      
      public var power_bg:GuiClipScale3Image;
      
      public var tf_pyramid:ClipLabel;
      
      public var pyramid_counter:QuestRewardItemRenderer;
      
      public var btn_use:ClipButtonLabeled;
      
      public var layout_titan_spark:ClipLayout;
      
      public var button_evolve:ClipButtonLabeledGlow;
      
      public var progressbar_fragments:ClipProgressBar;
      
      public var tf_fragments:ClipLabel;
      
      public var tf_label_fragments:ClipLabel;
      
      public var layout_fragments:ClipLayout;
      
      public var tf_label_fragments_desc:ClipLabel;
      
      public var tf_label_summon_circle:ClipLabel;
      
      public var button_fragment_find:ClipButtonLabeled;
      
      public var icon_exp:ClipSprite;
      
      public var tf_label_level:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var layout_level:ClipLayout;
      
      public var upgrade_level_info:TitanPopupUpgradeLevelInfoClip;
      
      public var max_level_info:TitanPopupMaxLevelInfoClip;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public var tooltip:TitanPopUpToolTipClip;
      
      public function TitanPopupClip()
      {
         dialog_frame = new GuiClipScale9Image(new Rectangle(64,64,2,2));
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_4 = new ClipSprite();
         star_5 = new ClipSprite();
         layout_starCounter = ClipLayout.horizontalMiddleCentered(-4,star_1,star_2,star_3,star_4,star_5);
         label_name = new ClipLabel(true);
         tf_label_desc = new ClipLabel(true);
         layout_name = ClipLayout.verticalMiddleCenter(-2,label_name,tf_label_desc);
         tf_artifacts = new ClipLabel();
         artifact_ = new Vector.<PlayerTitanArtifactSmallMarkeredItemRenderer>();
         tf_artifact_spirit = new ClipLabel();
         artifact_spirit = new PlayerTitanArtifactSmallMarkeredItemRenderer();
         tf_skills = new ClipLabel(true);
         skills_layout = ClipLayout.horizontalMiddleRight(5);
         tf_attack = new SpecialClipLabel();
         tf_health = new SpecialClipLabel();
         tf_label_element = new SpecialClipLabel();
         element_icon = new GuiClipImage();
         tf_power_label = new ClipLabel(true);
         power_icon = new ClipSprite();
         tf_power = new SpecialClipLabel(true);
         layout_power = ClipLayout.horizontalMiddleCentered(-8,tf_power_label,power_icon,tf_power);
         power_bg = new GuiClipScale3Image(20,2);
         tf_pyramid = new ClipLabel();
         pyramid_counter = new QuestRewardItemRenderer();
         btn_use = new ClipButtonLabeled();
         layout_titan_spark = ClipLayout.horizontalMiddleCentered(4,tf_pyramid,pyramid_counter);
         tf_fragments = new ClipLabel(true);
         tf_label_fragments = new ClipLabel(true);
         layout_fragments = ClipLayout.horizontalMiddleCentered(5,tf_label_fragments,tf_fragments);
         tf_label_fragments_desc = new ClipLabel();
         tf_label_summon_circle = new ClipLabel();
         button_fragment_find = new ClipButtonLabeled();
         icon_exp = new ClipSprite();
         tf_label_level = new ClipLabel(true);
         tf_level = new ClipLabel(true);
         layout_level = ClipLayout.horizontalMiddleCentered(5,icon_exp,tf_label_level,tf_level);
         upgrade_level_info = new TitanPopupUpgradeLevelInfoClip();
         max_level_info = new TitanPopupMaxLevelInfoClip();
         minilist_layout_container = ClipLayout.horizontalMiddleCentered(0);
         tooltip = new TitanPopUpToolTipClip();
         super();
      }
      
      public function setStarCount(param1:int) : void
      {
         var _loc2_:int = 0;
         star_epic.graphics.visible = param1 == 6;
         _loc2_ = 1;
         while(_loc2_ <= 6 - 1)
         {
            (this["star_" + _loc2_] as ClipSprite).graphics.visible = _loc2_ <= param1 && param1 < 6;
            _loc2_++;
         }
      }
   }
}
