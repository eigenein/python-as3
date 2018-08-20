package game.mechanics.titan_arena.mediator
{
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mechanics.titan_arena.popup.TitanArenaEnemyPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class TitanArenaEnemyPopupMediator extends PopupMediator
   {
       
      
      private var _signal_attack:Signal;
      
      private var _enemy:PlayerTitanArenaEnemy;
      
      public function TitanArenaEnemyPopupMediator(param1:Player, param2:PlayerTitanArenaEnemy)
      {
         _signal_attack = new Signal(PlayerTitanArenaEnemy);
         super(param1);
         this._enemy = param2;
      }
      
      public function get isHeroicStage() : Boolean
      {
         return player.titanArenaData.isFinalStage;
      }
      
      public function get signal_attack() : Signal
      {
         return _signal_attack;
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return _enemy;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaEnemyPopup(this);
         return _popup;
      }
      
      public function action_attack() : void
      {
         close();
         _signal_attack.dispatch(enemy);
      }
   }
}
