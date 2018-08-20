package game.mediator.gui.popup.social
{
   import engine.context.platform.social.socialQuest.SocialQuestHelper;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.social.CommunityPromoPopup;
   
   public class CommunityPromoPopupMediator extends PopupMediator
   {
       
      
      public function CommunityPromoPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new CommunityPromoPopup(this);
         return _popup;
      }
      
      public function action_go() : void
      {
         Stash.click("group",_popup.stashParams);
         SocialQuestHelper.instance.actionHelp_navigateToGroupURL();
         close();
      }
   }
}
