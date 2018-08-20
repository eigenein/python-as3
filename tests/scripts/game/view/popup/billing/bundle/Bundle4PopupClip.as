package game.view.popup.billing.bundle
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class Bundle4PopupClip extends GuiClipNestedContainer
   {
       
      
      public var image_hero:GuiClipImage;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var button_close:ClipButton;
      
      public var button_to_store:ClipButtonLabeledAnimated;
      
      public var tf_discount:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_skills:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var old_price_cross:ClipSprite;
      
      public var hero_art_frame:GuiClipScale9Image;
      
      public var layout_vip_header:ClipLayout;
      
      public var layout_label_desc:ClipLayout;
      
      public var reward_item:Vector.<BundlePopupRewardClip>;
      
      public var skill_item:Vector.<BundlePopupSkillClip>;
      
      public var layout_special_offer:ClipLayout;
      
      public var image_container:GuiClipLayoutContainer;
      
      public var HeroGlowBG_scale_inst0:ClipSprite;
      
      public var hero_position:GuiClipContainer;
      
      public var hero_position_rays:GuiClipContainer;
      
      public const timer:BundlePopupTimerBlockClip = new BundlePopupTimerBlockClip();
      
      public function Bundle4PopupClip()
      {
         image_hero = new GuiClipImage();
         dialog_frame = new GuiClipScale9Image();
         button_close = new ClipButton();
         button_to_store = new ClipButtonLabeledAnimated();
         tf_discount = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_label_skills = new ClipLabel();
         tf_old_price = new ClipLabel();
         old_price_cross = new ClipSprite();
         layout_vip_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         layout_label_desc = ClipLayout.horizontalMiddleCentered(0,tf_label_desc);
         reward_item = new Vector.<BundlePopupRewardClip>();
         skill_item = new Vector.<BundlePopupSkillClip>();
         layout_special_offer = ClipLayout.none();
         image_container = new GuiClipLayoutContainer();
         HeroGlowBG_scale_inst0 = new ClipSprite();
         hero_position = new GuiClipContainer();
         hero_position_rays = new GuiClipContainer();
         super();
      }
   }
}
