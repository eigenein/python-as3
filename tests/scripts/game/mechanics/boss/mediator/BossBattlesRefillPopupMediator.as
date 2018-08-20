package game.mechanics.boss.mediator
{
   import game.mechanics.boss.model.CommandBossBuyTries;
   import game.mechanics.boss.popup.BossBattlesRefillPopup;
   import game.mediator.gui.popup.refillable.RefillableRefillPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.refillable.RefillPopupBase;
   
   public class BossBattlesRefillPopupMediator extends RefillableRefillPopupMediatorBase
   {
       
      
      public function BossBattlesRefillPopupMediator(param1:Player)
      {
         super(param1);
         refillable = param1.boss.tries;
      }
      
      override public function action_buy() : void
      {
         var _loc1_:CommandBossBuyTries = GameModel.instance.actionManager.boss.refillableBossBuyTries();
         _loc1_.onClientExecute(handler_commandComplete);
      }
      
      override protected function _createPopup() : RefillPopupBase
      {
         return new BossBattlesRefillPopup(this);
      }
   }
}
