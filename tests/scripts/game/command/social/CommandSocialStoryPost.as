package game.command.social
{
   import engine.context.platform.PlatformFacade;
   import engine.context.platform.social.SocialPlatformFacade;
   import engine.context.platform.social.StoryPostResult;
   import engine.context.platform.social.posting.StoryPostParams;
   import game.model.GameModel;
   import game.stat.Stash;
   
   public class CommandSocialStoryPost extends PlatformCommand
   {
       
      
      private var p:StoryPostParams;
      
      public function CommandSocialStoryPost(param1:StoryPostParams)
      {
         super();
         this.p = param1;
      }
      
      public static function get AVAILABLE() : Boolean
      {
         return true;
      }
      
      override public function execute() : void
      {
         super.execute();
         var _loc1_:PlatformFacade = GameModel.instance.context.platformFacade;
         (_loc1_ as SocialPlatformFacade).postToWall(p,_onSuccess);
      }
      
      private function _onSuccess(param1:StoryPostResult) : void
      {
         if(param1)
         {
            Stash.stat_storyPost(param1);
         }
      }
   }
}
