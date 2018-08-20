package game.view.popup.ny.sendgift
{
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class FriendToSendNYGiftVO extends FriendDataProvider
   {
      
      public static const I_AM:uint = 0;
      
      public static const SOCIAL_FRIEND:uint = 1;
      
      public static const CLAN_MEMBER:uint = 2;
       
      
      public var type:uint;
      
      public var repeated:Boolean;
      
      public function FriendToSendNYGiftVO(param1:PlayerFriendEntry)
      {
         super(param1);
      }
   }
}
