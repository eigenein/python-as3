package game.battle.gui
{
   import game.battle.controller.BattleController;
   import game.mediator.gui.popup.battle.BattlePauseClanWarPopupMediator;
   import game.mediator.gui.popup.battle.BattlePausePopupMediator;
   import game.view.popup.battle.BattlePausePopup;
   
   public class BattleGuiClanWarMediator extends BattleGuiMediator
   {
       
      
      public function BattleGuiClanWarMediator(param1:BattleGuiViewBase, param2:BattleController)
      {
         super(param1,param2);
      }
      
      override protected function createPausePopup() : BattlePausePopup
      {
         var _loc1_:BattlePausePopupMediator = new BattlePauseClanWarPopupMediator(controller.playerSettings,controller.isReplay);
         _loc1_.signal_continue.add(handler_pausePopupContinue);
         _loc1_.signal_retreat.add(handler_pausePopupRetreat);
         return _loc1_.createPopup() as BattlePausePopup;
      }
   }
}
