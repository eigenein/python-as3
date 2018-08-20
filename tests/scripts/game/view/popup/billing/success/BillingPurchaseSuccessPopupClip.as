package game.view.popup.billing.success
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.billing.BillingVipLevelBlock;
   
   public class BillingPurchaseSuccessPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_caption:ClipLabel;
      
      public var tf_gem_amount:ClipLabel;
      
      public var tf_vip_reward:ClipLabel;
      
      public var tf_vip_reward_label:ClipLabel;
      
      public var vip_word:ClipSprite;
      
      public var gem:ClipSprite;
      
      public var vip_level:BillingVipLevelBlock;
      
      public var vip_level_next:BillingVipLevelBlock;
      
      public var progress_bar:VipProgressBarClip;
      
      public var ribbon:GuiClipScale3Image;
      
      public var layout_gems:ClipLayout;
      
      public var layout_vip:ClipLayout;
      
      public function BillingPurchaseSuccessPopupClip()
      {
         button_close = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_caption = new ClipLabel();
         tf_gem_amount = new ClipLabel(true);
         tf_vip_reward = new ClipLabel(true);
         tf_vip_reward_label = new ClipLabel(true);
         vip_word = new ClipSprite();
         gem = new ClipSprite();
         vip_level = new BillingVipLevelBlock();
         vip_level_next = new BillingVipLevelBlock();
         progress_bar = new VipProgressBarClip();
         ribbon = new GuiClipScale3Image(96,1);
         layout_gems = ClipLayout.horizontalMiddleCentered(4,gem,tf_gem_amount);
         layout_vip = ClipLayout.horizontalMiddleCentered(4,tf_vip_reward,vip_word,tf_vip_reward_label);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_header.text = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         tf_caption.text = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_CAPTION");
      }
   }
}
