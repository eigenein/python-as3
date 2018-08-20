package game.command.rpc.rating
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.model.user.ClanUserInfoValueObject;
   import game.model.user.UserInfo;
   
   public class CommandRatingTopGetResultUserEntry extends CommandRatingTopGetResultEntry
   {
       
      
      protected var _user:UserInfo;
      
      protected var _avatar:PlayerAvatarDescription;
      
      public function CommandRatingTopGetResultUserEntry(param1:int, param2:int, param3:Object)
      {
         super(param1,param2);
         if(param3 is UserInfo)
         {
            _user = param3 as UserInfo;
         }
         else if(param3)
         {
            _user = new UserInfo();
            _user.parse(param3);
         }
         _avatar = !!_user?DataStorage.playerAvatar.getAvatarById(_user.avatarId):null;
      }
      
      public function get userInfo() : UserInfo
      {
         return _user;
      }
      
      public function get avatar() : PlayerAvatarDescription
      {
         return _avatar;
      }
      
      public function get clanInfo() : ClanUserInfoValueObject
      {
         return !!_user?_user.clanInfo:null;
      }
      
      override public function get name() : String
      {
         return !!_user?_user.nickname:Translate.translate("UI_COMMON_USR_NO_NAME");
      }
      
      override public function get hasLevel() : Boolean
      {
         return _user && _user.level;
      }
      
      override public function get levelString() : String
      {
         return Translate.translate("UI_COMMON_TEAM_LEVEL_COLON") + " " + _user.level;
      }
      
      override public function get noLevelString() : String
      {
         return Translate.translate("UI_DIALOG_RATING_USER_NO_LEVEL");
      }
   }
}
