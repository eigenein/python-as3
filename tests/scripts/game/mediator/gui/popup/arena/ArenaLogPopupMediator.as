package game.mediator.gui.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.battle.controller.instant.ArenaInstantReplay;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chat.sendreplay.SendReplayPopUpMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.arena.log.ArenaLogEntryPopup;
   import game.view.popup.arena.log.ArenaLogPopup;
   import game.view.popup.statistics.BattleStatisticsPopup;
   
   public class ArenaLogPopupMediator extends PopupMediator
   {
       
      
      private var _logData:Vector.<ArenaLogEntryVOProxy>;
      
      public function ArenaLogPopupMediator(param1:Player, param2:Vector.<ArenaLogEntryVOProxy>)
      {
         super(param1);
         this._logData = param2;
      }
      
      public function get logData() : Vector.<ArenaLogEntryVOProxy>
      {
         return _logData;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArenaLogPopup(this);
         return _popup;
      }
      
      public function action_replay(param1:ArenaLogEntryVOProxy) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = param1.source.source;
         if(_loc3_)
         {
            _loc2_ = new ReplayBattleThread(_loc3_,param1.isDefensiveBattle,param1.attacker,param1.defender);
            _loc2_.commandResult = param1.source;
            _loc2_.onComplete.addOnce(onBattleEnded);
            _loc2_.run();
         }
      }
      
      public function action_showInfo(param1:ArenaLogEntryVOProxy) : void
      {
         var _loc2_:ArenaInstantReplay = new ArenaInstantReplay(param1.source.source,param1);
         _loc2_.signal_invalidReplay.add(handler_invalidReplay);
         _loc2_.signal_hasInstantReplayResult.add(handler_hasInstantReplayResult);
         _loc2_.start();
      }
      
      public function action_sendReplay(param1:ArenaLogEntryVOProxy) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.isDefensiveBattle)
         {
            if(param1.attacker)
            {
               _loc2_ = param1.attacker.nickname;
            }
            else
            {
               _loc2_ = "?";
            }
         }
         else if(param1.defender)
         {
            _loc2_ = param1.defender.nickname;
         }
         else
         {
            _loc2_ = "?";
         }
         _loc3_ = Translate.translateArgs("UI_DIALOG_ARENA_SEND_REPLAY_TEXT",_loc2_);
         new SendReplayPopUpMediator(player,param1.source.replayId,_loc3_).open(Stash.click("arena_log_send_replay",_popup.stashParams));
      }
      
      protected function onBattleEnded(param1:ArenaBattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
      
      private function handler_hasInstantReplayResult(param1:ArenaInstantReplay) : void
      {
         var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
         _loc2_.result = param1.result;
         PopUpManager.addPopUp(new BattleStatisticsPopup(_loc2_.attackerTeamStats,_loc2_.defenderTeamStats));
      }
      
      private function handler_invalidReplay(param1:ArenaInstantReplay) : void
      {
         var _loc2_:ArenaLogEntryVOProxy = param1.data as ArenaLogEntryVOProxy;
         if(_loc2_)
         {
            PopUpManager.addPopUp(new ArenaLogEntryPopup(_loc2_));
         }
         if(param1.incorrectVersionHigh)
         {
            PopupList.instance.message(Translate.translate("UI_ARENA_INCORRECT_VERSION_HIGH"));
         }
         else if(!param1.incorrectVersionLow)
         {
         }
      }
   }
}
