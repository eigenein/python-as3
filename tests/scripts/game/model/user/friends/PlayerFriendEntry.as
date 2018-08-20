package game.model.user.friends
{
   import engine.context.platform.PlatformUser;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.model.user.UserInfo;
   
   public class PlayerFriendEntry
   {
       
      
      private var _serverUser:UserInfo;
      
      private var _id:String;
      
      private var _u2uReceived:int;
      
      private var _giftsReceived:int;
      
      private var _canSendGift:Boolean;
      
      private var _currentUserId:String;
      
      private var _daysSinceLastLogin:int;
      
      private var _platformUser:PlatformUser;
      
      private var _requestSortValue:int;
      
      public function PlayerFriendEntry(param1:Object, param2:PlatformUser, param3:UserInfo)
      {
         super();
         this._serverUser = param3;
         this._platformUser = param2;
         if(param1)
         {
            _id = param1.id;
            _currentUserId = param1.currentUserId;
            _canSendGift = param1.maySendGift;
            _giftsReceived = param1.giftsReceived;
            _u2uReceived = param1.u2uReceived;
         }
         if(param3)
         {
            _daysSinceLastLogin = GameTimer.instance.getDaysFromTime(param3.lastLoginTime);
         }
         else
         {
            _daysSinceLastLogin = -1;
         }
         _requestSortValue = 0;
         if(_daysSinceLastLogin == 0)
         {
            _requestSortValue = _requestSortValue + DataStorage.rule.u2uClientSortRule.day0Value;
         }
         else if(_daysSinceLastLogin == -1)
         {
            _requestSortValue = _requestSortValue + DataStorage.rule.u2uClientSortRule.wipedUserValue;
         }
         else
         {
            _requestSortValue = _requestSortValue + daysSinceLastLogin * DataStorage.rule.u2uClientSortRule.dayWeight;
         }
         _requestSortValue = _requestSortValue + u2uReceived * DataStorage.rule.u2uClientSortRule.requestWeight;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get u2uReceived() : int
      {
         return _u2uReceived;
      }
      
      public function get serverId() : int
      {
         return !!_serverUser?_serverUser.serverId:null;
      }
      
      public function get accountId() : String
      {
         return _platformUser.id;
      }
      
      public function get giftsReceived() : int
      {
         return _giftsReceived;
      }
      
      public function get canSendGift() : Boolean
      {
         return _canSendGift;
      }
      
      public function get nickname() : String
      {
         return !!_serverUser?_serverUser.nickname:"";
      }
      
      public function get serverUserLastLogin() : int
      {
         return !!_serverUser?_serverUser.lastLoginTime:0;
      }
      
      public function get level() : int
      {
         return !!_serverUser?_serverUser.level:0;
      }
      
      public function get serverUserClanId() : int
      {
         return _serverUser && _serverUser.clanInfo?_serverUser.clanInfo.id:0;
      }
      
      public function get serverUserClanRole() : int
      {
         return !!_serverUser?_serverUser.clanRole:0;
      }
      
      public function get userInfo() : UserInfo
      {
         return _serverUser;
      }
      
      public function get currentUserId() : String
      {
         return _currentUserId;
      }
      
      public function get realName() : String
      {
         return !!_platformUser?_platformUser.realName:"";
      }
      
      public function get daysSinceLastLogin() : int
      {
         return _daysSinceLastLogin;
      }
      
      public function get platformUser() : PlatformUser
      {
         return _platformUser;
      }
      
      public function get photoURL() : String
      {
         return !!_platformUser?_platformUser.photoURL:null;
      }
      
      public function get requestSortValue() : int
      {
         return _requestSortValue;
      }
      
      function setCanSendGift(param1:Boolean) : void
      {
         _canSendGift = param1;
      }
   }
}
