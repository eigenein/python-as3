package game.view.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.player.server.ServerFriendListPopupMediator;
   import game.view.popup.friends.SearchableFriendListPopup;
   
   public class ServerFriendListPopup extends SearchableFriendListPopup
   {
       
      
      private var __mediator:ServerFriendListPopupMediator;
      
      public function ServerFriendListPopup(param1:ServerFriendListPopupMediator)
      {
         super(param1);
         this.__mediator = param1;
      }
      
      private function get __clip() : ServerFriendListPopupClip
      {
         return clip as ServerFriendListPopupClip;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         __clip.tf_header.text = Translate.translate("UI_DIALOG_SERVER_SELECT_FRIEND_LIST");
         __clip.tf_caption.text = Translate.translateArgs("UI_DIALOG_SERVER_SELECT_SERVER_NAME",__mediator.serverName);
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(ServerFriendListPopupClip,"dialog_friend_list");
      }
   }
}
