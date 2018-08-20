package game.view.popup.clan.friendlist
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanFriendListPopupMediator;
   import game.view.popup.friends.SearchableFriendListPopup;
   import game.view.popup.player.server.ServerFriendListPopupClip;
   
   public class ClanFriendListPopup extends SearchableFriendListPopup
   {
       
      
      private var __mediator:ClanFriendListPopupMediator;
      
      public function ClanFriendListPopup(param1:ClanFriendListPopupMediator)
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
         __clip.tf_header.text = Translate.translate("UI_DIALOG_CLAN_FRIEND_LIST");
         __clip.tf_caption.text = Translate.translateArgs("UI_DIALOG_CLAN_FRIEND_LIST_NAME",__mediator.clanName);
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(ServerFriendListPopupClip,"dialog_friend_list");
      }
   }
}
