package game.mediator.gui.popup.friends
{
   import game.model.user.UserInfo;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class FriendDataProvider
   {
       
      
      private var _player:PlayerFriendEntry;
      
      public function FriendDataProvider(param1:PlayerFriendEntry)
      {
         super();
         this._player = param1;
      }
      
      public function get player() : PlayerFriendEntry
      {
         return _player;
      }
      
      public function get level() : int
      {
         return player.level;
      }
      
      public function get name() : String
      {
         return player.realName;
      }
      
      public function get photo() : String
      {
         return player.photoURL;
      }
      
      public function get nickname() : String
      {
         return player.nickname;
      }
      
      public function get userInfo() : UserInfo
      {
         return player.userInfo;
      }
   }
}
