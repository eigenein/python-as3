package game.mechanics.grand.mediator
{
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import game.command.rpc.grand.CommandGrandFindEnemies;
   import game.mechanics.grand.popup.GrandSelectEnemyPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class GrandSelectEnemyPopupMediator extends PopupMediator
   {
       
      
      private const _enemyList:VectorPropertyWriteable = new VectorPropertyWriteable();
      
      public const enemyList:VectorProperty = _enemyList;
      
      public const signal_enemySelected:Signal = new Signal(PlayerArenaEnemy);
      
      public function GrandSelectEnemyPopupMediator(param1:Player)
      {
         super(param1);
         _enemyList.value = param1.grand.getEnemies() as Vector.<*>;
         param1.grand.onEnemiesUpdate.add(handler_enemiesUpdate);
         var _loc2_:CommandGrandFindEnemies = new CommandGrandFindEnemies();
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new GrandSelectEnemyPopup(this);
         return _popup;
      }
      
      public function action_refresh() : void
      {
         var _loc1_:CommandGrandFindEnemies = new CommandGrandFindEnemies();
         GameModel.instance.actionManager.executeRPCCommand(_loc1_);
      }
      
      public function action_select(param1:PlayerArenaEnemy) : void
      {
         signal_enemySelected.dispatch(param1);
         signal_enemySelected.clear();
         close();
      }
      
      private function handler_enemiesUpdate() : void
      {
         if(player)
         {
            _enemyList.value = player.grand.getEnemies() as Vector.<*>;
         }
      }
   }
}
