package game.view.popup.player.server
{
   import game.view.gui.components.ClipLabel;
   import game.view.popup.friends.SearchableFriendListPopupClipBase;
   
   public class ServerFriendListPopupClip extends SearchableFriendListPopupClipBase
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public function ServerFriendListPopupClip()
      {
         tf_caption = new ClipLabel();
         tf_header = new ClipLabel();
         super();
      }
   }
}
