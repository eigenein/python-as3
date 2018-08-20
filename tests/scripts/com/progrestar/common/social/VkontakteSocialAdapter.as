package com.progrestar.common.social
{
   import com.adobe.crypto.MD5;
   import com.adobe.images.JPGEncoder;
   import com.progrestar.common.social.datavalue.PaymentOfferDescription;
   import com.progrestar.common.social.datavalue.SocialPaymentBox;
   import com.progrestar.common.util.HashModem;
   import engine.core.utils.VectorUtil;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLVariables;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getQualifiedSuperclassName;
   import flash.utils.getTimer;
   import vk.APIAdapter;
   
   public class VkontakteSocialAdapter extends SocialAdapter
   {
       
      
      public var wrapper:Object;
      
      protected var _balance:Number = 0;
      
      public var useSecure:Boolean;
      
      public var onWallPost:Function;
      
      public var onWallView:Function;
      
      protected var _networkURLAddress:String;
      
      private var lastWallGetArgs:Array;
      
      protected var balanceLoading:Boolean = false;
      
      protected var onBalanceChangeCallback:Function = null;
      
      public var defaultBalanceChangedCallback:Function;
      
      public var request_onComplete:Function;
      
      public var request_onCancel:Function;
      
      protected var lastWallPostArgs:Array;
      
      private var filteredUids:Array;
      
      protected var lastPhotoArgs:Array;
      
      protected var lastWallPhotoPostParams:Array;
      
      protected var lastgetAudioParams:Array;
      
      protected var lastNotepostParams:Array;
      
      private var lastStatusArgs:Array;
      
      protected var forExecution:Array;
      
      protected var lastRequestSecond:int;
      
      protected var lastRequestCounter:int;
      
      protected var lastRequestTime:Number = 0;
      
      protected var pendingRequests:Array;
      
      protected var sendRequestTimer:Timer;
      
      protected var lastRequestFailed:Boolean;
      
      protected var albumCache:Dictionary;
      
      private var wallPostManager_wallPhoto:Boolean;
      
      private var wallPostManager_onComplete:Function;
      
      protected var wallPostManager_onError:Function;
      
      protected var wallPostManager_images:Array;
      
      private var wallPostManager_recipient_id:String;
      
      private var wallPostManager_message:String;
      
      private var wallPostManager_post_id:String;
      
      protected var wallPostManager_album:Object;
      
      protected var wallPostManager_albums:Array;
      
      protected var wallPostManager_photoAlbumPostResponse:Array;
      
      protected var permissionCallbacks:Array;
      
      public function VkontakteSocialAdapter()
      {
         forExecution = [];
         pendingRequests = [];
         albumCache = new Dictionary(true);
         permissionCallbacks = [];
         networkName = "T_NETWORK_VK";
         CAN_RESIZE = true;
         PERMISSION_BOOKMARK_MASK = 256;
         PERMISSION_NOTIFICATION_MASK = 1;
         PERMISSION_FRIENDS_MASK = 2;
         PERMISSION_PHOTO_MASK = 4;
         PERMISSION_AUDIO_MASK = 8;
         PERMISSION_STATUS_MASK = 1024;
         PERMISSION_NOTES_MASK = 2048;
         PERMISSION_WALL_USER_MASK = 0;
         PERMISSION_WALL_APPFRIEND_MASK = 1;
         PERMISSION_WALL_FRIEND_MASK = 1;
         PERMISSION_WALL_GET_MASK = 8192;
         PERMISSION_GROUPS_MASK = 262144;
         super();
      }
      
      public function get protocol() : String
      {
         return !!useSecure?"https://":"http://";
      }
      
      override public function get uid() : String
      {
         return flashVars["viewer_id"];
      }
      
      override public function paymentOfferGetActive(param1:Function = null, param2:Function = null) : void
      {
         onComplete = param1;
         onError = param2;
         _sendRequest("leads.getActive",{},function(param1:Object):void
         {
            var _loc5_:int = 0;
            var _loc4_:* = null;
            var _loc2_:* = null;
            try
            {
               _paymentOfferActiveCount = param1[0];
            }
            catch(e:*)
            {
               onError && onError();
               return;
            }
            var _loc3_:int = param1.length;
            _loc5_ = 1;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = param1[_loc5_];
               _loc2_ = new PaymentOfferDescription();
               _loc2_.id = _loc4_.id;
               _loc2_.data = _loc4_;
               param1[_loc5_] = _loc2_;
               _loc5_++;
            }
         },onError);
      }
      
      override public function paymentOfferShowPaymentBox(param1:int = 0, param2:Function = null, param3:Function = null) : void
      {
         var _loc4_:* = null;
         if(wrapper)
         {
            _loc4_ = {};
            wrapper.external.callMethod("showLeadsPaymentBox",param1,param2,param3);
         }
      }
      
      override public function PERMISSION_WALL_FOR(param1:SocialUser) : Boolean
      {
         if(!param1.isFriend)
         {
            return true;
         }
         return super.PERMISSION_WALL_FOR(param1);
      }
      
      override public function getUserAlbums(param1:String = null, param2:Function = null, param3:Function = null) : Boolean
      {
         removePermisssionCallback(PERMISSION_PHOTO_MASK,getUserAlbums);
         if(super.getUserAlbums())
         {
            _sendRequest("photos.getAlbums",{"uid":param1},param2,param3);
            return true;
         }
         addPermissionCallback(PERMISSION_PHOTO_MASK,getUserAlbums,arguments);
         showSettingsBox(PERMISSION_PHOTO_MASK);
         return false;
      }
      
      override public function getAlbumPhotos(param1:String = null, param2:String = null, param3:Function = null, param4:Function = null, param5:Object = null) : Boolean
      {
         uid = param1;
         aid = param2;
         onComplete = param3;
         onError = param4;
         additionalParams = param5;
         arguments = arguments;
         removePermisssionCallback(PERMISSION_PHOTO_MASK,getAlbumPhotos);
         if(super.getAlbumPhotos())
         {
            var requestParams:Object = {};
            requestParams.aid = aid;
            if(additionalParams)
            {
               var _loc9_:int = 0;
               var _loc8_:* = additionalParams;
               for(s in additionalParams)
               {
                  requestParams[s] = additionalParams[s];
               }
            }
            if(!requestParams.gid && uid)
            {
               requestParams.uid = uid;
            }
            _sendRequest("photos.get",requestParams,function(param1:Object):void
            {
               if(!(param1 is Array))
               {
                  param1 = [];
               }
            },onError);
            return true;
         }
         addPermissionCallback(PERMISSION_PHOTO_MASK,getAlbumPhotos,arguments);
         showSettingsBox(PERMISSION_PHOTO_MASK);
         return false;
      }
      
      public function setNameInMenu(param1:String) : void
      {
         if(PERMISSION_BOOKMARK)
         {
            _sendRequest("setNameInMenu",{"name":param1});
         }
      }
      
      override public function setBookmarkCounter(param1:int = 0, param2:Function = null, param3:Function = null) : void
      {
         if(PERMISSION_BOOKMARK)
         {
            _sendRequest("setCounter",{
               "counter":param1,
               "uid":uid
            },param2,param3);
         }
         else
         {
            param3 && param3();
         }
      }
      
      override public function get networkUrlAddress() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         if(flashVars["domain"])
         {
            return protocol + flashVars["domain"];
         }
         if(flashVars["api_url"])
         {
            try
            {
               if(_networkURLAddress)
               {
                  var _loc5_:* = _networkURLAddress;
                  return _loc5_;
               }
               _loc2_ = flashVars["api_url"];
               _loc2_ = _loc2_.substr(_loc2_.indexOf("api.") + 4);
               _loc2_ = _loc2_.substring(0,_loc2_.length - "/api.php".length);
               _loc1_ = _loc2_.split(".");
               _loc3_ = _loc1_[0].indexOf("vk");
               if(_loc3_ == -1)
               {
                  _loc1_.shift();
               }
               _loc2_ = _loc1_.join(".");
               _networkURLAddress = protocol + _loc2_;
               var _loc6_:* = _networkURLAddress;
               return _loc6_;
            }
            catch(e:*)
            {
            }
         }
         return protocol + "vkontakte.ru";
      }
      
      override public function get app_id() : String
      {
         return flashVars["api_id"];
      }
      
      override public function init(param1:Object, param2:Function, param3:Function = null, param4:* = null) : void
      {
         if(param1 is DisplayObject)
         {
            if(getQualifiedSuperclassName(param1 as DisplayObject) == "mx.core::Application")
            {
               if(param1.parent.parent.parent)
               {
                  wrapper = param1.parent.parent.parent;
                  param1 = wrapper.application.parameters;
               }
            }
            else if(param1.parent.parent)
            {
               wrapper = param1.parent.parent;
               param1 = wrapper.application.parameters;
            }
         }
         onInitComplete = param2;
         onInitError = param3;
         keys = param4;
         if(wrapper == null && param1["loaderInfo"] && param1 is DisplayObject)
         {
            if(param1["loaderInfo"]["parameters"])
            {
               param1 = param1["loaderInfo"]["parameters"];
            }
         }
         this.flashVars = param1;
         var _loc5_:String = _getApiUrl(null);
         _loc5_ = _loc5_.replace("api.php","crossdomain.xml");
         Security.loadPolicyFile(_loc5_);
         if(flashVars.referrer == "wall_view_inline")
         {
            if(onWallView != null)
            {
               initState = 4;
               onWallView(flashVars);
            }
            else
            {
               throw new Error("\"Wall View\" handler not specified");
            }
         }
         else if(flashVars.referrer == "wall_post_inline")
         {
            if(onWallPost != null)
            {
               initState = 4;
               onWallPost(flashVars);
            }
            else
            {
               throw new Error("\"Wall Post\" handler not specified");
            }
         }
         else
         {
            createListeners();
            preRefresh();
            if(wrapper)
            {
               wrapper.addEventListener("onWindowFocus",onWindowFocus);
            }
            if(autoRefresh)
            {
               refresh();
            }
         }
      }
      
      override public function wallGet(param1:Function = null, param2:Function = null) : void
      {
         if(PERMISSION_WALL_GET)
         {
            _sendRequest("wall.get",{
               "filter":"all",
               "offset":0,
               "count":50
            },param1,param2);
         }
         else
         {
            removeEventListener("eventPermissionChanged",onWallGetSettingChange);
            addEventListener("eventPermissionChanged",onWallGetSettingChange);
            lastWallGetArgs = arguments;
            showSettingsBox(PERMISSION_WALL_GET_MASK);
         }
      }
      
      private function onWallGetSettingChange(param1:Event) : void
      {
         removeEventListener("eventPermissionChanged",onWallGetSettingChange);
         if(lastWallGetArgs)
         {
            wallGet.apply(this,lastWallGetArgs);
            lastWallGetArgs = null;
         }
      }
      
      protected function createListeners() : void
      {
         wrapper && wrapper.addEventListener("onLocationChanged",function(param1:Object):void
         {
            if(param1["location"] && param1["location"].length > 0 && (location == null || flashVars["post_id"] == null))
            {
               location = param1["location"];
               try
               {
                  location = HashModem.demodulate(param1.location);
               }
               catch(e:Error)
               {
               }
               dispatchEvent(new Event("eventLocationChanged"));
            }
         });
         if(flashVars["post_id"] || flashVars["request_key"])
         {
            var loc:String = flashVars["post_id"] || flashVars["request_key"];
            try
            {
               location = HashModem.demodulate(loc);
            }
            catch(e:Error)
            {
               location = loc;
            }
            dispatchEvent(new Event("eventLocationChanged"));
         }
      }
      
      override protected function preRefresh() : void
      {
         PERMISSIONS = flashVars["api_settings"];
      }
      
      protected function execute(param1:String, param2:Function, param3:Function = null) : void
      {
         _sendRequest("execute",{"code":param1},param2,param3);
      }
      
      override public function createSocialUser(param1:Object) : SocialUser
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:SocialUser = new SocialUser();
         _loc3_.id = param1["uid"];
         _loc3_.firstName = param1["first_name"];
         _loc3_.lastName = param1["last_name"];
         _loc3_.nickName = param1["nickname"];
         _loc3_.male = param1["sex"] != 1;
         _loc3_.canPost = param1.can_post;
         _loc3_.online = param1["online"];
         _loc3_.link = protocol + "vk.com/id" + _loc3_.id;
         if(param1["city"])
         {
            if(param1["city"].hasOwnProperty("cid"))
            {
               _loc3_.city = param1["city"].cid;
            }
            else
            {
               _loc3_.city = param1["city"];
            }
         }
         else
         {
            _loc3_.city = "";
         }
         _loc3_.country = !!param1["country"]?param1["country"]:"";
         _loc3_.hasMobile = param1["has_mobile"];
         if(param1["photo"] && param1["photo"].toString().lastIndexOf("vk.com/images/") != -1)
         {
            param1["photo"] = null;
         }
         if(param1["photo_medium"] && param1["photo_medium"].toString().lastIndexOf("vk.com/images/") != -1)
         {
            param1["photo_medium"] = null;
         }
         if(param1["photo_big"] && param1["photo_big"].toString().lastIndexOf("vk.com/images/") != -1)
         {
            param1["photo_big"] = null;
         }
         if(param1["photo_max_orig"] && param1["photo_max_orig"].toString().lastIndexOf("vk.com/images/") != -1)
         {
            param1["photo_max_orig"] = null;
         }
         if(!param1["photo_medium"])
         {
            param1["photo_medium"] = param1["photo"];
         }
         if(!param1["photo_big"])
         {
            param1["photo_big"] = param1["photo_medium"];
         }
         if(!useSecure)
         {
            param1.photo && _loc5_;
            param1.photo_medium && _loc5_;
            param1.photo_big && _loc5_;
         }
         _loc3_.photos = [param1["photo"],param1["photo_medium"],param1["photo_max_orig"]];
         if(param1["bdate"])
         {
            _loc2_ = param1["bdate"].split(".");
            _loc4_ = new Date(int(_loc2_[2] == null?new Date().fullYear:_loc2_[2]),int(_loc2_[1]) - 1,int(_loc2_[0]));
            _loc3_.bdate = _loc4_.time * 0.001;
         }
         return _loc3_;
      }
      
      override public function get authentication_key() : String
      {
         if(flashVars)
         {
            return flashVars["auth_key"];
         }
         throw new Error("SocialAdapter don`t initialized");
      }
      
      override public function get initObject() : Object
      {
         if(socialInitFailed)
         {
            return {};
         }
         var _loc1_:Object = super.initObject;
         _loc1_["referrer"]["type"] = flashVars["referrer"];
         if(flashVars["referrer"] == "wall_view")
         {
            _loc1_["referrer"]["id"] = flashVars["poster_id"];
         }
         if(flashVars["user_id"].toString() != flashVars["viewer_id"].toString() && flashVars["user_id"].toString() != "0")
         {
            _loc1_["referrer"]["id"] = flashVars["user_id"];
            _loc1_["referrer"]["type"] = "invitation";
         }
         _loc1_["settings"] = PERMISSIONS;
         _loc1_["country_code"] = flashVars["country_code"];
         if(flashVars["request_key"])
         {
            _loc1_["referrer"]["type"] = flashVars["request_key"];
         }
         return _loc1_;
      }
      
      override public function loadProfiles(param1:Array, param2:Function, param3:Function = null) : void
      {
         uids = param1;
         onComplete = param2;
         onError = param3;
         ckeckArray = function(param1:Object):void
         {
            if(param1 is Array)
            {
               onComplete && onComplete(param1);
            }
            else
            {
               onComplete && onComplete([]);
            }
         };
         if(uids.length)
         {
            _sendRequest("getProfiles",{
               "uids":uids.join(),
               "fields":"sex,photo,photo_medium,photo_big,city,country,bdate,can_post"
            },ckeckArray,onError);
         }
         else
         {
            onComplete && onComplete([]);
         }
      }
      
      override public function loadUserProfile(param1:Function, param2:Function = null) : void
      {
         onComplete = param1;
         onError = param2;
         innerOnComplete = function(param1:Object):void
         {
            if(param1)
            {
               if(param1 is Array)
               {
                  onComplete(param1[0]);
               }
               else
               {
                  onComplete(param1);
               }
            }
         };
         _sendRequest("getProfiles",{
            "uids":uid,
            "fields":"sex,photo,photo_medium,photo_big,city,country,bdate"
         },innerOnComplete,onError);
      }
      
      override public function loadUserFriends(param1:Function, param2:Function = null) : void
      {
         _sendRequest("friends.get",null,param1,param2);
      }
      
      override public function loadUserGroups(param1:Function = null, param2:Function = null) : Boolean
      {
         onComplete = param1;
         onError = param2;
         arguments = arguments;
         if(super.loadUserGroups())
         {
            _sendRequest("getGroups",null,function(param1:Array):void
            {
               groups = param1;
            },onError);
            return true;
         }
         addPermissionCallback(PERMISSION_GROUPS_MASK,loadUserGroups,arguments);
         showSettingsBox(PERMISSION_GROUPS_MASK);
         return false;
      }
      
      override public function loadUserFriendsProfiles(param1:Function, param2:Function = null) : void
      {
         _sendRequest("friends.get",{"fields":"sex,photo,photo_medium,canPost"},param1,param2);
      }
      
      override public function loadUserAppFriends(param1:Function, param2:Function = null) : void
      {
         _sendRequest("friends.getAppUsers",null,param1,param2);
      }
      
      public function showSubscriptionBox(param1:Function = null, param2:Function = null, param3:String = null, param4:String = null, param5:int = 0) : Boolean
      {
         onSuccess = param1;
         onError = param2;
         item = param3;
         action = param4;
         subscriptionId = param5;
         var params:Object = {};
         if(action == "create")
         {
            params.item = item;
         }
         else
         {
            params.subscription_id = subscriptionId;
         }
         var onSubscriptionSuccess:Function = function(param1:Event):void
         {
            onSuccess && onSuccess();
         };
         var onSubscriptionFail:Function = function(param1:Event):void
         {
            onError && onError();
         };
         var clearListeners:Function = function():void
         {
            wrapper.removeEventListener("onWindowFocus",clearListeners);
            wrapper.removeEventListener("onSubscriptionSuccess",onSubscriptionSuccess);
            wrapper.removeEventListener("onSubscriptionFail",onSubscriptionFail);
            wrapper.removeEventListener("onSubscriptionFail",onSubscriptionFail);
            wrapper.removeEventListener("onSubscriptionCancel",onSubscriptionFail);
         };
         var w:APIAdapter = wrapper as APIAdapter;
         wrapper.callMethod("showSubscriptionBox",action,params);
         if(wrapper)
         {
            dispatchEvent(new Event("openSocialBox"));
            w.addEventListener("onSubscriptionSuccess",onSubscriptionSuccess);
            w.addEventListener("onSubscriptionFail",onSubscriptionFail);
            w.addEventListener("onSubscriptionCancel",onSubscriptionFail);
            w.addEventListener("onWindowFocus",clearListeners);
         }
         return true;
      }
      
      override public function showInstallBox(param1:* = null) : Boolean
      {
         settings = param1;
         if(wrapper)
         {
            dispatchEvent(new Event("openSocialBox"));
            wrapper.external.showInstallBox();
            var f:Function = function(param1:Object):void
            {
               wrapper.removeEventListener("onAplicationAdded",f);
               flashVars["is_app_user"] = 1;
               dispatchEvent(new Event("eventInstallAppComplete"));
            };
            wrapper.addEventListener("onApplicationAdded",f);
            return true;
         }
         return false;
      }
      
      override public function showSettingsBox(param1:* = null) : Boolean
      {
         if(wrapper)
         {
            dispatchEvent(new Event("openSocialBox"));
            wrapper.external.showSettingsBox(int(param1) == 0?MANDATORY_PERMISSION_MASK:param1);
            wrapper.removeEventListener("onSettingsChanged",onSettingsChanged);
            wrapper.addEventListener("onSettingsChanged",onSettingsChanged);
            return true;
         }
         return false;
      }
      
      override public function showInviteBox(param1:String = null, param2:String = null, param3:Function = null, param4:Function = null) : Boolean
      {
         if(wrapper)
         {
            dispatchEvent(new Event("openSocialBox"));
            wrapper.external.showInviteBox();
         }
         return wrapper != null;
      }
      
      override public function showPaymentBox(param1:SocialPaymentBox) : Boolean
      {
         box = param1;
         if(balance < box.socialMoney)
         {
            onBalanceChangeCallback = function():void
            {
               if(balance >= box.socialMoney)
               {
                  box.onSuccess();
               }
            };
            if(wrapper)
            {
               dispatchEvent(new Event("openSocialBox"));
               wrapper.external.showPaymentBox(box.socialMoney - balance);
            }
         }
         else
         {
            box.onSuccess();
         }
         return true;
      }
      
      override public function resizeApplication(param1:int, param2:int) : Boolean
      {
         if(CAN_RESIZE && wrapper)
         {
            wrapper && wrapper.external.resizeWindow(param1,param2);
            return true;
         }
         return false;
      }
      
      override public function wallPost(param1:SocialUser = null, param2:String = null, param3:String = null, param4:* = null, param5:String = null, param6:String = null, param7:Function = null, param8:Function = null, param9:Object = null) : Boolean
      {
         var _loc11_:* = null;
         lastWallPostArgs = null;
         if(param1 == null)
         {
            param1 = user;
         }
         if(param9 && param9.imagePostfix)
         {
            delete param9.imagePostfix;
         }
         if(super.wallPost(param1))
         {
            if(param4 is BitmapData)
            {
               _loc11_ = param4;
            }
            else if(param4 is DisplayObject && param4.width && param4.height)
            {
               _loc11_ = new BitmapData(param4.width,param4.height,true,0);
               _loc11_.draw(param4);
            }
            else
            {
               _loc11_ = new BitmapData(100,100,false,16772846);
            }
            wallPostManager_onComplete = param7;
            wallPostManager_onError = param8;
            param6 = HashModem.modulate(HashModem.softReplacement(param6));
            wallPostManager_save(null,[_loc11_],param3,param1.id,param6);
            return true;
         }
         lastWallPostArgs = arguments;
         lastWallPostArgs[0] = param1;
         addEventListener("closeSocialBox",onWallPostBoxClose);
         showSettingsBox(PERMISSION_WALL_FRIEND_MASK);
         return false;
      }
      
      public function sendRequest(param1:SocialUser = null, param2:String = null, param3:String = null, param4:Function = null, param5:Function = null, param6:Object = null) : Boolean
      {
         lastWallPostArgs = null;
         lastWallPostArgs = arguments;
         addEventListener("closeSocialBox",onWallPostBoxClose);
         request_onComplete = param4;
         request_onCancel = param5;
         if(wrapper && param1 && !param1.itsMe)
         {
            param3 = HashModem.modulate(HashModem.softReplacement(param3));
            wrapper.addEventListener("onRequestSuccess",requestSuccessHandler);
            wrapper.addEventListener("onRequestCancel",requestCancelHandler);
            wrapper.addEventListener("onRequestFail",requestErrorHandler);
            wrapper.external.callMethod("showRequestBox",param1.id,param2,param3);
            return true;
         }
         requestErrorHandler(null);
         return false;
      }
      
      public function requestErrorHandler(param1:Event) : void
      {
         request_onCancel && request_onCancel();
         request_onComplete = null;
         request_onCancel = null;
      }
      
      public function requestSuccessHandler(param1:Event) : void
      {
         request_onComplete && request_onComplete();
         request_onComplete = null;
         request_onCancel = null;
      }
      
      public function requestCancelHandler(param1:Event) : void
      {
         request_onCancel && request_onCancel();
         request_onComplete = null;
         request_onCancel = null;
      }
      
      protected function onWallPostBoxClose(param1:Event) : void
      {
         if(!lastWallPostArgs)
         {
            return;
         }
         removeEventListener("closeSocialBox",requestBoxClose);
         var _loc2_:Function = lastWallPostArgs[7];
         if(super.wallPost(lastWallPostArgs[0]))
         {
            wallPost.apply(this,lastWallPostArgs);
         }
         else if(_loc2_ != null)
         {
            _loc2_();
         }
      }
      
      protected function requestBoxClose(param1:Event) : void
      {
         requestCancelHandler(null);
      }
      
      override public function getOnlineFriends(param1:Function, param2:Function) : Boolean
      {
         _sendRequest("friends.getOnline",{},param1,param2);
         return true;
      }
      
      override public function filterNotMobileExecute(param1:Array, param2:Function, param3:Function) : void
      {
         uids = param1;
         onComplete = param2;
         onError = param3;
         if(uids)
         {
            filterNotMobileRequest(uids,function(param1:Array):void
            {
               var _loc2_:* = null;
               if(param1)
               {
                  _loc2_ = filterNotMobile(param1);
                  if(!filteredUids)
                  {
                     filteredUids = [];
                  }
                  filteredUids = filteredUids.concat(_loc2_);
                  if(uids.length > 0)
                  {
                     filterNotMobileExecute(uids,onComplete,onError);
                  }
                  else
                  {
                     onComplete && onComplete(filteredUids);
                     filteredUids = null;
                  }
               }
               else
               {
                  onComplete && onComplete(uids);
               }
            },function(param1:Object):void
            {
            });
         }
      }
      
      private function filterNotMobileRequest(param1:Array, param2:Function, param3:Function) : void
      {
         var _loc6_:int = 0;
         _loc6_ = 5;
         var _loc5_:int = 0;
         _loc5_ = 1000;
         var _loc10_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:String = "";
         var _loc7_:int = param1.length / 1000 + 1;
         if(_loc7_ > 5)
         {
            _loc7_ = 5;
         }
         _loc9_ = _loc7_ - 1;
         while(_loc9_ >= 0)
         {
            _loc8_ = param1.length - 1000;
            if(_loc8_ < 0)
            {
               _loc8_ = 0;
            }
            _loc10_ = param1.splice(_loc8_,1000);
            _loc4_ = _loc4_ + ("API.users.get({\"uids\":[" + _loc10_.toString() + "], \"fields\":\"online\"})");
            if(_loc9_ != 0)
            {
               _loc4_ = _loc4_ + ",";
            }
            _loc9_--;
         }
         _loc4_ = "return [" + _loc4_ + "];";
         execute(_loc4_,param2,param3);
      }
      
      private function filterNotMobile(param1:Array) : Array
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_] as Array;
               if(_loc6_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.length)
                  {
                     _loc3_ = _loc6_[_loc4_];
                     if(_loc3_)
                     {
                        if(_loc3_.online)
                        {
                           if(!_loc3_.online_mobile)
                           {
                              _loc2_.push(_loc3_.uid);
                           }
                        }
                     }
                     _loc4_++;
                  }
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      override public function getOnlineExecute(param1:Array, param2:Function, param3:Function) : Boolean
      {
         var _loc6_:int = 0;
         var _loc4_:String = "";
         var _loc5_:int = param1.length;
         if(_loc5_ > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = _loc4_ + ("API.friends.getOnline({\"uid\":" + param1[_loc6_] + "})");
               if(_loc6_ != _loc5_ - 1)
               {
                  _loc4_ = _loc4_ + ",";
               }
               _loc6_++;
            }
            _loc4_ = "return [" + _loc4_ + "];";
            execute(_loc4_,param2,param3);
         }
         return true;
      }
      
      public function wallPostJS(param1:SocialUser, param2:Function, param3:Function, param4:String = null, param5:* = null) : void
      {
         if(param1 == null)
         {
            param1 = user;
         }
         var _loc6_:Object = {"owner_id":param1.id};
         if(param4 == null && param5 == null)
         {
            throw new Error("Both parameters is null");
         }
         if(param4)
         {
            _loc6_["message"] = param4;
         }
         if(param5 is String)
         {
            if(param5)
            {
               _loc6_["attachment"] = param5;
            }
         }
         else if(param5 is Array)
         {
            _loc6_.attachments = param5.join(",");
         }
         dispatchEvent(new Event("openSocialBox"));
         if(wrapper)
         {
            wrapper.external.api("wall.post",_loc6_,param2,param3);
         }
         else
         {
            param3 && param3({});
         }
      }
      
      public function photoAlbumByIdPost(param1:String, param2:String = null, param3:* = null, param4:Function = null, param5:Function = null, param6:Object = null) : void
      {
         var _loc8_:* = null;
         if(PERMISSION_PHOTO)
         {
            _loc8_ = param1 + "_photoAlbumByIdPost_" + param2;
            albumCache[_loc8_] = param2;
            wallPostManager_recipient_id = param1;
            photoAlbumPost(_loc8_,null,param3,param4,param5,param6);
         }
         else
         {
            addPermissionCallback(PERMISSION_PHOTO_MASK,photoAlbumByIdPost,arguments);
         }
      }
      
      override public function photoAlbumPost(param1:String = null, param2:String = null, param3:* = null, param4:Function = null, param5:Function = null, param6:Object = null) : Boolean
      {
         albumTitle = param1;
         albumDescription = param2;
         image = param3;
         onComplete = param4;
         onError = param5;
         additionalParams = param6;
         arguments = arguments;
         var additionalParams:Object = additionalParams || {};
         if(super.photoAlbumPost())
         {
            var images:Array = null;
            var imageBmpData:BitmapData = null;
            if(image is BitmapData)
            {
               imageBmpData = image;
            }
            else if(image is DisplayObject)
            {
               imageBmpData = new BitmapData(image.width,image.height,true,0);
               imageBmpData.draw(image,null,null,null,null,true);
            }
            else if(image is Array)
            {
               images = image.slice();
            }
            else
            {
               imageBmpData = new BitmapData(100,100,false,16772846);
            }
            if(!images)
            {
               images = [imageBmpData];
            }
            wallPostManager_onComplete = onComplete;
            wallPostManager_onError = onError;
            wallPostManager_recipient_id = wallPostManager_recipient_id || "";
            wallPostManager_save({
               "title":albumTitle,
               "description":albumDescription,
               "photoDescription":additionalParams.photoDescription
            },images,"",wallPostManager_recipient_id,"");
            return true;
         }
         _onWindowFocus = function(param1:Event):void
         {
            wrapper.removeEventListener("onWindowFocus",_onWindowFocus);
            if(!PERMISSION_PHOTO)
            {
               onError && onError(param1);
            }
         };
         removeEventListener("eventPermissionChanged",onPhotoSettingChange);
         addEventListener("eventPermissionChanged",onPhotoSettingChange);
         lastPhotoArgs = arguments;
         showSettingsBox(PERMISSION_PHOTO_MASK);
         wrapper.addEventListener("onWindowFocus",_onWindowFocus);
         return false;
      }
      
      override public function photoEdit(param1:String = null, param2:String = null, param3:String = null, param4:Function = null, param5:Function = null, param6:Object = null) : Boolean
      {
         var _loc9_:* = null;
         var _loc8_:String = null;
         if(!param1 && param6 && param6.gid)
         {
            _loc8_ = param6.gid;
         }
         else if(!param1 && getPlayer())
         {
            param1 = getPlayer().id;
         }
         removePermisssionCallback(PERMISSION_PHOTO_MASK,photoEdit);
         if(super.photoEdit())
         {
            if(_loc8_)
            {
               _loc9_ = {
                  "gid":_loc8_,
                  "pid":param2,
                  "caption":param3
               };
            }
            else
            {
               _loc9_ = {
                  "uid":param1,
                  "pid":param2,
                  "caption":param3
               };
            }
            _sendRequest("photos.edit",_loc9_,param4,param5);
         }
         else
         {
            addPermissionCallback(PERMISSION_PHOTO_MASK,photoEdit,arguments);
         }
         return false;
      }
      
      override public function wallPhotoPost(param1:String = "", param2:* = null, param3:Function = null, param4:Function = null, param5:Function = null) : Boolean
      {
         message = param1;
         photo = param2;
         okCallback = param3;
         failCallback = param4;
         permissionGrantedCallback = param5;
         arguments = arguments;
         wallPostManager_wallPhoto = true;
         wallPostManager_onComplete = okCallback;
         wallPostManager_onError = failCallback;
         if(photo is Array)
         {
            wallPostManager_images = photo as Array;
         }
         else
         {
            wallPostManager_images = [photo];
         }
         wallPostManager_message = message;
         if(super.wallPhotoPost())
         {
            permissionGrantedCallback && permissionGrantedCallback();
            _sendRequest("photos.getWallUploadServer",{},function(param1:Object = null):void
            {
               wallPostManager_savePhoto(param1["upload_url"]);
            },function(param1:Object = null):void
            {
            });
            return true;
         }
         removeEventListener("eventPermissionChanged",onWallPhotoSettingChange);
         addEventListener("eventPermissionChanged",onWallPhotoSettingChange);
         lastWallPhotoPostParams = arguments;
         showSettingsBox(PERMISSION_PHOTO_MASK);
         return false;
      }
      
      private function onWallPhotoSettingChange(param1:Event) : void
      {
         wallPhotoPost.apply(this,lastWallPhotoPostParams);
         removeEventListener("eventPermissionChanged",onWallPhotoSettingChange);
      }
      
      override public function getAudioData(param1:String, param2:uint, param3:Function = null, param4:Function = null) : void
      {
         if(PERMISSION_GET_AUDIO)
         {
            _sendRequest("audio.get",{
               "uid":param1,
               "count":param2
            },param3,param4);
         }
         else
         {
            lastgetAudioParams = arguments;
            removeEventListener("eventPermissionChanged",onGetAudioPermissionChanged);
            addEventListener("eventPermissionChanged",onGetAudioPermissionChanged);
            showSettingsBox(PERMISSION_AUDIO_MASK);
            addEventListener("closeSocialBox",onWallAudioPermClose);
         }
      }
      
      public function wallGetReposts(param1:String, param2:String, param3:Function, param4:Function) : void
      {
         owner_id = param1;
         post_id = param2;
         onComplete = param3;
         onError = param4;
         _sendRequest("wall.getReposts",{
            "owner_id":owner_id,
            "post_id":post_id
         },function(param1:Object):void
         {
         },function(param1:Object):void
         {
         });
      }
      
      private function onWallAudioPermClose(param1:Event) : void
      {
         var _loc2_:* = null;
         removeEventListener("closeSocialBox",onWallAudioPermClose);
         if(!PERMISSION_GET_AUDIO)
         {
            if(lastgetAudioParams.length == 4)
            {
               _loc2_ = lastgetAudioParams[3] as Function;
               if(_loc2_ != null)
               {
                  _loc2_({"error":"permission"});
               }
            }
         }
      }
      
      private function onGetAudioPermissionChanged(param1:Event) : void
      {
         getAudioData.apply(this,lastgetAudioParams);
         removeEventListener("eventPermissionChanged",onGetAudioPermissionChanged);
      }
      
      override public function notePost(param1:String, param2:String = null, param3:Function = null, param4:Function = null) : void
      {
         if(PERMISSION_NOTES)
         {
            _sendRequest("notes.add",{
               "title":param1,
               "text":param2
            },param3,param4);
         }
         else
         {
            lastNotepostParams = arguments;
            removeEventListener("eventPermissionChanged",onNoteSettingChange);
            addEventListener("eventPermissionChanged",onNoteSettingChange);
            showSettingsBox(PERMISSION_NOTES_MASK);
         }
      }
      
      private function onNoteSettingChange(param1:Event) : void
      {
         notePost.apply(this,lastNotepostParams);
         removeEventListener("eventPermissionChanged",onNoteSettingChange);
      }
      
      private function onPhotoSettingChange(param1:Event) : void
      {
         photoAlbumPost.apply(this,lastPhotoArgs);
         removeEventListener("eventPermissionChanged",onPhotoSettingChange);
      }
      
      override public function setStatus(param1:String, param2:Function, param3:Function, param4:String = null, param5:String = null) : void
      {
         wallPostJS(null,param2,param3,param1);
      }
      
      private function onStatusSettingChange(param1:Event) : void
      {
         setStatus.apply(this,lastStatusArgs);
         removeEventListener("eventPermissionChanged",onStatusSettingChange);
      }
      
      override protected function _isAppUser() : Boolean
      {
         return flashVars["is_app_user"] == 1;
      }
      
      override protected function _startInitLoading() : void
      {
         if(flashVars["api_result"] != null && flashVars["api_result"] != "")
         {
            _initData = JSON.parse(flashVars["api_result"]).response;
         }
         if(_initData.user == null)
         {
            forExecution.push("\"user\":API.getProfiles({\"uids\":" + uid + ",\"fields\":\"can_post,uid,first_name,last_name,nickname,sex,bdate,photo,photo_medium,photo_big,has_mobile,rate,city,country,photo_max_orig\"})");
         }
         else
         {
            _initData.user = _initData.user[0];
         }
         if(_initData.friends == null)
         {
            forExecution.push("\"friends\":API.friends.get({\"count\" : 500, \"fields\":\"uid,first_name,last_name,photo,photo_medium,photo_big,sex,can_post,bdate,online,photo_max_orig\"})");
         }
         if(_initData.appFriends == null)
         {
            forExecution.push("\"appFriends\":API.getAppFriends()");
         }
         if(_initData.groups == null)
         {
            forExecution.push("\"groups\":API.getGroups()");
         }
         if(forExecution.length)
         {
            execute("return{" + forExecution.join() + "};",onInitExecutionComplete,onInitExecutionError);
         }
         else
         {
            _checkInitLoadingCompletion();
         }
      }
      
      protected function onInitExecutionComplete(param1:Object) : void
      {
         if(param1.user != null)
         {
            _initData.user = param1.user[0];
         }
         _initData.friends = param1.friends is Array?param1.friends as Array:[];
         _initData.appFriends = param1.appFriends is Array?param1.appFriends as Array:[];
         if(param1.balance != null)
         {
            _balance = param1.balance * 0.01;
         }
         if(param1.groups != null)
         {
            _initData.groups = param1.groups is Array?param1.groups as Array:[];
         }
         _checkInitLoadingCompletion();
         forExecution = null;
      }
      
      protected function onInitExecutionError(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:String = "error";
         try
         {
            _loc2_ = param1.error.error_msg;
         }
         catch(error:Error)
         {
         }
         if(SocialAdapterConfig.loadOnApiError)
         {
            _loc3_ = {};
            _loc3_.uid = flashVars.viewer_id;
            _loc3_.first_name = "";
            _loc3_.last_name = "";
            _loc3_.nickname = "";
            _initData.user = _loc3_;
            _initData.friends = [];
            _initData.appFriends = [];
            _initData.balance = 0;
            _initData.groups = [];
            _checkInitLoadingCompletion();
         }
      }
      
      override protected function _getApiUrl(param1:String, param2:Object = null) : String
      {
         return !!flashVars["api_url"]?flashVars["api_url"]:protocol + "api.vkontakte.ru/api.php";
      }
      
      override protected function _getUrlVariables(param1:String) : URLVariables
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["method"] = param1;
         _loc2_["api_id"] = flashVars["api_id"];
         _loc2_["format"] = "JSON";
         _loc2_["v"] = "3.0";
         return _loc2_;
      }
      
      override protected function _createSignature(param1:Object) : void
      {
         var _loc2_:String = "";
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc4_ in param1)
         {
            _loc3_.push(_loc4_ + "=" + param1[_loc4_]);
         }
         _loc3_.sort(VectorUtil.sortString);
         var _loc8_:int = 0;
         var _loc7_:* = _loc3_;
         for(_loc4_ in _loc3_)
         {
            _loc2_ = _loc2_ + _loc3_[_loc4_];
         }
         param1["sig"] = MD5.hash(flashVars["viewer_id"] + _loc2_ + flashVars["secret"]);
         param1["sid"] = flashVars["sid"];
      }
      
      override protected function _sendRequest(param1:String, param2:Object = null, param3:Function = null, param4:Function = null, param5:Boolean = false) : void
      {
         var _loc9_:* = NaN;
         _loc9_ = 1.2;
         var _loc8_:* = null;
         var _loc7_:Number = getTimer();
         var _loc10_:int = _loc7_ * 0.001;
         if(_loc10_ > lastRequestSecond)
         {
            lastRequestSecond = _loc10_;
            lastRequestCounter = 0;
         }
         else
         {
            lastRequestCounter = Number(lastRequestCounter) + 1;
         }
         if(lastRequestCounter > 2 || _loc7_ - lastRequestTime < 200 * 1.2)
         {
            if(sendRequestTimer == null)
            {
               sendRequestTimer = new Timer(400 * 1.2);
               sendRequestTimer.addEventListener("timer",onSendRequestTimer);
            }
            _loc8_ = arguments;
            pendingRequests.push({
               "args":_loc8_,
               "time":_loc10_
            });
            if(sendRequestTimer.running)
            {
               lastRequestFailed = true;
            }
            else
            {
               sendRequestTimer.start();
            }
            return;
         }
         lastRequestTime = _loc7_;
         if(useSecure)
         {
            if(param2 == null)
            {
               param2 = {};
            }
            param2.https = 1;
         }
         super._sendRequest(param1,param2,param3,param4,param5);
      }
      
      private function onSendRequestTimer(param1:Event) : void
      {
         var _loc2_:* = null;
         lastRequestFailed = false;
         if(pendingRequests.length)
         {
            _loc2_ = pendingRequests.shift();
            _sendRequest.apply(this,_loc2_.args);
            if(lastRequestFailed)
            {
               if(pendingRequests[pendingRequests.length - 1] == _loc2_)
               {
                  pendingRequests.unshift(pendingRequests.pop());
               }
            }
         }
         if(pendingRequests.length == 0)
         {
            sendRequestTimer.stop();
         }
      }
      
      override protected function _responseHandler(param1:String, param2:Function, param3:Function) : Boolean
      {
         var _loc4_:* = null;
         if(super._responseHandler(param1,param2,param3))
         {
            _loc4_ = _safetyJSONDecode(param1,param3);
            if(_loc4_)
            {
               if(_loc4_.error)
               {
                  if(_loc4_.error.hasOwnProperty("error_code"))
                  {
                     var _loc5_:* = _loc4_.error.error_code;
                     if(3 !== _loc5_)
                     {
                        if(4 !== _loc5_)
                        {
                           if(6 !== _loc5_)
                           {
                              if(9 === _loc5_)
                              {
                                 dispatchEvent(new Event("eventFloodError"));
                              }
                           }
                           else
                           {
                              lastRequestCounter = lastRequestCounter + 10;
                           }
                        }
                     }
                     dispatchEvent(new Event("eventAuthorizationError"));
                  }
                  param3 && param3(_loc4_);
                  logError();
               }
               else
               {
                  param2 && param2(!!_loc4_?_loc4_.response:null);
                  return true;
               }
            }
            else
            {
               logError(null,"{\"text\":\"" + escape(param1) + "\"}");
            }
         }
         return false;
      }
      
      protected function repeatRequest() : void
      {
      }
      
      protected function onSettingsChanged(param1:Object) : void
      {
         wrapper.removeEventListener("onApplicationAdded",onSettingsChanged);
         PERMISSIONS = param1.settings;
         flashVars["api_settings"] = param1.settings;
         dispatchEvent(new Event("eventPermissionChanged"));
      }
      
      protected function onBalanceChanged(param1:Object) : void
      {
         _balance = param1.balance * 0.01;
         dispatchEvent(new Event("onBalanceChanged"));
         if(onBalanceChangeCallback != null)
         {
            onBalanceChangeCallback && onBalanceChangeCallback();
            onBalanceChangeCallback = null;
         }
         else
         {
            defaultBalanceChangedCallback && defaultBalanceChangedCallback();
         }
      }
      
      protected function wallPostManager_save(param1:Object, param2:Array, param3:String, param4:String, param5:String) : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         if(wallPostManager_images && wallPostManager_images != param2)
         {
            _loc6_ = wallPostManager_images.length;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc7_ = wallPostManager_images[_loc8_];
               if(_loc7_)
               {
                  _loc7_.dispose();
               }
               _loc8_++;
            }
         }
         wallPostManager_album = param1;
         wallPostManager_images = param2;
         wallPostManager_message = param3;
         wallPostManager_recipient_id = param4;
         wallPostManager_post_id = param5;
         if(param1)
         {
            param1.privacy = 0;
            param1.comment_privacy = 0;
            if(albumCache[param1.title])
            {
               wallPostManager_album.aid = albumCache[param1.title];
               wallPostManager_getPhotoUploadServer();
            }
            else
            {
               wallPostManager_getAlbums();
            }
         }
         else
         {
            wallPostManager_getPhotoUploadServer();
         }
      }
      
      protected function wallPostManagerOnError(param1:Object = null) : void
      {
         wallPostManager_photoAlbumPostResponse = [];
         albumCache = new Dictionary(true);
         wallPostManager_onError && wallPostManager_onError(param1);
         wallPostManager_onError = null;
      }
      
      protected function wallPostManager_getNotes() : void
      {
         if(!PERMISSION_WALL_USER)
         {
         }
      }
      
      protected function wallPostManager_getAlbums() : void
      {
         _sendRequest("photos.getAlbums",null,function(param1:Object):void
         {
            wallPostManager_albums = param1 as Array;
            if(wallPostManager_albums)
            {
               if(wallPostManager_album)
               {
                  var _loc4_:int = 0;
                  var _loc3_:* = wallPostManager_albums;
                  for each(var _loc2_ in wallPostManager_albums)
                  {
                     if(_loc2_.title == wallPostManager_album.title)
                     {
                        albumCache[wallPostManager_album.title] = _loc2_.aid;
                        wallPostManager_album.aid = _loc2_.aid;
                        break;
                     }
                  }
                  if(!wallPostManager_album.aid)
                  {
                     wallPostManager_createAlbum(wallPostManager_album);
                     return;
                  }
               }
               wallPostManager_getPhotoUploadServer();
               return;
            }
            wallPostManager_createAlbum(wallPostManager_album);
         },function(param1:Object):void
         {
            wallPostManagerOnError();
         });
      }
      
      protected function wallPostManager_createAlbum(param1:Object) : void
      {
         album = param1;
         _sendRequest("photos.createAlbum",album,function(param1:Object):void
         {
            if(param1.hasOwnProperty("aid"))
            {
               if(wallPostManager_album)
               {
                  if(wallPostManager_albums)
                  {
                     wallPostManager_albums.push(param1);
                  }
                  albumCache[wallPostManager_album.title] = param1.aid;
                  wallPostManager_album.aid = param1.aid;
               }
               wallPostManager_getPhotoUploadServer();
               return;
            }
            albumCache = new Dictionary(true);
            wallPostManagerOnError();
         },function(param1:Object):void
         {
            albumCache = new Dictionary(true);
            wallPostManagerOnError();
         });
      }
      
      private function wallPostManager_getPhotoUploadServer() : void
      {
         if(wallPostManager_recipient_id && wallPostManager_recipient_id.toString().indexOf("-") == 0)
         {
            wallPostManager_album.gid = wallPostManager_recipient_id.substr(1);
         }
         _sendRequest(!!wallPostManager_album?"photos.getUploadServer":"wall.getPhotoUploadServer",wallPostManager_album,function(param1:Object):void
         {
            if(param1.hasOwnProperty("upload_url"))
            {
               wallPostManager_savePhoto(param1["upload_url"]);
               return;
            }
            wallPostManagerOnError();
         },function(param1:Object):void
         {
            wallPostManagerOnError(param1);
         });
      }
      
      protected function getMultiUploadURLRequest(param1:Array) : URLRequest
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:URLRequestHeader = new URLRequestHeader("Content-type","multipart/form-data; boundary=abc");
         var _loc5_:int = param1.length;
         if(!wallPostManager_album)
         {
            _loc5_ = 1;
         }
         var _loc6_:ByteArray = new ByteArray();
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc2_ = !!wallPostManager_album?"file" + (_loc9_ + 1):"photo";
            _loc7_ = param1[_loc9_];
            if(_loc7_)
            {
               _loc3_ = new JPGEncoder(90).encode(_loc7_);
               _loc6_.writeUTFBytes("--abc\r\nContent-Disposition: form-data; name=\"" + _loc2_ + "\"; filename=\"post" + (_loc9_ + 1) + ".jpg\"\r\nContent-Type: image/jpeg\r\n\r\n");
               _loc6_.writeBytes(_loc3_);
               if(_loc9_ == _loc5_ - 1)
               {
                  _loc6_.writeUTFBytes("\r\n--abc--\r\n");
               }
               else
               {
                  _loc6_.writeUTFBytes("\r\n--abc\r\n");
               }
            }
            _loc9_++;
         }
         var _loc4_:URLRequest = new URLRequest();
         _loc4_.requestHeaders.push(_loc8_);
         _loc4_.method = "POST";
         _loc4_.data = _loc6_;
         return _loc4_;
      }
      
      protected function wallPostManager_savePhoto(param1:String) : void
      {
         upload_url = param1;
         var request:URLRequest = getMultiUploadURLRequest(wallPostManager_images.splice(0,5));
         request.url = upload_url;
         var saver:URLLoader = new URLLoader();
         saver.addEventListener("complete",wallPostManager_onSavePhotoComplete);
         saver.addEventListener("ioError",function(param1:Object):void
         {
            wallPostManagerOnError();
         });
         saver.load(request);
      }
      
      protected function wallPostManager_onSavePhotoComplete(param1:Event) : void
      {
         e = param1;
         var target:URLLoader = e.target as URLLoader;
         target.removeEventListener("complete",wallPostManager_onSavePhotoComplete);
         var response:Object = JSON.parse(String(target.data));
         if(wallPostManager_wallPhoto)
         {
            if(response.hasOwnProperty("hash") && response.hasOwnProperty("photo") && response.hasOwnProperty("server"))
            {
               _sendRequest("photos.saveWallPhoto",{
                  "server":response.server,
                  "photo":response.photo,
                  "hash":response.hash
               },wallPostManager_wallPhotoSaveComplete,function(param1:Object):void
               {
                  albumCache = new Dictionary(true);
                  wallPostManagerOnError();
               });
            }
            return;
         }
         if(wallPostManager_album)
         {
            if(response.hasOwnProperty("aid") && response.hasOwnProperty("server") && response.hasOwnProperty("photos_list") && response.hasOwnProperty("hash"))
            {
               if(String(response["photos_list"]).length > 0)
               {
                  var saveObj:Object = {
                     "aid":response.aid,
                     "server":response.server,
                     "photos_list":response.photos_list,
                     "hash":response.hash
                  };
                  if(wallPostManager_album && wallPostManager_album.gid)
                  {
                     saveObj.gid = wallPostManager_album.gid;
                  }
                  _sendRequest("photos.save",saveObj,wallPostManager_albumPhotoSaveComplete,function(param1:Object):void
                  {
                     albumCache = new Dictionary(true);
                     wallPostManagerOnError();
                  });
                  return;
               }
            }
         }
         else if(wallPostManager_album == null)
         {
            wallPostManager_albumPhotoSaveComplete([response]);
            return;
         }
         wallPostManagerOnError();
      }
      
      private function wallPostManager_wallPhotoSaveComplete(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1 is Array && param1[0])
         {
            _loc2_ = param1[0].id;
            wallPostJS(null,wallPostManager_onComplete,wallPostManager_onError,wallPostManager_message,_loc2_);
         }
         else
         {
            wallPostManagerOnError();
         }
      }
      
      private function wallPostManager_albumPhotoSaveComplete(param1:Array) : void
      {
         e = param1;
         wallPostManager_photoAlbumPostResponse = wallPostManager_photoAlbumPostResponse || [];
         var response:Object = e[0];
         if(wallPostManager_album)
         {
            wallPostManager_album["src"] = response["src_big"];
            dispatchEvent(new Event("connect"));
         }
         if(response.hasOwnProperty("server") && response.hasOwnProperty("photo") && response.hasOwnProperty("hash"))
         {
            if(String(response["photo"]).length > 0)
            {
               var request:Object = {
                  "server":response.server,
                  "photo":response.photo,
                  "hash":response.hash
               };
               request.message = wallPostManager_message;
               request.wall_id = wallPostManager_recipient_id;
               request.post_id = wallPostManager_post_id;
               _sendRequest("wall.savePost",request,wallPostManager_onSavePostComplete,function(param1:Object):void
               {
                  wallPostManagerOnError();
               });
            }
         }
         else
         {
            if(wallPostManager_images.length)
            {
               wallPostManager_photoAlbumPostResponse = wallPostManager_photoAlbumPostResponse.concat(e);
               wallPostManager_getPhotoUploadServer();
               return;
            }
            if(response.hasOwnProperty("pid") && response.hasOwnProperty("aid") && response.hasOwnProperty("owner_id"))
            {
               if(e.length > 1 || wallPostManager_photoAlbumPostResponse.length)
               {
                  wallPostManager_photoAlbumPostResponse = wallPostManager_photoAlbumPostResponse.concat(e);
                  wallPostManager_onComplete && wallPostManager_onComplete(wallPostManager_photoAlbumPostResponse);
                  wallPostManager_photoAlbumPostResponse = null;
               }
               else
               {
                  wallPostManager_onComplete && wallPostManager_onComplete(response);
               }
               wallPostManager_photoAlbumPostResponse = null;
            }
            else
            {
               wallPostManagerOnError();
            }
         }
      }
      
      protected function wallPostManager_onSavePostComplete(param1:Object) : void
      {
         if(wrapper)
         {
            wrapper.addEventListener("onWallPostSave",wallPostManager_onWallPostSave);
            wrapper.addEventListener("onWallPostCancel",wallPostManager_onWallPostCancel);
            wrapper.external.saveWallPost(param1.post_hash);
            return;
         }
         wallPostManagerOnError();
      }
      
      protected function wallPostManager_onWallPostSave(param1:Object) : void
      {
         wrapper.removeEventListener("onWallPostSave",wallPostManager_onWallPostSave);
         wrapper.removeEventListener("onWallPostCancel",wallPostManager_onWallPostCancel);
         wallPostManager_onError = null;
      }
      
      protected function wallPostManager_onWallPostCancel(param1:Object) : void
      {
         wrapper.removeEventListener("onWallPostSave",wallPostManager_onWallPostSave);
         wrapper.removeEventListener("onWallPostCancel",wallPostManager_onWallPostCancel);
         wallPostManagerOnError();
      }
      
      override protected function _getLogUrlVariables() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["app_id"] = app_id;
         _loc1_["user_id"] = flashVars["viewer_id"];
         _loc1_["url"] = _getApiUrl(null);
         return _loc1_;
      }
      
      protected function onWindowFocus(param1:Event) : void
      {
         dispatchEvent(new Event("closeSocialBox"));
      }
      
      protected function addPermissionCallback(param1:int, param2:Function, param3:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = permissionCallbacks.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = permissionCallbacks[_loc6_];
            if(_loc5_.func == param2 && _loc5_.permission == param1)
            {
               _loc5_.arguments = param3;
               return;
            }
            _loc6_++;
         }
         _loc5_ = new PermissionCallback({
            "permission":param1,
            "func":param2,
            "arguments":param3
         },this);
         _loc5_.sa = this;
         permissionCallbacks.push(_loc5_);
         addEventListener("eventPermissionChanged",_loc5_.eventHandler);
      }
      
      protected function removePermisssionCallback(param1:int, param2:Function) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = permissionCallbacks.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = permissionCallbacks[_loc5_];
            if(_loc4_.func == param2 && _loc4_.permission == param1)
            {
               _loc4_.clear();
               permissionCallbacks.splice(_loc5_,1);
               return;
            }
            _loc5_++;
         }
      }
      
      public function get balance() : Number
      {
         return _balance;
      }
      
      public function canSend() : Boolean
      {
         var _loc1_:Number = getTimer();
         var _loc2_:int = _loc1_ * 0.001;
         if(_loc2_ > lastRequestSecond)
         {
            lastRequestSecond = _loc2_ + 1;
            return true;
         }
         return false;
      }
   }
}

import com.progrestar.common.social.SocialAdapter;
import flash.events.Event;

class PermissionCallback
{
    
   
   public var arguments:Array;
   
   public var func:Function;
   
   public var permission:int;
   
   public var sa:SocialAdapter;
   
   function PermissionCallback(param1:Object, param2:SocialAdapter)
   {
      super();
      if(param1)
      {
         this.arguments = param1.arguments;
         this.func = param1.func;
         this.permission = param1.permission;
      }
      this.sa = param2;
      if(param2)
      {
         param2.addEventListener("eventPermissionChanged",eventHandler);
      }
   }
   
   public function clear() : void
   {
      if(sa)
      {
         sa.removeEventListener("eventPermissionChanged",eventHandler);
      }
      sa = null;
      func = null;
      this.arguments = null;
   }
   
   public function eventHandler(param1:Event) : void
   {
   }
}
