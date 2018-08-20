package game.mediator.gui.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.arena.CommandArenaBuyBattles;
   import game.data.storage.arena.ArenaDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.refillable.ArenaBattlesRefillPopup;
   import game.view.popup.refillable.RefillPopupBase;
   
   public class ArenaBattlesRefillPopupMediator extends RefillableRefillPopupMediatorBase
   {
       
      
      private var arenaDesc:ArenaDescription;
      
      public function ArenaBattlesRefillPopupMediator(param1:Player, param2:ArenaDescription)
      {
         _notEnoughVipMessageText = Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_ARENA_BATTLES");
         this.arenaDesc = param2;
         super(param1);
         refillable = param1.refillable.getById(param2.refillableBattleId);
      }
      
      override public function action_buy() : void
      {
         var _loc1_:CommandArenaBuyBattles = GameModel.instance.actionManager.refillableArenaBattlesBuy();
         _loc1_.onClientExecute(handler_commandComplete);
      }
      
      override protected function _createPopup() : RefillPopupBase
      {
         return new ArenaBattlesRefillPopup(this);
      }
   }
}
