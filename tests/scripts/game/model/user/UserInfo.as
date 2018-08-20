package game.model.user
{
   import com.progrestar.common.lang.Translate;
   
   public class UserInfo
   {
       
      
      protected var _nickname:String;
      
      protected var _id:String;
      
      protected var _lastLoginTime:int;
      
      protected var _avatarId:int;
      
      protected var _frameId:int;
      
      protected var _experience:int;
      
      protected var _level:int;
      
      protected var _accountId:String;
      
      protected var _serverId:int;
      
      protected var _clanRole:int;
      
      protected var _clanInfo:ClanUserInfoValueObject;
      
      protected var _isChatModerator:int;
      
      public function UserInfo()
      {
         super();
      }
      
      public function get nickname() : String
      {
         return _nickname;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get lastLoginTime() : int
      {
         return _lastLoginTime;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
      
      public function get frameId() : int
      {
         return _frameId;
      }
      
      public function get experience() : int
      {
         return _experience;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get accountId() : String
      {
         return _accountId;
      }
      
      public function get serverId() : int
      {
         return _serverId;
      }
      
      public function get clanRole() : int
      {
         return _clanRole;
      }
      
      public function get clanInfo() : ClanUserInfoValueObject
      {
         return _clanInfo;
      }
      
      public function get isChatModerator() : int
      {
         return _isChatModerator;
      }
      
      public function get isBot() : Boolean
      {
         return int(_id) < 0;
      }
      
      public function parse(param1:Object) : void
      {
         _id = param1.id;
         _nickname = param1.name;
         _serverId = param1.serverId;
         if(!_nickname)
         {
            _nickname = Translate.translate("UI_COMMON_USR_NO_NAME");
         }
         if(int(_id) < 0 && _nickname.indexOf("T_") != -1)
         {
            _nickname = Translate.translate(_nickname);
         }
         _lastLoginTime = param1.lastLoginTime;
         _avatarId = param1.avatarId;
         _frameId = param1.frameId;
         _level = param1.level;
         _experience = param1.experience;
         _accountId = param1.accountId;
         _clanRole = param1.clanRole;
         _isChatModerator = param1.isChatModerator;
         if(param1.clanId && (!_clanInfo || _clanInfo.id != param1.clanId))
         {
            _clanInfo = new ClanUserInfoValueObject();
            _clanInfo.setupFromUser(param1);
         }
      }
   }
}
