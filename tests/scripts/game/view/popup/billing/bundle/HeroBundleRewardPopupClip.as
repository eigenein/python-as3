package game.view.popup.billing.bundle
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class HeroBundleRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var layout_vip_header:ClipLayout;
      
      public var layout_label_desc:ClipLayout;
      
      public var reward_item:Vector.<BundlePopupRewardClip>;
      
      public function HeroBundleRewardPopupClip()
      {
         dialog_frame = new GuiClipScale9Image();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         layout_vip_header = ClipLayout.horizontalMiddleCentered(0,tf_header);
         layout_label_desc = ClipLayout.horizontalMiddleCentered(0,tf_label_desc);
         reward_item = new Vector.<BundlePopupRewardClip>();
         super();
      }
   }
}
