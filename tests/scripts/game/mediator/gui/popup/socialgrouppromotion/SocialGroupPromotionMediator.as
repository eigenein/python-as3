package game.mediator.gui.popup.socialgrouppromotion
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.global.GlobalEventController;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   
   public class SocialGroupPromotionMediator
   {
       
      
      private var player:Player;
      
      private var desc:SocialGroupPromotionDescription;
      
      private var stashParams:PopupStashEventParams;
      
      public function SocialGroupPromotionMediator(param1:Player, param2:SocialGroupPromotionDescription, param3:PopupStashEventParams = null)
      {
         super();
         this.desc = param2;
         this.player = param1;
         this.stashParams = param3;
      }
      
      public function get hoverText() : String
      {
         return desc.hoverText;
      }
      
      public function get messageText() : String
      {
         return desc.messageText;
      }
      
      public function get closeable() : Boolean
      {
         return desc.closeable;
      }
      
      public function get iconTexture() : String
      {
         return "socialNetworkIcon_" + GameModel.instance.context.platformFacade.network;
      }
      
      public function action_select(param1:PopupStashEventParams = null) : void
      {
         GlobalEventController.signal_redirect.dispatch();
         if(param1 == null)
         {
            param1 = this.stashParams;
         }
         Stash.click(desc.stashIdentBase + ":" + desc.ident,param1);
      }
      
      public function action_close() : void
      {
         if(desc.closeable)
         {
            SocialGroupPromotionSettingsUtil.setClosed(player,desc.ident);
         }
      }
   }
}
