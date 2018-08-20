package game.model.user.chat
{
   import game.model.user.ClanUserInfoValueObject;
   import game.model.user.UserInfo;
   
   public class ChatUserData extends UserInfo
   {
       
      
      public function ChatUserData(param1:Object, param2:ClanUserInfoValueObject = null)
      {
         super();
         _clanInfo = param2;
         parse(param1);
      }
   }
}
