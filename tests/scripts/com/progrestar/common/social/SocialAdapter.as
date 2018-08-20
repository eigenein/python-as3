package com.progrestar.common.social
{
   import com.adobe.crypto.MD5;
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.social.datavalue.SocialPaymentBox;
   import flash.display.DisplayObject;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getQualifiedSuperclassName;
   
   [Event(name="eventInstallAppError",type="com.progrestar.common.social.SocialAdapter")]
   [Event(name="eventInstallAppComplete",type="com.progrestar.common.social.SocialAdapter")]
   [Event(name="eventPermissionError",type="com.progrestar.common.social.SocialAdapter")]
   [Event(name="eventPermissionChanged",type="com.progrestar.common.social.SocialAdapter")]
   [Event(name="eventCloseAlertPopup",type="com.progrestar.common.social.SocialAdapter")]
   [Event(name="eventLocationChanged",type="com.progrestar.common.social.SocialAdapter")]
   [Event(name="eventAuthorizationError",type="com.progrestar.common.social.SocialAdapter")]
   public class SocialAdapter extends EventDispatcher
   {
      
      public static var instance:SocialAdapter;
      
      public static const EVENT_INSTALL_APP_ERROR:String = "eventInstallAppError";
      
      public static const EVENT_INSTALL_APP_COMPLETE:String = "eventInstallAppComplete";
      
      public static const EVENT_PERMISSION_ERROR:String = "eventPermissionError";
      
      public static const EVENT_PERMISSION_CHANGED:String = "eventPermissionChanged";
      
      public static const EVENT_CLOSE_ALERT_POPUPS:String = "eventCloseAlertPopup";
      
      public static const EVENT_LOCATION_CHANGED:String = "eventLocationChanged";
      
      public static const EVENT_INITED:String = "eventInited";
      
      public static const EVENT_AUTHORIZATION_ERROR:String = "eventAuthorizationError";
      
      public static const EVENT_FLOOD_ERROR:String = "eventFloodError";
      
      public static const EVENT_OPEN_SOCIAL_BOX:String = "openSocialBox";
      
      public static const EVENT_CLOSE_SOCIAL_BOX:String = "closeSocialBox";
      
      public static const EVENT_OPEN_SOCIAL_PAYMENT_BOX:String = "openSocialPaymentBox";
      
      public static const EVENT_CLOSE_SOCIAL_PAYMENT_BOX:String = "closeSocialPaymentBox";
       
      
      public var networkName:String;
      
      private const SOCIAL_NETS:Array = [null,"T_NETWORK_VK","T_NETWORK_MAIL","T_NETWORK_OK","T_NETWORK_FB","T_NETWORK_GAMESMAILRU"];
      
      private var _networkId:int = -1;
      
      public var SOCIAL_NO_PHOTO_PATTERNS:Array;
      
      public var DEFAULT_PERMISSION_MASK:int;
      
      public var MANDATORY_PERMISSION_MASK:int;
      
      public var PERMISSIONS:int = 0;
      
      public var PERMISSION_NOTIFICATION_MASK:int = 0;
      
      var PERMISSION_FRIENDS_MASK:int = 0;
      
      var PERMISSION_PHOTO_MASK:int = 0;
      
      var PERMISSION_WALL_USER_MASK:int = 0;
      
      var PERMISSION_WALL_FRIEND_MASK:int = 0;
      
      var PERMISSION_WALL_APPFRIEND_MASK:int = 0;
      
      public var PERMISSION_BOOKMARK_MASK:int = 0;
      
      public var PERMISSION_STATUS_MASK:int = 0;
      
      var PERMISSION_NOTES_MASK:int = 0;
      
      public var PERMISSION_WALL_GET_MASK:int = 0;
      
      public var PERMISSION_GROUPS_MASK:int = 0;
      
      public var PERMISSION_AUDIO_MASK:int = 0;
      
      public var CAN_RESIZE:Boolean = false;
      
      public var LOG_SECRET:String;
      
      public var LOG_API_URL:String;
      
      public var STAT_API_URL:String;
      
      public var PAYMENT_DEFAULT:Boolean = true;
      
      public var PAYMENT_SERVER_CHECK:Boolean = false;
      
      public var PAYMENT_EXTERNAL_BILLING:Boolean = false;
      
      protected var user:SocialUser;
      
      protected var users:Dictionary;
      
      protected var usersIds:Array;
      
      protected var friends:Dictionary;
      
      protected var friendsIds:Array;
      
      protected var appFriends:Dictionary;
      
      protected var appFriendsIds:Array;
      
      protected var notAppFriendsIds:Array;
      
      var groups:Array = null;
      
      protected var onInitComplete:Function;
      
      protected var onInitError:Function;
      
      protected var initState:int = 0;
      
      public var autoRefresh:Boolean = true;
      
      public var socialInitFailed:Boolean = false;
      
      public var location:String;
      
      public var keys;
      
      public var flashVars:Object;
      
      protected var _paymentOfferActiveCount:int = -1;
      
      protected var actions:Dictionary;
      
      protected var _initData:Object;
      
      protected var userQueueTimer:Timer;
      
      protected var userQueueCb:Dictionary;
      
      protected var userQueueBlocked:Boolean;
      
      protected var requestRef:URLRequest;
      
      protected var responseEventRef:Event;
      
      public function SocialAdapter()
      {
         users = new Dictionary(true);
         usersIds = [];
         friends = new Dictionary(true);
         friendsIds = [];
         appFriends = new Dictionary(true);
         appFriendsIds = [];
         notAppFriendsIds = [];
         actions = new Dictionary(true);
         _initData = {
            "user":null,
            "friends":null,
            "appFriends":null
         };
         super();
         if(instance)
         {
            throw new Error("Singletone Class. Must be only one instance of SocialAdapter");
         }
         instance = this;
         MANDATORY_PERMISSION_MASK = PERMISSION_NOTIFICATION_MASK | PERMISSION_FRIENDS_MASK;
         DEFAULT_PERMISSION_MASK = MANDATORY_PERMISSION_MASK;
      }
      
      public function get networkId() : int
      {
         if(_networkId == -1)
         {
            _networkId = SOCIAL_NETS.indexOf(networkName);
            if(_networkId == -1)
            {
               _networkId = 0;
            }
         }
         return _networkId;
      }
      
      public function setNetworkId(param1:int) : void
      {
         _networkId = param1;
      }
      
      public function get networkUrlAddress() : String
      {
         return null;
      }
      
      public function get app_id() : String
      {
         return null;
      }
      
      public function get ONLINE_USERS_API_URL() : String
      {
         return null;
      }
      
      public function get PERMISSION_NOTIFICATION() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_NOTIFICATION_MASK);
      }
      
      public function get PERMISSION_GROUPS() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_GROUPS_MASK);
      }
      
      public function get PERMISSION_FRIENDS() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_FRIENDS_MASK);
      }
      
      public function get PERMISSION_PHOTO() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_PHOTO_MASK);
      }
      
      public function get PERMISSION_WALL_USER() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_WALL_USER_MASK);
      }
      
      public function get PERMISSION_WALL_FRIEND() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_WALL_FRIEND_MASK);
      }
      
      public function get PERMISSION_WALL_APPFRIEND() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_WALL_APPFRIEND_MASK);
      }
      
      public function get PERMISSION_BOOKMARK() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_BOOKMARK_MASK);
      }
      
      public function get PERMISSION_STATUS() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_STATUS_MASK);
      }
      
      public function get PERMISSION_NOTES() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_NOTES_MASK);
      }
      
      public function get PERMISSION_WALL_GET() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_WALL_GET_MASK);
      }
      
      public function get PERMISSION_GET_AUDIO() : Boolean
      {
         return Boolean(PERMISSIONS & PERMISSION_AUDIO_MASK);
      }
      
      public function PERMISSION_WALL_FOR(param1:SocialUser) : Boolean
      {
         if(param1.itsMe && PERMISSION_WALL_USER)
         {
            return true;
         }
         if(param1.isFriend && PERMISSION_WALL_FRIEND)
         {
            return true;
         }
         if(param1.isAppFriend && PERMISSION_WALL_APPFRIEND)
         {
            return true;
         }
         return false;
      }
      
      public function get HAS_NOTIFICATION() : Boolean
      {
         return PERMISSION_NOTIFICATION_MASK != 0;
      }
      
      public function get HAS_PHOTO() : Boolean
      {
         return PERMISSION_PHOTO_MASK != 0;
      }
      
      public function get HAS_WALL_USER() : Boolean
      {
         return PERMISSION_WALL_USER_MASK != 0;
      }
      
      public function get HAS_WALL_FRIEND() : Boolean
      {
         return PERMISSION_WALL_FRIEND_MASK != 0;
      }
      
      public function get HAS_WALL_APPFRIEND() : Boolean
      {
         return PERMISSION_WALL_APPFRIEND_MASK != 0;
      }
      
      public function get HAS_BOOKMARK() : Boolean
      {
         return PERMISSION_BOOKMARK_MASK != 0;
      }
      
      public function get HAS_STATUS() : Boolean
      {
         return PERMISSION_STATUS_MASK != 0;
      }
      
      public function get HAS_NOTES() : Boolean
      {
         return PERMISSION_NOTES_MASK != 0;
      }
      
      public function get inited() : Boolean
      {
         return initState == 4;
      }
      
      public function get uid() : String
      {
         return "0";
      }
      
      public function init(param1:Object, param2:Function, param3:Function = null, param4:* = null) : void
      {
         if(initState > 0)
         {
            return;
         }
         initState = 1;
         onInitComplete = param2;
         onInitError = param3;
         keys = param4;
         if(param1 is DisplayObject && getQualifiedSuperclassName(param1 as DisplayObject) == "mx.core::Application")
         {
            param1 = param1.parameters;
         }
         else if(param1["loaderInfo"] != null && param1 is DisplayObject)
         {
            if(param1["loaderInfo"]["parameters"] != null)
            {
               param1 = param1["loaderInfo"]["parameters"];
            }
         }
         this.flashVars = param1;
         preRefresh();
         if(autoRefresh)
         {
            refresh();
         }
      }
      
      public final function createEmptyUserFromFlashVars() : void
      {
         user = new SocialUser();
         user.id = uid;
         user.itsMe = true;
      }
      
      protected function preRefresh() : void
      {
      }
      
      public function refresh(... rest) : void
      {
         args = rest;
         abstractError = function(param1:String, param2:String, param3:Function):void
         {
            removeEventListener(param1,_onRefreshRequired);
            addEventListener(param1,_onRefreshRequired);
            if(dispatchEvent(new Event(param2,false,true)))
            {
               param3();
            }
         };
         if(initState > 2)
         {
            return;
         }
         dispatchEvent(new Event("eventCloseAlertPopup"));
         if(_isAppUser())
         {
            initState = 2;
            if(_checkPermission())
            {
               initState = 3;
               _startInitLoading();
            }
            else
            {
               abstractError("eventPermissionChanged","eventPermissionError",showSettingsBox);
            }
         }
         else
         {
            abstractError("eventInstallAppComplete","eventInstallAppError",showInstallBox);
         }
      }
      
      private function _onRefreshRequired(param1:Event) : void
      {
         removeEventListener(param1.type,_onRefreshRequired);
         refresh();
      }
      
      public function setBookmarkCounter(param1:int = 0, param2:Function = null, param3:Function = null) : void
      {
      }
      
      public function getProfiles(param1:Array, param2:Function, param3:Function = null) : void
      {
         uids = param1;
         onComplete = param2;
         onError = param3;
         var cache:Array = [];
         var i:int = 0;
         while(i < uids.length)
         {
            if(users[uids[i]] != null && users[uids[i]].id == uids[i])
            {
               cache.push(users[uids[i]]);
               uids.splice(i,1);
               i = Number(i) - 1;
            }
            i = Number(i) + 1;
         }
         if(uids.length > 0)
         {
            loadProfiles(uids,function(param1:Array):void
            {
               var _loc3_:int = 0;
               var _loc2_:Array = [];
               _loc3_ = 0;
               while(_loc3_ < param1.length)
               {
                  _loc2_.push(createSocialUser(param1[_loc3_]));
                  addUser(_loc2_[_loc2_.length - 1]);
                  _loc3_++;
               }
            },onError);
         }
         else
         {
            onComplete(cache);
         }
      }
      
      public function addUser(param1:SocialUser, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         users[param1.id] = param1;
         if(!param2 || usersIds.indexOf(param1.id) < 0)
         {
            usersIds.push(param1.id);
         }
         if(param1.isFriend)
         {
            friends[param1.id] = param1;
            if(!param2 || friendsIds.indexOf(param1.id) < 0)
            {
               friendsIds.push(param1.id);
            }
         }
         if(param1.isAppFriend)
         {
            appFriends[param1.id] = param1;
            if(!param2 || appFriendsIds.indexOf(param1.id) < 0)
            {
               appFriendsIds.push(param1.id);
            }
         }
         else if(param1.isFriend)
         {
            if(!param2 || notAppFriendsIds.indexOf(param1.id) < 0)
            {
               notAppFriendsIds.push(param1.id);
            }
         }
      }
      
      public function removeUser(param1:SocialUser) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            delete users[param1.id];
            _loc2_ = usersIds.indexOf(param1.id);
            if(_loc2_ > -1)
            {
               usersIds.splice(_loc2_,1);
            }
            if(param1.isFriend)
            {
               delete friends[param1.id];
               _loc2_ = friendsIds.indexOf(param1.id);
               if(_loc2_ > -1)
               {
                  friendsIds.splice(_loc2_,1);
               }
            }
            if(param1.isAppFriend)
            {
               delete appFriends[param1.id];
               _loc2_ = appFriendsIds.indexOf(param1.id);
               if(_loc2_ > -1)
               {
                  appFriendsIds.splice(_loc2_,1);
               }
            }
            else
            {
               _loc2_ = notAppFriendsIds.indexOf(param1.id);
               if(_loc2_ > -1)
               {
                  notAppFriendsIds.splice(_loc2_,1);
               }
            }
         }
      }
      
      public function invalidateAppFriend(param1:SocialUser) : void
      {
         var _loc2_:int = 0;
         if(param1.isAppFriend)
         {
            delete appFriends[param1.id];
            _loc2_ = appFriendsIds.indexOf(param1.id);
            if(_loc2_ > -1)
            {
               appFriendsIds.splice(_loc2_,1);
            }
         }
      }
      
      public function getUserAlbums(param1:String = null, param2:Function = null, param3:Function = null) : Boolean
      {
         return PERMISSION_PHOTO;
      }
      
      public function getAlbumPhotos(param1:String = null, param2:String = null, param3:Function = null, param4:Function = null, param5:Object = null) : Boolean
      {
         return PERMISSION_PHOTO;
      }
      
      public function getOnlineFriends(param1:Function, param2:Function) : Boolean
      {
         return false;
      }
      
      public function getOnlineExecute(param1:Array, param2:Function, param3:Function) : Boolean
      {
         return false;
      }
      
      public function filterNotMobileExecute(param1:Array, param2:Function, param3:Function) : void
      {
      }
      
      public function getPlayer() : SocialUser
      {
         return user;
      }
      
      public function getUserById(param1:String) : SocialUser
      {
         if(users[param1])
         {
            return users[param1];
         }
         return friends[param1];
      }
      
      public function getFriendList() : Array
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         var _loc1_:Dictionary = friends;
         var _loc6_:int = 0;
         var _loc5_:* = _loc1_;
         for(var _loc4_ in _loc1_)
         {
            _loc2_ = _loc1_[_loc4_] as SocialUser;
            if(_loc2_ && _loc4_ != user.id)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getFriends() : Dictionary
      {
         return friends;
      }
      
      public function getFriendsIds() : Array
      {
         return friendsIds;
      }
      
      public function getAppFriends() : Dictionary
      {
         return appFriends;
      }
      
      public function getAppFriendsList() : Array
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         var _loc1_:Dictionary = getAppFriends();
         var _loc6_:int = 0;
         var _loc5_:* = _loc1_;
         for(var _loc4_ in _loc1_)
         {
            _loc2_ = _loc1_[_loc4_] as SocialUser;
            if(_loc2_ && _loc4_ != user.id)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getAppFriendsIds() : Array
      {
         return appFriendsIds;
      }
      
      public function getNotAppFriendsIds() : Array
      {
         return notAppFriendsIds;
      }
      
      public function getNotAppFriends() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = friends;
         for(var _loc1_ in friends)
         {
            if(!SocialUser(friends[_loc1_]).isAppFriend)
            {
               _loc2_[_loc1_] = friends[_loc1_];
            }
         }
         return _loc2_;
      }
      
      public function getNotAppFriendsList() : Array
      {
         var _loc1_:* = null;
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = friends;
         for(var _loc2_ in friends)
         {
            _loc1_ = friends[_loc2_];
            if(_loc1_ && !_loc1_.isAppFriend)
            {
               _loc3_.push(_loc1_);
            }
         }
         return _loc3_;
      }
      
      public function getRandomNotAppFriend() : SocialUser
      {
         var _loc3_:Array = getNotAppFriendsList();
         var _loc2_:int = _loc3_.length * Math.random();
         var _loc1_:SocialUser = _loc3_[_loc2_];
         return _loc1_;
      }
      
      public function isGroup(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         if(!groups)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < groups.length)
         {
            if(groups[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function createSocialUser(param1:Object) : SocialUser
      {
         throw new Error("Must be overridden");
      }
      
      public function get authentication_key() : String
      {
         throw new Error("Must be overridden");
      }
      
      public function get session_key() : String
      {
         return "";
      }
      
      public function resizeApplication(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function get initObject() : Object
      {
         dd = function(param1:int):String
         {
            if(param1 < 10)
            {
               return "0" + param1;
            }
            return param1.toString();
         };
         if(!getPlayer())
         {
            return null;
         }
         var bdate:Date = user.bdate == 0?null:new Date(user.bdate * 1000);
         var dict:Dictionary = getAppFriends();
         dict[user.id] = user;
         var obj:Object = {"social":{
            "friends":[],
            "bdate":(!!bdate?bdate.fullYear.toString() + "-" + dd(bdate.month + 1) + "-" + dd(bdate.date):""),
            "name":user.getFullName(),
            "male":(!!user.male?"1":"0"),
            "zcity":user.city,
            "zcountry":user.country
         }};
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for(key in dict)
         {
            if((dict[key] as SocialUser).id != getPlayer().id)
            {
               (obj["social"]["friends"] as Array).push((dict[key] as SocialUser).id);
            }
         }
         obj["referrer"] = {
            "id":0,
            "type":""
         };
         obj["sessionData"] = "";
         return obj;
      }
      
      public function loadProfiles(param1:Array, param2:Function, param3:Function = null) : void
      {
         throw new Error("Must be overridden");
      }
      
      public function loadUserProfile(param1:Function, param2:Function = null) : void
      {
         throw new Error("Must be overridden");
      }
      
      public function loadUserGroups(param1:Function = null, param2:Function = null) : Boolean
      {
         return PERMISSION_GROUPS;
      }
      
      public function loadUserFriends(param1:Function, param2:Function = null) : void
      {
         throw new Error("Must be overridden");
      }
      
      public function loadUserFriendsProfiles(param1:Function, param2:Function = null) : void
      {
         throw new Error("Must be overridden");
      }
      
      public function loadUserAppFriends(param1:Function, param2:Function = null) : void
      {
         throw new Error("Must be overridden");
      }
      
      public function showInstallBox(param1:* = null) : Boolean
      {
         throw new Error("Must be overridden");
      }
      
      public function showSettingsBox(param1:* = null) : Boolean
      {
         throw new Error("Must be overridden");
      }
      
      public function showPaymentBox(param1:SocialPaymentBox) : Boolean
      {
         throw new Error("Must be overridden");
      }
      
      public function showRefillSocialMoneyBox() : void
      {
         throw new Error("Must be overridden");
      }
      
      public function get paymentData() : Object
      {
         return {};
      }
      
      public function get paymentOfferActiveCount() : int
      {
         return _paymentOfferActiveCount;
      }
      
      public function paymentOfferGetActive(param1:Function = null, param2:Function = null) : void
      {
         throw new Error("needs to be overridden");
      }
      
      public function paymentOfferShowPaymentBox(param1:int = 0, param2:Function = null, param3:Function = null) : void
      {
         throw new Error("needs to be overridden");
      }
      
      public function showInviteBox(param1:String = null, param2:String = null, param3:Function = null, param4:Function = null) : Boolean
      {
         return false;
      }
      
      public function wallPost(param1:SocialUser = null, param2:String = null, param3:String = null, param4:* = null, param5:String = null, param6:String = null, param7:Function = null, param8:Function = null, param9:Object = null) : Boolean
      {
         dispatchEvent(new Event("openSocialBox"));
         return PERMISSION_WALL_FOR(param1);
      }
      
      public function wallGet(param1:Function = null, param2:Function = null) : void
      {
      }
      
      public function wallPhotoPost(param1:String = "", param2:* = null, param3:Function = null, param4:Function = null, param5:Function = null) : Boolean
      {
         return PERMISSION_PHOTO;
      }
      
      public function getAudioData(param1:String, param2:uint, param3:Function = null, param4:Function = null) : void
      {
      }
      
      public function notePost(param1:String, param2:String = null, param3:Function = null, param4:Function = null) : void
      {
      }
      
      public function photoAlbumPost(param1:String = null, param2:String = null, param3:* = null, param4:Function = null, param5:Function = null, param6:Object = null) : Boolean
      {
         return PERMISSION_PHOTO;
      }
      
      public function photoAlbumURLPost(param1:String = null, param2:String = null, param3:String = null, param4:Function = null, param5:Function = null, param6:Object = null) : Boolean
      {
         return PERMISSION_PHOTO;
      }
      
      public function photoEdit(param1:String = null, param2:String = null, param3:String = null, param4:Function = null, param5:Function = null, param6:Object = null) : Boolean
      {
         return PERMISSION_PHOTO;
      }
      
      public function makeAction(param1:String, param2:SocialUser = null, param3:* = null, param4:String = null, param5:Function = null, param6:Function = null, param7:Array = null, param8:Object = null) : Boolean
      {
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc11_:Boolean = false;
         if(param7 && param7.length == 1 && param7[0] is Array)
         {
            param7 = param7[0];
         }
         if(param2 && param2.itsMe)
         {
            param2 = null;
         }
         if(!actions[param1] || actions[param1] == "wall_post")
         {
            _loc12_ = param1.toUpperCase();
            _loc13_ = {"linkText":Translate.translateArgs("T_SOCIAL_ACTION_" + _loc12_ + "_LINK_TEXT",param7)};
            if(param8)
            {
               var _loc15_:int = 0;
               var _loc14_:* = param8;
               for(var _loc10_ in param8)
               {
                  _loc13_[_loc10_] = param8[_loc10_];
               }
            }
            return wallPost(param2,Translate.translateArgs("T_SOCIAL_ACTION_" + _loc12_ + "_TITLE",param7),Translate.translateArgs("T_SOCIAL_ACTION_" + _loc12_ + "_TEXT",param7),param3,param1,param4,param5,param6,_loc13_);
         }
         if(actions[param1] == "invite")
         {
            return showInviteBox();
         }
         if(actions[param1] is Function)
         {
            _loc11_ = false;
            try
            {
               _loc11_ = actions[param1](param2,param3,param4,param5,param6,param7);
            }
            catch(e:Error)
            {
               trace("makeAction error for type=" + param1 + ", args:" + JSON.stringify(arguments));
               _loc14_ = false;
               return _loc14_;
            }
            return _loc11_;
         }
         if(actions[param1] == "status")
         {
            setStatus(Translate.translateArgs("T_SOCIAL_ACTION_" + param1 + "_TEXT",param7),param5,param6,Translate.translate("T_SOCIAL_ACTION_" + param1 + "_TITLE"));
         }
         return false;
      }
      
      public function setAction(param1:String, param2:*) : void
      {
         actions[param1] = param2;
      }
      
      public function getAction(param1:String) : *
      {
         return actions[param1];
      }
      
      public function hasAction(param1:String) : Boolean
      {
         return actions[param1] != null;
      }
      
      public function setStatus(param1:String, param2:Function, param3:Function, param4:String = null, param5:String = null) : void
      {
         throw new Error("Must be overriden");
      }
      
      protected function _isAppUser() : Boolean
      {
         throw new Error("Must be overridden");
      }
      
      function __isAppUser() : Boolean
      {
         return _isAppUser();
      }
      
      protected function _checkPermission() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = Math.log(MANDATORY_PERMISSION_MASK) / Math.log(2);
         _loc1_ = 0;
         while(_loc1_ <= _loc2_)
         {
            if(MANDATORY_PERMISSION_MASK & 1 << _loc1_)
            {
               if(!(PERMISSIONS & 1 << _loc1_))
               {
                  return false;
               }
            }
            _loc1_++;
         }
         return true;
      }
      
      protected function _startInitLoading() : void
      {
         loadUserProfile(function(param1:Object = null):void
         {
            trace("user was loaded");
            _initData["user"] = param1;
            _checkInitLoadingCompletion();
         },function(param1:Object = null):void
         {
            var _loc2_:* = null;
            trace("user was not loaded");
            if(SocialAdapterConfig.loadOnApiError)
            {
               trace("continue with empty user");
               _loc2_ = {};
               _loc2_.uid = uid;
               _loc2_.first_name = "";
               _loc2_.last_name = "";
               _initData["user"] = _loc2_;
               _checkInitLoadingCompletion();
            }
         });
         loadUserFriendsProfiles(function(param1:Object = null):void
         {
            trace("friends were loaded");
            _initData["friends"] = param1;
            _checkInitLoadingCompletion();
         },function(param1:Object = null):void
         {
            if(SocialAdapterConfig.loadOnApiError)
            {
               trace("friends were not loaded");
               _initData["friends"] = [];
               _checkInitLoadingCompletion();
            }
         });
         loadUserAppFriends(function(param1:Object = null):void
         {
            trace("appfriends were loaded");
            _initData["appFriends"] = param1;
            _checkInitLoadingCompletion();
         },function(param1:Object = null):void
         {
            if(SocialAdapterConfig.loadOnApiError)
            {
               trace("appfriends were not loaded");
               _initData["appFriends"] = [];
               _checkInitLoadingCompletion();
            }
         });
      }
      
      protected function _checkInitLoadingCompletion() : Boolean
      {
         if(_initData.user !== null && _initData.friends !== null && _initData.appFriends !== null)
         {
            _parseInitData();
            return true;
         }
         return false;
      }
      
      protected function _parseInitData() : void
      {
         complete = function():void
         {
            initState = 4;
            dispatchEvent(new Event("eventInited"));
         };
         if(!(_initData.friends is Array))
         {
            _initData.friends = [];
         }
         if(!(_initData.appFriends is Array))
         {
            _initData.appFriends = [];
         }
         if(!(_initData.groups is Array))
         {
            _initData.groups = [];
         }
         var tempAppFriendsIds:Array = _initData.appFriends;
         var i:int = 0;
         while(i < tempAppFriendsIds.length)
         {
            tempAppFriendsIds[i] = String(tempAppFriendsIds[i]);
            i = Number(i) + 1;
         }
         i = 0;
         while(i < _initData.friends.length)
         {
            var friend:SocialUser = createSocialUser(_initData.friends[i]);
            var appFrienIndex:int = tempAppFriendsIds.indexOf(friend.id);
            if(appFrienIndex != -1)
            {
               friend.isAppFriend = true;
               tempAppFriendsIds.splice(appFrienIndex,1);
            }
            friend.isFriend = true;
            addUser(friend);
            i = Number(i) + 1;
         }
         user = createSocialUser(_initData.user);
         user.itsMe = true;
         users[user.id] = user;
         usersIds.push(user);
         if(_initData.groups)
         {
            groups = _initData.groups;
         }
         if(tempAppFriendsIds.length)
         {
            loadProfiles(tempAppFriendsIds,function(param1:Object):void
            {
               var _loc4_:int = 0;
               var _loc2_:* = null;
               var _loc3_:Array = param1 as Array;
               if(_loc3_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     _loc2_ = createSocialUser(_loc3_[_loc4_]);
                     _loc2_.isAppFriend = true;
                     _loc2_.isFriend = true;
                     addUser(_loc2_);
                     _loc4_++;
                  }
               }
            },function(param1:Object):void
            {
               trace("загружаемся без части апп юзеров");
            });
         }
         else
         {
            complete();
         }
      }
      
      protected function _getApiUrl(param1:String, param2:Object = null) : String
      {
         throw new Error("Must be overridden");
      }
      
      protected function _sendRequest(param1:String, param2:Object = null, param3:Function = null, param4:Function = null, param5:Boolean = false) : void
      {
         method = param1;
         request = param2;
         onComplete = param3;
         onError = param4;
         GET = param5;
         var urlRequest:URLRequest = new URLRequest();
         urlRequest.method = !!GET?"GET":"POST";
         urlRequest.url = _getApiUrl(method,request);
         var urlVariables:URLVariables = _getUrlVariables(method);
         if(request)
         {
            var _loc8_:int = 0;
            var _loc7_:* = request;
            for(s in request)
            {
               urlVariables[s] = request[s];
            }
         }
         _createSignature(urlVariables);
         var urlLoader:URLLoader = new URLLoader();
         var onLoaderComplete:Function = function(param1:Event):void
         {
            clearLoader(urlLoader);
            responseEventRef = param1;
            _responseHandler(urlLoader.data,onComplete,onError);
            responseEventRef = null;
            requestRef = null;
         };
         var onIOError:Function = function(param1:IOErrorEvent):void
         {
            clearLoader(urlLoader);
            onError && onError({"error":param1.text});
            logError(method,param1,200,request);
            requestRef = null;
         };
         var onSecurityError:Function = function(param1:SecurityErrorEvent):void
         {
            clearLoader(urlLoader);
            onError && onError({"error":param1.text});
            logError(method,param1,200,request);
            requestRef = null;
         };
         var clearLoader:Function = function(param1:URLLoader):void
         {
            requestRef = urlRequest;
            param1.removeEventListener("complete",onLoaderComplete);
            param1.removeEventListener("ioError",onIOError);
            param1.removeEventListener("securityError",onSecurityError);
         };
         urlLoader.addEventListener("complete",onLoaderComplete);
         urlLoader.addEventListener("ioError",onIOError);
         urlLoader.addEventListener("securityError",onSecurityError);
         urlRequest.data = urlVariables;
         urlLoader.load(urlRequest);
      }
      
      protected function _getUrlVariables(param1:String) : URLVariables
      {
         throw new Error("Must be overridden");
      }
      
      public function getSocialUsersByIds(param1:Array, param2:Function) : void
      {
         var _loc3_:int = 0;
         if(!userQueueTimer)
         {
            userQueueTimer = new Timer(200,0);
         }
         if(!userQueueCb)
         {
            userQueueCb = new Dictionary(true);
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(!userQueueCb[param1[_loc3_]])
            {
               userQueueCb[param1[_loc3_]] = [];
            }
            (userQueueCb[param1[_loc3_]] as Array).push(param2);
            _loc3_++;
         }
         if(!userQueueTimer.running)
         {
            userQueueTimer.addEventListener("timer",onUserQueueFull);
            userQueueTimer.start();
         }
      }
      
      protected function onUserQueueFull(param1:TimerEvent) : void
      {
         if(userQueueBlocked)
         {
            return;
         }
         userQueueBlocked = true;
         userQueueTimer.stop();
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = userQueueCb;
         for(var _loc3_ in userQueueCb)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               _loc2_.push(_loc3_);
            }
         }
         getProfiles(_loc2_,onUserQueueInfoComplete,onUserQueueInfoComplete);
      }
      
      protected function onUserQueueInfoComplete(... rest) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = userQueueCb;
         for(var _loc3_ in userQueueCb)
         {
            _loc5_ = userQueueCb[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               if(_loc2_.indexOf(_loc5_[_loc4_]) == -1)
               {
                  _loc2_.push(_loc5_[_loc4_]);
                  (_loc5_[_loc4_] as Function)();
               }
               _loc4_++;
            }
            delete userQueueCb[_loc3_];
         }
         userQueueBlocked = false;
      }
      
      protected function _createSignature(param1:Object) : void
      {
      }
      
      protected function _responseHandler(param1:String, param2:Function, param3:Function) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            param3 && param3({"error":"Empty server response"});
            logError();
            return false;
         }
         return true;
      }
      
      protected function _safetyJSONDecode(param1:String, param2:Function) : Object
      {
         var _loc3_:* = undefined;
         try
         {
            _loc3_ = JSON.parse(param1);
            if(_loc3_ == null || _loc3_ === "" || _loc3_ === "null")
            {
               param2 && param2({"error":"JSON parsing error (empty result)"});
            }
            else
            {
               var _loc5_:* = _loc3_;
               return _loc5_;
            }
         }
         catch(e:Error)
         {
            param2 && param2({"error":"JSON parsing error"});
         }
         return null;
      }
      
      protected function logError(param1:String = null, param2:Object = null, param3:int = 200, param4:Object = null) : void
      {
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc9_:* = null;
         if(SocialAdapterConfig.logErrors == false)
         {
            return;
         }
         if(LOG_SECRET == null)
         {
            return;
            §§push(trace("Log api secret key not assigned"));
         }
         else if(LOG_API_URL == null)
         {
            return;
            §§push(trace("LOG_API_URL not assigned"));
         }
         else
         {
            if(hasEventListener("socialNetworkApiError"))
            {
               dispatchEvent(new SocialAdapterErrorEvent("socialNetworkApiError",param1,param2));
               return;
            }
            if(param1 == null && requestRef != null)
            {
               _loc10_ = {};
               var _loc12_:int = 0;
               var _loc11_:* = requestRef.data;
               for(var _loc7_ in requestRef.data)
               {
                  _loc10_[_loc7_] = requestRef.data[_loc7_];
               }
               param1 = JSON.stringify(_loc10_);
            }
            if(param1 == null)
            {
               param1 = "{\"text\":null}";
            }
            if(param2 == null && responseEventRef != null)
            {
               param2 = responseEventRef;
            }
            if(param2 is Event)
            {
               if(Event(param2).type == "complete" && Event(param2).target is URLLoader)
               {
                  param2 = param2.target.data;
               }
               else
               {
                  if(param3 == 200)
                  {
                     if(param2 is ErrorEvent)
                     {
                        _loc5_ = ErrorEvent(param2);
                        _loc9_ = _loc5_.text.match(/\d+/);
                        param3 = !!_loc9_?parseInt(_loc9_[0]):0;
                     }
                     else
                     {
                        param3 = 0;
                     }
                  }
                  param2 = param2.target && param2.target.hasOwnProperty("data") && param2.target.data != null?"{\"text\":\"" + escape(param2.target.data) + "\"}":JSON.stringify(param2);
               }
            }
            else if(!(param2 is String))
            {
               param2 = JSON.stringify(param2);
            }
            if(param2 == null || param2 is String && String(param2).length == 0)
            {
               param2 = "{\"text\":null}";
            }
            var _loc8_:URLLoader = new URLLoader();
            var _loc6_:URLRequest = new URLRequest(LOG_API_URL);
            _loc6_.method = "POST";
            _loc6_.data = _getLogUrlVariables();
            _loc6_.data["secret"] = MD5.hash(LOG_SECRET + _loc6_.data["user_id"]);
            _loc6_.data["network_id"] = networkId;
            _loc6_.data["request"] = param1;
            _loc6_.data["response"] = param2;
            _loc6_.data["status"] = param3;
            _loc6_.data["fversion"] = Capabilities.version;
            if(param4)
            {
               if(param4.hasOwnProperty("url"))
               {
                  _loc6_.data["url"] = param4.url;
               }
            }
            _loc8_.addEventListener("ioError",traceEvent);
            _loc8_.addEventListener("securityError",traceEvent);
            _loc8_.load(_loc6_);
            return;
         }
      }
      
      private function traceEvent(param1:*) : void
      {
      }
      
      protected function _getLogUrlVariables() : URLVariables
      {
         throw new Error("Must be overriden");
      }
      
      public function showNotification(param1:String, param2:String = null, param3:Function = null, param4:Function = null) : Boolean
      {
         return false;
      }
      
      public function sendMessage(param1:String, param2:String = "", param3:Function = null, param4:Function = null) : Boolean
      {
         return false;
      }
   }
}
