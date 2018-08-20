package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class SubscriptionRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var reward:Vector.<SubscriptionRewardPopupRendererClip>;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public function SubscriptionRewardPopupClip()
      {
         reward = new Vector.<SubscriptionRewardPopupRendererClip>();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_label_reward = new ClipLabel();
         super();
      }
   }
}
