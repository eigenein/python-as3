package game.mediator.gui.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.getTimer;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.arena.CommandArenaCheckTargetRange;
   import game.command.rpc.arena.CommandArenaFindEnemies;
   import game.command.rpc.grand.CommandGrandCheckTargetRange;
   import game.command.rpc.grand.CommandGrandFindEnemies;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.arena.PlayerArenaData;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.model.user.arena.PlayerGrandData;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class ArenaPopupAttackOutOfRangeController
   {
       
      
      private var arena:PlayerArenaData;
      
      private var stage:Stage;
      
      private var now:int;
      
      private var lastActivity:int;
      
      private var lastUpdated:int;
      
      private var selectedEnemy:PlayerArenaEnemy;
      
      private var popupToCloseIfNotAvailabe:PopupMediator;
      
      public function ArenaPopupAttackOutOfRangeController(param1:PlayerArenaData)
      {
         super();
         this.arena = param1;
         this.stage = Starling.current.stage;
         param1.onNoMoreEnemiesAvailable.add(handler_noMoreEnemiesAvailable);
         stage.addEventListener("touch",handler_touch);
         stage.addEventListener("enterFrame",handler_enterFrame);
      }
      
      public function dispose() : void
      {
         arena.onNoMoreEnemiesAvailable.remove(handler_noMoreEnemiesAvailable);
         stage.removeEventListener("touch",handler_touch);
         stage.removeEventListener("enterFrame",handler_enterFrame);
      }
      
      public function playerIsActive() : void
      {
      }
      
      public function teamGatheringStoped() : void
      {
         popupToCloseIfNotAvailabe = null;
         selectedEnemy = null;
      }
      
      public function teamGatheringStarted(param1:PlayerArenaEnemy, param2:PopupMediator) : void
      {
         selectedEnemy = param1;
         popupToCloseIfNotAvailabe = param2;
         checkTimerForUpdate();
      }
      
      public function teamGatheringActivity() : void
      {
         checkTimerForUpdate();
      }
      
      public function resetTimer() : void
      {
         lastUpdated = getTimer();
      }
      
      public function handler_attackOutOfRetagetDelta() : void
      {
         showErrorMessage();
         selectedEnemy = null;
      }
      
      protected function checkTimerForUpdate() : void
      {
         var _loc1_:int = getTimer();
         if(_loc1_ - lastUpdated > DataStorage.rule.arenaRule.arenaEnemiesExpiredDelay * 1000)
         {
            lastUpdated = _loc1_;
            requestUpdate();
         }
      }
      
      protected function requestUpdate() : void
      {
         var _loc2_:* = null;
         var _loc1_:Vector.<PlayerArenaEnemy> = arena.getEnemies();
         if(_loc1_ == null)
         {
            return;
         }
         if(arena is PlayerGrandData)
         {
            _loc2_ = new CommandGrandCheckTargetRange(_loc1_);
         }
         else
         {
            _loc2_ = new CommandArenaCheckTargetRange(_loc1_);
         }
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
         _loc2_.onClientExecute(handler_checkTargetRange);
      }
      
      protected function interruptAttack() : void
      {
         var _loc1_:* = selectedEnemy != null;
         if(popupToCloseIfNotAvailabe)
         {
            popupToCloseIfNotAvailabe.close();
         }
         selectedEnemy = null;
         if(_loc1_)
         {
            showErrorMessage();
         }
      }
      
      protected function showErrorMessage() : void
      {
         var _loc1_:String = Translate.translate("UI_DIALOG_ARENA_ENEMY_NOT_AVAILABLE_MESSAGE");
         PopupList.instance.message(_loc1_);
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         now = getTimer();
         var _loc3_:int = now - lastActivity;
         var _loc2_:int = now - lastUpdated;
         if(_loc2_ > DataStorage.rule.arenaRule.arenaEnemiesExpiredDelay * 1000 && _loc3_ < DataStorage.rule.arenaRule.arenaEnemiesPlayerInactiveDelay * 1000)
         {
            lastUpdated = now;
            requestUpdate();
         }
      }
      
      private function handler_touch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.currentTarget as DisplayObject,"hover");
         if(_loc2_)
         {
            lastActivity = now;
         }
      }
      
      protected function handler_checkTargetRange(param1:RPCCommandBase) : void
      {
         if(selectedEnemy)
         {
            if(!selectedEnemy.isAvailableByRange.value)
            {
               interruptAttack();
            }
         }
      }
      
      protected function handler_noMoreEnemiesAvailable() : void
      {
         var _loc1_:* = null;
         if(DataStorage.rule.arenaRule.arenaEnemiesRerollIfNoEnemiesAvailable)
         {
            if(arena is PlayerGrandData)
            {
               _loc1_ = new CommandGrandFindEnemies();
            }
            else
            {
               _loc1_ = new CommandArenaFindEnemies();
            }
            GameModel.instance.actionManager.executeRPCCommand(_loc1_);
         }
      }
   }
}
