package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SubscriptionPopupClip extends PopupClipBase
   {
       
      
      public var button_vk_resume:SubscriptionPopupVKResumeButton;
      
      public var layout_vk_resume:ClipLayout;
      
      public var tf_header:ClipLabel;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_benefit_header:ClipLabel;
      
      public var tf_active_state:ClipLabel;
      
      public var tf_active_duration_state:ClipLabel;
      
      public var tf_activate:ClipLabel;
      
      public var tf_benefit_1:ClipLabel;
      
      public var tf_benefit_2:ClipLabel;
      
      public var tf_benefit_3:ClipLabel;
      
      public var tf_benefit_weekly:ClipLabel;
      
      public var tf_benefit_server:ClipLabel;
      
      public var level_list:SubscriptionLevelListClip;
      
      public var block_bonus:SubscriptionPopupBonusClip;
      
      public var tf_renew_red:ClipLabel;
      
      public var renew_red:ClipSprite;
      
      public var subscription_animations:GuiClipNestedContainer;
      
      public function SubscriptionPopupClip()
      {
         button_vk_resume = new SubscriptionPopupVKResumeButton();
         layout_vk_resume = ClipLayout.horizontalCentered(4,button_vk_resume);
         tf_header = new ClipLabel();
         button_ok = new ClipButtonLabeled();
         tf_benefit_header = new ClipLabel();
         tf_active_state = new ClipLabel();
         tf_active_duration_state = new ClipLabel();
         tf_activate = new ClipLabel();
         tf_benefit_1 = new ClipLabel();
         tf_benefit_2 = new ClipLabel();
         tf_benefit_3 = new ClipLabel();
         tf_benefit_weekly = new ClipLabel();
         tf_benefit_server = new ClipLabel();
         level_list = new SubscriptionLevelListClip();
         block_bonus = new SubscriptionPopupBonusClip();
         tf_renew_red = new ClipLabel();
         renew_red = new ClipSprite();
         subscription_animations = new GuiClipNestedContainer();
         super();
      }
   }
}
