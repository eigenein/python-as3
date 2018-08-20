package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SubscriptionActivateRewardPopupClip extends PopupClipBase
   {
       
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_reward_daily:ClipLabel;
      
      public var tf_benefit_1:ClipLabel;
      
      public var tf_benefit_2:ClipLabel;
      
      public var tf_benefit_3:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var layout_vip_header:ClipLayout;
      
      public var button_ok:ClipButtonLabeled;
      
      public var list_item_1:InventoryItemRenderer;
      
      public var list_item_2:InventoryItemRenderer;
      
      public var subscription_animations:GuiClipNestedContainer;
      
      public function SubscriptionActivateRewardPopupClip()
      {
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_label_reward_daily = new ClipLabel();
         tf_benefit_1 = new ClipLabel();
         tf_benefit_2 = new ClipLabel();
         tf_benefit_3 = new ClipLabel();
         tf_header = new ClipLabel(true);
         layout_vip_header = ClipLayout.horizontalMiddleCentered(0,tf_header);
         button_ok = new ClipButtonLabeled();
         list_item_1 = new InventoryItemRenderer();
         list_item_2 = new InventoryItemRenderer();
         subscription_animations = new GuiClipNestedContainer();
         super();
      }
   }
}
