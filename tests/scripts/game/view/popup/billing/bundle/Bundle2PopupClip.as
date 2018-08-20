package game.view.popup.billing.bundle
{
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class Bundle2PopupClip extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var button_close:ClipButton;
      
      public var button_to_store:ClipButtonLabeledAnimated;
      
      public var tf_discount:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var layout_label_desc:ClipLayout;
      
      public var layout_vip_header:ClipLayout;
      
      public var reward_item:Vector.<BundlePopupRewardClip>;
      
      public var marker_girl:GuiClipContainer;
      
      public var layout_special_offer:ClipLayout;
      
      public const timer:BundlePopupTimerBlockClip = new BundlePopupTimerBlockClip();
      
      public function Bundle2PopupClip()
      {
         dialog_frame = new GuiClipScale9Image();
         button_close = new ClipButton();
         button_to_store = new ClipButtonLabeledAnimated();
         tf_discount = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_old_price = new ClipLabel();
         layout_label_desc = ClipLayout.horizontalMiddleCentered(0,tf_label_desc);
         layout_vip_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         reward_item = new Vector.<BundlePopupRewardClip>();
         marker_girl = new GuiClipContainer();
         layout_special_offer = ClipLayout.none();
         super();
      }
   }
}
