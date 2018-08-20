package com.progrestar.common.social
{
   import com.progrestar.common.social.datavalue.SocialPaymentBox;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import engine.context.platform.social.GMRSocialFacadeHelper;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import idv.cjcat.signals.Signal;
   
   public class GMRSocialAdapter extends SocialAdapter
   {
       
      
      public var signal_initProfile:Signal;
      
      private var _stage:Stage;
      
      public function GMRSocialAdapter()
      {
         signal_initProfile = new Signal();
         super();
         networkName = "T_NETWORK_GAMESMAILRU";
      }
      
      override public function get uid() : String
      {
         return flashVars["uid"];
      }
      
      override public function get authentication_key() : String
      {
         return flashVars.authentication_key;
      }
      
      override public function get app_id() : String
      {
         return flashVars.appid;
      }
      
      override public function get networkUrlAddress() : String
      {
         return "http://games.mail.ru";
      }
      
      public function get stage() : Stage
      {
         return _stage;
      }
      
      public function set stage(param1:Stage) : void
      {
         _stage = param1;
      }
      
      override public function showPaymentBox(param1:SocialPaymentBox) : Boolean
      {
         box = param1;
         paymentReceivedCallback = function(param1:Object):void
         {
            box.onSuccess();
            dispatchEvent(new Event("closeSocialBox"));
         };
         paymentCanceledCallback = function(param1:Object):void
         {
            data = param1;
            dispatchEvent(new Event("closeSocialPaymentBox"));
         };
         if(ExternalInterfaceProxy.available)
         {
            var merchantParams:Object = {
               "productId":box.code,
               "amount":box.socialMoney,
               "description":box.title
            };
            if(billingIsOneTime(box.type))
            {
               merchantParams.uniq_orderid = GMRSocialFacadeHelper.playerId + box.code;
            }
            var paymentParams:Object = {"merchant_param":merchantParams};
            ExternalInterfaceProxy.addCallback("paymentReceivedCallback",paymentReceivedCallback);
            ExternalInterfaceProxy.addCallback("paymentCanceledCallback",paymentCanceledCallback);
            ExternalInterfaceProxy.call("window.GMRExternalApi.api.paymentFrame",paymentParams);
            dispatchEvent(new Event("openSocialBox"));
            dispatchEvent(new Event("openSocialPaymentBox"));
            return true;
         }
         return false;
      }
      
      override protected function _isAppUser() : Boolean
      {
         return true;
      }
      
      override public function loadUserProfile(param1:Function, param2:Function = null) : void
      {
      }
      
      override public function init(param1:Object, param2:Function, param3:Function = null, param4:* = null) : void
      {
         param1.appid;
         var _loc5_:Object = {};
         _loc5_.uid = param1.uid;
         user = createSocialUser(_loc5_);
         user.itsMe = true;
         users[user.id] = user;
         usersIds.push(user);
         super.init(param1,param2,param3,param4);
      }
      
      override public function loadUserFriendsProfiles(param1:Function, param2:Function = null) : void
      {
      }
      
      override public function loadUserAppFriends(param1:Function, param2:Function = null) : void
      {
      }
      
      override public function createSocialUser(param1:Object) : SocialUser
      {
         var _loc2_:SocialUser = new SocialUser();
         _loc2_.id = param1["uid"];
         _loc2_.male = true;
         return _loc2_;
      }
      
      override protected function preRefresh() : void
      {
         if(ExternalInterfaceProxy.available)
         {
            ExternalInterfaceProxy.addCallback("initProfile",onInitProfile);
            ExternalInterfaceProxy.call("window.GMRExternalApi.getUserInfo");
         }
      }
      
      private function billingIsOneTime(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Array = GMRSocialFacadeHelper.oneTimeBillings;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] == param1)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function onInitProfile(param1:Object) : void
      {
         user.firstName = param1.nick;
         signal_initProfile.dispatch();
      }
   }
}
