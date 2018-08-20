package game.mediator.gui.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.refillable.CommandSkillPointsBuy;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.refillable.RefillPopupBase;
   import game.view.popup.refillable.SkillPointsRefillPopup;
   
   public class SkillPointsRefillPopupMediator extends RefillableRefillPopupMediatorBase
   {
       
      
      public function SkillPointsRefillPopupMediator(param1:Player)
      {
         _notEnoughVipMessageText = Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_SKILLPOINTS");
         super(param1);
         refillable = param1.refillable.skillpoints;
      }
      
      override public function action_buy() : void
      {
         var _loc1_:CommandSkillPointsBuy = GameModel.instance.actionManager.refillableSkillPointsBuy();
         _loc1_.onClientExecute(handler_commandComplete);
      }
      
      override protected function _createPopup() : RefillPopupBase
      {
         return new SkillPointsRefillPopup(this);
      }
   }
}
