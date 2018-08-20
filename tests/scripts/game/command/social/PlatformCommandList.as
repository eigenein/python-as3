package game.command.social
{
   import engine.context.GameContext;
   import engine.context.platform.PlatformFacade;
   import engine.context.platform.PlatformUser;
   import engine.context.platform.social.posting.StoryPostParams;
   import game.command.CommandManager;
   import game.data.storage.notification.NotificationDescription;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   
   public class PlatformCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      private var platform:PlatformFacade;
      
      public function PlatformCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
         this.platform = GameContext.instance.platformFacade;
      }
      
      public function billingBuy(param1:BillingPopupValueObject) : BillingBuyCommandBase
      {
         var _loc2_:* = null;
         if(platform.isMobile)
         {
            return null;
         }
         _loc2_ = new SocialBillingBuyCommand(param1);
         commandManager.executeSocialCommand(_loc2_);
         return _loc2_;
      }
      
      public function inviteFriends() : CommandSocialInviteFriends
      {
         var _loc1_:CommandSocialInviteFriends = new CommandSocialInviteFriends();
         commandManager.executeSocialCommand(_loc1_);
         return _loc1_;
      }
      
      public function requestSend(param1:Vector.<PlatformUser>, param2:NotificationDescription) : CommandSocialSendRequest
      {
         var _loc3_:CommandSocialSendRequest = new CommandSocialSendRequest(param1,param2);
         commandManager.executeSocialCommand(_loc3_);
         return _loc3_;
      }
      
      public function storyPost(param1:StoryPostParams) : void
      {
         var _loc2_:CommandSocialStoryPost = new CommandSocialStoryPost(param1);
         commandManager.executeSocialCommand(_loc2_);
      }
      
      public function get storyPostEnabled() : Boolean
      {
         return false;
      }
      
      public function appGroupJoin() : void
      {
      }
      
      public function socialQuestFeedPost() : void
      {
      }
   }
}
