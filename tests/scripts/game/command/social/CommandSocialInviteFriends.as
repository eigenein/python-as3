package game.command.social
{
   import engine.context.platform.social.SocialPlatformFacade;
   import engine.context.platform.social.U2URequestSendResult;
   import game.model.GameModel;
   import game.stat.Stash;
   
   public class CommandSocialInviteFriends extends PlatformCommand
   {
       
      
      public function CommandSocialInviteFriends()
      {
         super();
      }
      
      override public function execute() : void
      {
         super.execute();
         (GameModel.instance.context.platformFacade as SocialPlatformFacade).showInviteBox(handler_onComplete);
      }
      
      private function handler_onComplete(param1:U2URequestSendResult) : void
      {
         Stash.stat_u2u(param1);
      }
   }
}
