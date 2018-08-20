package game.view.popup.billing
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   
   public class BillingPopupClip extends PopupClipBase
   {
       
      
      public var button_benefits:ClipButtonLabeled;
      
      public var vip_level:BillingVipLevelBlock;
      
      public var tf_progress_value:ClipLabel;
      
      public var tf_progress_new_value:ClipLabel;
      
      public var progress_bar:GuiClipScale3Image;
      
      public var progress_bar_new:GuiClipScale3Image;
      
      public var layout_progress_bar:ClipLayoutNone;
      
      public var progress_bg:ClipSprite;
      
      public var bg_progress_new_value:GuiClipScale3Image;
      
      public var animation_vip_level_up:GuiAnimation;
      
      public var vip_permanent_block:BillingVipPermanentBlock;
      
      public var tf_vat:ClipLabel;
      
      public var points_needed_block:BillingNeedVipPointsClip;
      
      public var tf_sub_status:ClipLabel;
      
      public var billings_item:Vector.<BillingItemClip>;
      
      public const minImageWidth:int = 5;
      
      public function BillingPopupClip()
      {
         vip_level = new BillingVipLevelBlock();
         tf_progress_new_value = new ClipLabel();
         animation_vip_level_up = new GuiAnimation();
         tf_vat = new ClipLabel();
         tf_sub_status = new ClipLabel();
         billings_item = new Vector.<BillingItemClip>();
         super();
      }
   }
}
