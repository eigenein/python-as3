package game.mediator.gui.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.mission.CommandMissionBuyTries;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.mission.PlayerEliteMissionEntry;
   import game.view.popup.refillable.EliteMissionTriesRefillPopup;
   import game.view.popup.refillable.RefillPopupBase;
   
   public class EliteMissionTriesRefillPopupMediator extends RefillableRefillPopupMediatorBase
   {
       
      
      private var mission:PlayerEliteMissionEntry;
      
      public function EliteMissionTriesRefillPopupMediator(param1:Player, param2:PlayerEliteMissionEntry)
      {
         _notEnoughVipMessageText = Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_MISSION_ELITE_TRIES");
         super(param1);
         this.refillable = param2.eliteTries;
         this.mission = param2;
      }
      
      override public function action_buy() : void
      {
         var _loc1_:CommandMissionBuyTries = GameModel.instance.actionManager.mission.missionBuyEliteTries(mission);
         _loc1_.onClientExecute(handler_commandComplete);
      }
      
      override protected function _createPopup() : RefillPopupBase
      {
         return new EliteMissionTriesRefillPopup(this);
      }
   }
}
