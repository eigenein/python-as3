package game.mediator.gui.popup.clan
{
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class FriendClanValueObject extends ClanValueObject
   {
       
      
      private var _friends:Vector.<PlayerFriendEntry>;
      
      public function FriendClanValueObject(param1:ClanPublicInfoValueObject, param2:Player)
      {
         _friends = new Vector.<PlayerFriendEntry>();
         super(param1,param2);
      }
      
      public function get friends() : Vector.<PlayerFriendEntry>
      {
         return _friends;
      }
      
      public function get friendCount() : int
      {
         return _friends.length;
      }
      
      public function addFriend(param1:PlayerFriendEntry) : void
      {
         _friends.push(param1);
      }
   }
}
