package game.view.popup.friends
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   
   public class FriendsDailyGiftSendButton extends ClipButtonLabeled
   {
       
      
      public var layout_label:ClipLayout;
      
      public function FriendsDailyGiftSendButton()
      {
         layout_label = ClipLayout.horizontalMiddleCentered(0);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         guiClipLabel.height = NaN;
         guiClipLabel.maxHeight = Infinity;
         guiClipLabel.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_SEND");
         layout_label.addChild(guiClipLabel);
      }
   }
}
