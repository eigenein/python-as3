package engine.context.platform
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.Deferred;
   
   public class PlatformFacade
   {
       
      
      protected var _auth_key:String;
      
      protected var _userId:String;
      
      public var appFriends:Vector.<PlatformUser>;
      
      public var notAppFriends:Vector.<PlatformUser>;
      
      protected var _user:PlatformUser;
      
      protected var _referrer:PlatformFacadeReferrerInfo;
      
      protected var _network:String;
      
      protected var _gameURL:String;
      
      protected var _app_id:String;
      
      protected var _session_key:String;
      
      public function PlatformFacade()
      {
         super();
      }
      
      public function get user() : PlatformUser
      {
         return _user;
      }
      
      public function get referrer() : PlatformFacadeReferrerInfo
      {
         return _referrer;
      }
      
      public function get isMobile() : Boolean
      {
         return false;
      }
      
      public function get network() : String
      {
         return _network;
      }
      
      public function get gameURL() : String
      {
         return _gameURL;
      }
      
      public function get urlParamsSeparator() : String
      {
         return "";
      }
      
      public function get app_id() : String
      {
         return _app_id;
      }
      
      public function get session_key() : String
      {
         return _session_key;
      }
      
      public function get auth_key() : String
      {
         return _auth_key;
      }
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get canNavigateToSocialProfile() : Boolean
      {
         return false;
      }
      
      public function getSocialProfileUrl(param1:String) : Deferred
      {
         return Deferred.rejected();
      }
      
      public function getPlatformUserById(param1:String) : PlatformUser
      {
         return null;
      }
      
      public function billingCurrencyTranslate(param1:int) : String
      {
         return Translate.translateArgs("BILLING_CURRENCY_" + network.toUpperCase(),param1);
      }
      
      public function get customNetwork() : ICustomNetwork
      {
         return CustomNetworkDefault.instance;
      }
   }
}
