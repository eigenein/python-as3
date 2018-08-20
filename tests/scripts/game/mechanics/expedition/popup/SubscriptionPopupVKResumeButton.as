package game.mechanics.expedition.popup
{
   import game.view.gui.components.ClipButton;
   import game.view.popup.socialgrouppromotion.ClipTextUnderlined;
   
   public class SubscriptionPopupVKResumeButton extends ClipButton
   {
       
      
      public var tf_vk_pending_cancel:ClipTextUnderlined;
      
      public function SubscriptionPopupVKResumeButton()
      {
         tf_vk_pending_cancel = new ClipTextUnderlined();
         super();
      }
   }
}
