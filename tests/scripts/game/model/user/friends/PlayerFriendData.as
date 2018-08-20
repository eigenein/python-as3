package game.model.user.friends
{
   import engine.context.platform.PlatformUser;
   import flash.utils.Dictionary;
   import game.model.GameModel;
   import game.model.user.UserInfo;
   import idv.cjcat.signals.Signal;
   
   public class PlayerFriendData
   {
       
      
      private var appFriendDict:Dictionary;
      
      private var notAppFriendDict:Dictionary;
      
      private var _signal_update:Signal;
      
      public function PlayerFriendData()
      {
         super();
         _signal_update = new Signal();
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function init(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 1;
         appFriendDict = new Dictionary();
         var _loc14_:int = 0;
         var _loc13_:* = param1.accounts;
         for each(var _loc8_ in param1.accounts)
         {
            _loc6_ = GameModel.instance.context.platformFacade.getPlatformUserById(_loc8_.id);
            _loc4_ = null;
            var _loc12_:int = 0;
            var _loc11_:* = param1.users;
            for(var _loc10_ in param1.users)
            {
               if(param1.users[_loc10_].accountId == _loc8_.id)
               {
                  _loc4_ = new UserInfo();
                  _loc4_.parse(param1.users[_loc10_]);
                  break;
               }
            }
            _loc2_ = new PlayerFriendEntry(_loc8_,_loc6_,_loc4_);
            appFriendDict[_loc2_.id] = _loc2_;
         }
         notAppFriendDict = new Dictionary();
         var _loc5_:Vector.<PlatformUser> = GameModel.instance.context.platformFacade.notAppFriends;
         _loc3_ = _loc5_.length;
         _loc9_ = 0;
         while(_loc9_ < _loc3_)
         {
            _loc6_ = _loc5_[_loc9_];
            _loc2_ = new PlayerFriendEntry(null,_loc6_,null);
            notAppFriendDict[_loc2_.accountId] = _loc2_;
            _loc9_++;
         }
      }
      
      public function getByAccountId(param1:String) : PlayerFriendEntry
      {
         if(appFriendDict[param1])
         {
            return appFriendDict[param1];
         }
         if(notAppFriendDict[param1])
         {
            return notAppFriendDict[param1];
         }
         return null;
      }
      
      public function getFriendsToSendGift() : Vector.<PlayerFriendEntry>
      {
         var _loc1_:Vector.<PlayerFriendEntry> = new Vector.<PlayerFriendEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = appFriendDict;
         for each(var _loc2_ in appFriendDict)
         {
            if(_loc2_.canSendGift)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getAppFriends() : Vector.<PlayerFriendEntry>
      {
         var _loc1_:Vector.<PlayerFriendEntry> = new Vector.<PlayerFriendEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = appFriendDict;
         for each(var _loc2_ in appFriendDict)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getNotAppFriends() : Vector.<PlayerFriendEntry>
      {
         var _loc1_:Vector.<PlayerFriendEntry> = new Vector.<PlayerFriendEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = notAppFriendDict;
         for each(var _loc2_ in notAppFriendDict)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function onDailyGiftSent(param1:Vector.<PlayerFriendEntry>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = appFriendDict;
         for each(var _loc2_ in appFriendDict)
         {
            if(param1.indexOf(_loc2_) != -1)
            {
               _loc2_.setCanSendGift(false);
            }
         }
         _signal_update.dispatch();
      }
   }
}
