package engine.context.platform.social
{
   import com.progrestar.common.social.SocialAdapter;
   import com.progrestar.common.social.SocialUser;
   import com.progrestar.common.social.datavalue.SocialPaymentBox;
   import engine.context.platform.PlatformFacade;
   import engine.context.platform.PlatformFacadeReferrerInfo;
   import engine.context.platform.PlatformUser;
   import engine.context.platform.social.posting.StoryPostParams;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class SocialPlatformFacade extends PlatformFacade
   {
       
      
      protected var sa:SocialAdapter;
      
      protected var friends:Dictionary;
      
      public function SocialPlatformFacade()
      {
         super();
         friends = new Dictionary();
         sa = SocialAdapter.instance;
         createUser();
         fetchFriends();
         createReferrer();
      }
      
      override public function get app_id() : String
      {
         return sa.app_id;
      }
      
      override public function get auth_key() : String
      {
         return sa.authentication_key;
      }
      
      override public function get session_key() : String
      {
         return sa.session_key;
      }
      
      override public function get userId() : String
      {
         return sa.uid;
      }
      
      public function fetchFriends() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         _loc4_ = null;
         appFriends = new Vector.<PlatformUser>();
         notAppFriends = new Vector.<PlatformUser>();
         var _loc1_:Array = sa.getAppFriendsList();
         var _loc3_:int = _loc1_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc1_[_loc5_];
            _loc4_ = createPlatformUser(_loc2_);
            appFriends[_loc5_] = _loc4_;
            friends[_loc4_.id] = _loc4_;
            _loc5_++;
         }
         _loc1_ = sa.getNotAppFriendsList();
         _loc3_ = _loc1_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc1_[_loc5_];
            _loc4_ = createPlatformUser(_loc2_);
            notAppFriends[_loc5_] = _loc4_;
            friends[_loc4_.id] = _loc4_;
            _loc5_++;
         }
      }
      
      override public function getPlatformUserById(param1:String) : PlatformUser
      {
         return friends[param1];
      }
      
      public function showPaymentBox(param1:SocialPaymentBox) : void
      {
         sa.showPaymentBox(param1);
      }
      
      public function sendRequests(param1:Vector.<PlatformUser>, param2:String, param3:Function, param4:Function) : void
      {
         sa.dispatchEvent(new Event("openSocialBox"));
      }
      
      public function postToWall(param1:StoryPostParams, param2:Function = null) : void
      {
      }
      
      public function showInviteBox(param1:Function = null) : void
      {
      }
      
      protected function createPlatformUser(param1:SocialUser) : PlatformUser
      {
         var _loc3_:PlatformUser = new PlatformUser();
         _loc3_.photoURL = param1.photos[1];
         _loc3_.id = param1.id;
         _loc3_.firstName = param1.firstName;
         _loc3_.lastName = param1.lastName;
         _loc3_.male = param1.male;
         var _loc2_:Date = new Date(param1.bdate * 1000);
         _loc3_.birthDate = _loc2_.getFullYear() + "-" + (_loc2_.getMonth() + 1) + "-" + _loc2_.getDate();
         return _loc3_;
      }
      
      protected function createUser() : void
      {
         _user = createPlatformUser(sa.getPlayer());
      }
      
      protected function createReferrer() : void
      {
         _referrer = new PlatformFacadeReferrerInfo();
         _referrer.id = sa.initObject.referrer.id;
         _referrer.type = sa.initObject.referrer.type;
      }
   }
}
