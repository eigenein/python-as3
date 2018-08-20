package game.view.popup.friends
{
   import engine.core.clipgui.GuiClipImage;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class FriendsDailyGiftGMRPopupClip extends PopupClipBase
   {
       
      
      public var button_send_gifts:FriendsDailyGiftSendButton;
      
      public var tf_desc:ClipLabel;
      
      public var button_shop:ClipButtonLabeled;
      
      public var tick_task_complete:GuiClipImage;
      
      public var tf_task_complete:ClipLabel;
      
      public var layout_task_complete:ClipLayout;
      
      public function FriendsDailyGiftGMRPopupClip()
      {
         button_send_gifts = new FriendsDailyGiftSendButton();
         tf_desc = new ClipLabel();
         button_shop = new ClipButtonLabeled();
         tick_task_complete = new GuiClipImage();
         tf_task_complete = new ClipLabel();
         layout_task_complete = ClipLayout.horizontalMiddleCentered(4,tick_task_complete,tf_task_complete);
         super();
      }
   }
}
