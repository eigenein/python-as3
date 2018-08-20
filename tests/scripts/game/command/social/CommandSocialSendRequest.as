package game.command.social
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.PlatformFacade;
   import engine.context.platform.PlatformUser;
   import engine.context.platform.social.SocialPlatformFacade;
   import engine.context.platform.social.U2URequestSendResult;
   import game.data.storage.notification.NotificationDescription;
   import game.model.GameModel;
   import game.stat.Stash;
   
   public class CommandSocialSendRequest extends PlatformCommand
   {
       
      
      private var people:Vector.<PlatformUser>;
      
      private var notification:NotificationDescription;
      
      private var _result:U2URequestSendResult;
      
      public function CommandSocialSendRequest(param1:Vector.<PlatformUser>, param2:NotificationDescription)
      {
         super();
         this.notification = param2;
         this.people = param1;
      }
      
      public function get result() : U2URequestSendResult
      {
         return _result;
      }
      
      override public function execute() : void
      {
         super.execute();
         var _loc1_:PlatformFacade = GameModel.instance.context.platformFacade;
         var _loc2_:String = Translate.translateArgs(notification.translationIdent,Translate.genderTriggerString(_loc1_.user.male));
         (_loc1_ as SocialPlatformFacade).sendRequests(people,_loc2_,_onSuccess,_onError);
      }
      
      private function _onSuccess(param1:U2URequestSendResult) : void
      {
         this._result = param1;
         Stash.stat_u2u(param1,notification.ident);
         onComplete.dispatch(this);
      }
      
      private function _onError(... rest) : void
      {
         onError.dispatch(this);
      }
   }
}
