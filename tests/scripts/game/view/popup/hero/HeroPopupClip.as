package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeledGlow;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.hero.rune.HeroPopupRuneTab;
   import game.view.popup.hero.skins.HeroPopupSkinList;
   
   public class HeroPopupClip extends GuiClipNestedContainer
   {
       
      
      public var skillList:HeroPopupSkillList;
      
      public var skinList:HeroPopupSkinList;
      
      public var statList:HeroPopupStatList;
      
      public var gearList:HeroPopupGearList;
      
      public var runeTab:HeroPopupRuneTab;
      
      public var elementTab:HeroPopupElementTab;
      
      public var artifactsTab:HeroArtifactsTab;
      
      public var ribbon_image:GuiClipScale3Image;
      
      public var city_view:GuiClipImage;
      
      public var hero_position:GuiClipContainer;
      
      public var epic_art_frame:HeroPopupEpicArtFrameClip;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var button_close:ClipButton;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var bg:ClipSprite;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public var button_fragments_plus:ClipButton;
      
      public var button_evolve:ClipButtonLabeledGlow;
      
      public var button_promote:ClipButtonLabeledGlow;
      
      public var button_xp_plus:ClipButton;
      
      public var bound_layout_container:GuiClipLayoutContainer;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_4:ClipSprite;
      
      public var star_5:ClipSprite;
      
      public var layout_starCounter:ClipLayout;
      
      public var star_epic:GuiAnimation;
      
      public var inventory_slot_6:HeroPopupInventoryItemRenderer;
      
      public var inventory_slot_5:HeroPopupInventoryItemRenderer;
      
      public var inventory_slot_4:HeroPopupInventoryItemRenderer;
      
      public var inventory_slot_3:HeroPopupInventoryItemRenderer;
      
      public var inventory_slot_2:HeroPopupInventoryItemRenderer;
      
      public var inventory_slot_1:HeroPopupInventoryItemRenderer;
      
      public var progressbar_xp:ClipProgressBar;
      
      public var progressbar_fragments:ClipProgressBar;
      
      public var layout_tabs:ClipLayout;
      
      public var layout_tab_content:ClipLayout;
      
      public var tf_power:ClipLabel;
      
      public var tf_power_label:ClipLabel;
      
      public var tf_label_level:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var layout_level:ClipLayout;
      
      public var tf_fragments:ClipLabel;
      
      public var tf_label_fragments:ClipLabel;
      
      public var layout_fragments:ClipLayout;
      
      public var tf_label_xp:ClipLabel;
      
      public var label_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public var icon_can_xp_plus:ClipSpriteUntouchable;
      
      public function HeroPopupClip()
      {
         minilist_layout_container = ClipLayout.horizontalCentered(0);
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_4 = new ClipSprite();
         star_5 = new ClipSprite();
         layout_starCounter = ClipLayout.horizontalMiddleCentered(-4,star_1,star_2,star_3,star_4,star_5);
         layout_tabs = ClipLayout.vertical(-16);
         layout_tab_content = ClipLayout.none();
         tf_power = new ClipLabel();
         tf_power_label = new ClipLabel();
         tf_label_level = new ClipLabel(true);
         tf_level = new ClipLabel(true);
         layout_level = ClipLayout.horizontalMiddleCentered(1,tf_label_level,tf_level);
         tf_fragments = new ClipLabel(true);
         tf_label_fragments = new ClipLabel(true);
         layout_fragments = ClipLayout.horizontalMiddleCentered(1,tf_label_fragments,tf_fragments);
         tf_label_xp = new ClipLabel();
         label_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(0,label_name);
         super();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         button_close = new ClipButton();
         dialog_frame = new GuiClipScale9Image(new Rectangle(64,64,2,2));
         bg = new ClipSprite();
         bound_layout_container = new GuiClipLayoutContainer();
         button_fragments_plus = new ClipButton();
         ribbon_image = new GuiClipScale3Image(76,1);
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
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
      }
      
      public function getInventorySlot(param1:int) : HeroPopupInventoryItemRenderer
      {
         return this["inventory_slot_" + param1] as HeroPopupInventoryItemRenderer;
      }
   }
}
