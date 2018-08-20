package game.view.popup.billing.bundle
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class SkinBundlePopupClip extends PopupClipBase
   {
       
      
      public var button_to_store:ClipButtonLabeledAnimated;
      
      public var tf_discount:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var old_price_cross:ClipSprite;
      
      public var layout_vip_header:ClipLayout;
      
      public var layout_label_desc:ClipLayout;
      
      public var reward_item:Vector.<BundlePopupRewardClip>;
      
      public var hero_position:GuiClipContainer;
      
      public var marker_bg_skin:GuiClipContainer;
      
      public var tf_label_stat_bonus:SpecialClipLabel;
      
      public var layout_statBonus:ClipLayout;
      
      public var layout_special_offer:ClipLayout;
      
      public const timer:BundlePopupTimerBlockClip = new BundlePopupTimerBlockClip();
      
      public function SkinBundlePopupClip()
      {
         button_to_store = new ClipButtonLabeledAnimated();
         tf_discount = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_old_price = new ClipLabel();
         old_price_cross = new ClipSprite();
         layout_vip_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         layout_label_desc = ClipLayout.horizontalMiddleCentered(0,tf_label_desc);
         reward_item = new Vector.<BundlePopupRewardClip>();
         hero_position = new GuiClipContainer();
         marker_bg_skin = new GuiClipContainer();
         tf_label_stat_bonus = new SpecialClipLabel();
         layout_statBonus = ClipLayout.horizontalMiddleCentered(4,tf_label_stat_bonus);
         layout_special_offer = ClipLayout.none();
         super();
      }
   }
}
