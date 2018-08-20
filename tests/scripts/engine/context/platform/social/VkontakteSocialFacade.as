package engine.context.platform.social
{
   import com.progrestar.common.social.VkontakteSocialAdapter;
   import engine.context.platform.PlatformUser;
   import engine.context.platform.social.posting.StoryPostParams;
   import engine.core.utils.Deferred;
   import flash.net.URLVariables;
   
   public class VkontakteSocialFacade extends SocialPlatformFacade
   {
       
      
      private var _showRequestBoxOnCompleteCB:Function;
      
      private var _showRequestBoxTarget:String;
      
      private var postToWall_currentStory:StoryPostParams;
      
      private var postToWall_onComplete:Function;
      
      public function VkontakteSocialFacade()
      {
         super();
      }
      
      override public function get network() : String
      {
         return "vkontakte";
      }
      
      override public function get gameURL() : String
      {
         return sa.networkUrlAddress + "/bestmoba";
      }
      
      override public function get urlParamsSeparator() : String
      {
         return "#";
      }
      
      override public function get canNavigateToSocialProfile() : Boolean
      {
         return true;
      }
      
      override public function getSocialProfileUrl(param1:String) : Deferred
      {
         return Deferred.resolved(sa.networkUrlAddress + "/id" + param1);
      }
      
      override protected function createReferrer() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         super.createReferrer();
         try
         {
            _loc2_ = new URLVariables(sa.flashVars.hash);
            if(_loc2_.gift_id)
            {
               referrer.gift_id = _loc2_.gift_id;
            }
            if(_loc2_._admitad_uid)
            {
               VKSocialFacadeHelper.admitad_uid = _loc2_._admitad_uid;
               try
               {
                  _loc1_ = referrer.type;
                  _loc1_ = _loc1_.slice("ad_hh_vk_admitad_-.".length);
                  _loc1_ = _loc1_.slice(0,-2);
                  VKSocialFacadeHelper.admitad_publisher_id = _loc1_;
               }
               catch(error:Error)
               {
               }
            }
            if(_loc2_._agdvf_id)
            {
               VKSocialFacadeHelper._agdvf_id = _loc2_._agdvf_id;
            }
            if(_loc2_.replay_id)
            {
               referrer.replay_id = _loc2_["replay_id"];
            }
            if(_loc2_["test_battle_setup"])
            {
               referrer.test_battle_setup = _loc2_["test_battle_setup"];
            }
            return;
         }
         catch(e:*)
         {
            return;
         }
      }
      
      public function showSubscriptionBox(param1:Function, param2:Function, param3:String, param4:String, param5:int) : void
      {
         (sa as VkontakteSocialAdapter).showSubscriptionBox(param1,param2,param3,param4,param5);
      }
      
      override public function sendRequests(param1:Vector.<PlatformUser>, param2:String, param3:Function, param4:Function) : void
      {
         super.sendRequests(param1,param2,param3,param4);
         _showRequestBoxTarget = param1[0].id;
         _showRequestBoxOnCompleteCB = param3;
         (sa as VkontakteSocialAdapter).sendRequest(sa.getUserById(param1[0].id),param2,null,handler_showRequestBoxOnComplete,param4);
      }
      
      override public function showInviteBox(param1:Function = null) : void
      {
         sa.showInviteBox();
      }
      
      override public function fetchFriends() : void
      {
         super.fetchFriends();
         var _loc3_:int = 0;
         var _loc2_:* = friends;
         for each(var _loc1_ in friends)
         {
            _loc1_.photoURL = !!_loc1_.photoURL?_loc1_.photoURL.replace("https","http"):null;
         }
      }
      
      override public function postToWall(param1:StoryPostParams, param2:Function = null) : void
      {
         this.postToWall_currentStory = param1;
         this.postToWall_onComplete = param2;
         var _loc3_:VkontakteSocialAdapter = sa as VkontakteSocialAdapter;
         var _loc5_:String = "Хроники Хаоса > > > " + _loc3_.networkUrlAddress + "/bestmoba" + "?ad_id=p_" + param1.ident;
         var _loc4_:String = param1.image + "," + _loc5_;
         var _loc6_:String = param1.actionDescription + "\n" + _loc5_;
         _loc3_.wallPostJS(null,handler_wallPostSuccess,handler_wallPostFail,_loc6_,_loc4_);
      }
      
      private function handler_wallPostSuccess(... rest) : void
      {
         var _loc2_:StoryPostResult = new StoryPostResult();
         _loc2_.story = postToWall_currentStory.ident;
         if(postToWall_onComplete)
         {
            postToWall_onComplete(_loc2_);
         }
         postToWall_currentStory = null;
         postToWall_onComplete = null;
      }
      
      private function handler_wallPostFail(param1:Object) : void
      {
         var _loc2_:StoryPostResult = new StoryPostResult();
         _loc2_.story = postToWall_currentStory.ident;
         _loc2_.code = param1.error_code;
         _loc2_.message = param1.error_msg;
         if(postToWall_onComplete)
         {
            postToWall_onComplete(_loc2_);
         }
         postToWall_currentStory = null;
         postToWall_onComplete = null;
      }
      
      private function handler_showRequestBoxOnComplete(... rest) : void
      {
         var _loc2_:* = null;
         if(_showRequestBoxOnCompleteCB)
         {
            _loc2_ = new U2URequestSendResult();
            _loc2_.uids.push(_showRequestBoxTarget);
            _showRequestBoxOnCompleteCB(_loc2_);
            _showRequestBoxOnCompleteCB = null;
         }
      }
   }
}
