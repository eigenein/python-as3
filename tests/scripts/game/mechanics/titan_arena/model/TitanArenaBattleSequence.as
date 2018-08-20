package game.mechanics.titan_arena.model
{
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.TitanArenaBattleThread;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.titan_arena.mediator.TitanArenaBattleEndPopupMediator;
   import game.mechanics.titan_arena.mediator.TitanArenaRoundEndPopupMediator;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndBattle;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaStartBattle;
   import game.mediator.gui.popup.PopupList;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.screen.BattleScreen;
   import game.view.popup.ClipBasedPopup;
   import org.osflash.signals.Signal;
   
   public class TitanArenaBattleSequence
   {
       
      
      private var player:Player;
      
      private var enemy:PlayerTitanArenaEnemy;
      
      private var descriptionList:Vector.<UnitDescription>;
      
      private var commandEndBattle:CommandTitanArenaEndBattle;
      
      private var commandStartBattle:CommandTitanArenaStartBattle;
      
      private var _signal_complete:Signal;
      
      public function TitanArenaBattleSequence(param1:Player, param2:PlayerTitanArenaEnemy, param3:Vector.<UnitDescription>)
      {
         _signal_complete = new Signal(TitanArenaBattleSequence);
         super();
         this.player = param1;
         this.descriptionList = param3;
         this.enemy = param2;
      }
      
      public function get signal_complete() : Signal
      {
         return _signal_complete;
      }
      
      public function start() : CommandTitanArenaStartBattle
      {
         var _loc1_:CommandTitanArenaStartBattle = GameModel.instance.actionManager.titanArena.titanArenaStartBattle(enemy,descriptionList);
         _loc1_.signal_complete.add(handler_startBattleCommand);
         return _loc1_;
      }
      
      private function showRoundEndPopup() : void
      {
         var _loc2_:* = null;
         var _loc1_:TitanArenaRoundEndPopupMediator = new TitanArenaRoundEndPopupMediator(player,commandEndBattle);
         var _loc3_:BattleScreen = Game.instance.screen.getBattleScreen();
         if(_loc3_ && _loc3_.scene)
         {
            _loc2_ = _loc1_.createPopup() as ClipBasedPopup;
            _loc3_.gui.lockAndHideControlls();
            _loc3_.gui.addBattlePopup(_loc2_);
            _loc3_.scene.setBlur();
            _loc1_.signal_continue.add(handler_roundEndPopupClosed);
            _loc1_.signal_skip.add(handler_roundEndPopupSkip);
         }
         else
         {
            Game.instance.screen.hideBattle();
            _loc1_.open();
         }
      }
      
      private function showBattleEndPopup(param1:TitanArenaBattleThread = null) : void
      {
         var _loc2_:* = null;
         var _loc4_:TitanArenaBattleEndPopupMediator = new TitanArenaBattleEndPopupMediator(player,commandEndBattle,!!param1?param1.battleResult:null);
         var _loc3_:BattleScreen = Game.instance.screen.getBattleScreen();
         _loc4_.signal_closed.add(handler_sequenceCompleted);
         if(_loc3_ && _loc3_.scene)
         {
            _loc2_ = _loc4_.createPopup() as ClipBasedPopup;
            _loc3_.gui.lockAndHideControlls();
            _loc3_.gui.addBattlePopup(_loc2_);
            _loc3_.scene.setBlur();
            _loc4_.signal_closed.add(handler_battleEndClosed);
         }
         else
         {
            Game.instance.screen.hideBattle();
            _loc4_.open();
         }
      }
      
      private function handler_startBattleCommand(param1:CommandTitanArenaStartBattle) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc4_:* = null;
         this.commandStartBattle = param1;
         if(param1.startBattleError)
         {
            _loc2_ = param1.startBattleError;
            PopupList.instance.message("Battle error with ident " + _loc2_);
         }
         else
         {
            _loc3_ = param1.battle;
            if(_loc3_)
            {
               _loc4_ = new TitanArenaBattleThread(_loc3_,player.getUserInfo(),param1.enemy);
               _loc4_.onComplete.addOnce(handler_battleComplete_attack);
               _loc4_.run();
            }
         }
      }
      
      private function handler_battleComplete_attack(param1:TitanArenaBattleThread) : void
      {
         var _loc2_:CommandTitanArenaEndBattle = GameModel.instance.actionManager.titanArena.titanArenaEndBattle(param1);
         _loc2_.signal_complete.add(handler_battleEndCommandExecuted);
      }
      
      private function handler_battleEndCommandExecuted(param1:CommandTitanArenaEndBattle) : void
      {
         this.commandEndBattle = param1;
         if(!param1.success)
         {
            Game.instance.screen.hideBattle();
            return;
         }
         param1.enemy.internal_updateFromRawData(param1.result.body);
         player.titanArenaData.internal_updateOnEndBattle(param1);
         if(param1.pointsEarned_attack == param1.pointsEarned_attack_total)
         {
            showRoundEndPopup();
         }
         else
         {
            showBattleEndPopup();
         }
      }
      
      protected function handler_roundEndPopupClosed(param1:TitanArenaRoundEndPopupMediator) : void
      {
         var _loc3_:* = null;
         Game.instance.screen.hideBattle();
         var _loc2_:* = param1.cmd.defBattle;
         if(_loc2_)
         {
            _loc3_ = new TitanArenaBattleThread(_loc2_,param1.cmd.enemy,player.getUserInfo());
            _loc3_.onComplete.addOnce(handler_battleComplete_defense);
            _loc3_.onRetreat.addOnce(handler_battleComplete_defense_retreat);
            _loc3_.run();
         }
      }
      
      protected function handler_roundEndPopupSkip(param1:TitanArenaRoundEndPopupMediator) : void
      {
         Game.instance.screen.hideBattle();
         showBattleEndPopup();
      }
      
      private function handler_battleComplete_defense(param1:TitanArenaBattleThread) : void
      {
         showBattleEndPopup(param1);
      }
      
      private function handler_battleComplete_defense_retreat(param1:TitanArenaBattleThread) : void
      {
         showBattleEndPopup(param1);
      }
      
      protected function handler_battleEndClosed() : void
      {
         Game.instance.screen.hideBattle();
      }
      
      protected function handler_sequenceCompleted() : void
      {
         _signal_complete.dispatch(this);
      }
   }
}
