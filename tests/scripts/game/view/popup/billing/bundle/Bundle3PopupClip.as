package game.view.popup.billing.bundle
{
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.billing.BillingVipLevelBlock;
   
   public class Bundle3PopupClip extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var button_close:ClipButton;
      
      public var button_drop:ClipButtonLabeled;
      
      public var button_to_store:ClipButtonLabeledAnimated;
      
      public var tf_discount:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_skills:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var tf_new_price:ClipLabel;
      
      public var tf_hero_name:ClipLabel;
      
      public var tf_hero_desc:ClipLabel;
      
      public var tf_vip_desc:ClipLabel;
      
      public var vip_level:BillingVipLevelBlock;
      
      public var layout_vip_header:ClipLayout;
      
      public var reward_item:Vector.<BundlePopupRewardClip>;
      
      public var skill_item:Vector.<BundlePopupSkillClip>;
      
      public var marker_animaton:GuiClipContainer;
      
      public var hero_portrait:GuiClipContainer;
      
      public var layout_special_offer:ClipLayout;
      
      public const timer:BundlePopupTimerBlockClip = new BundlePopupTimerBlockClip();
      
      public function Bundle3PopupClip()
      {
         dialog_frame = new GuiClipScale9Image();
         button_close = new ClipButton();
         button_drop = new ClipButtonLabeled();
         button_to_store = new ClipButtonLabeledAnimated();
         tf_discount = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_label_skills = new ClipLabel();
         tf_old_price = new ClipLabel();
         tf_new_price = new ClipLabel();
         tf_hero_name = new ClipLabel();
         tf_hero_desc = new ClipLabel();
         tf_vip_desc = new ClipLabel();
         vip_level = new BillingVipLevelBlock();
         layout_vip_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         reward_item = new Vector.<BundlePopupRewardClip>();
         skill_item = new Vector.<BundlePopupSkillClip>();
         marker_animaton = new GuiClipContainer();
         hero_portrait = new GuiClipContainer();
         layout_special_offer = ClipLayout.none();
         super();
      }
   }
}
