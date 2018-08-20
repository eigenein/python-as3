package game.mediator.gui.popup.chat.responses
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.battle.controller.instant.ArenaInstantReplay;
   import game.battle.controller.thread.BattleThread;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.command.rpc.mission.CommandBattleGetReplay;
   import game.command.rpc.mission.CommandBattleStartReplay;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.mediator.gui.popup.chat.ChatPopupLogValueObject;
   import game.mediator.gui.popup.chat.sendreplay.SendReplayPopUpMediator;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.chat.ChatLogMessage;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.arena.log.ArenaLogEntryPopup;
   import game.view.popup.statistics.BattleStatisticsPopup;
   
   public class ChatChallengeResponsesPopupMediator extends PopupMediator
   {
       
      
      private var message:ChatPopupLogValueObject;
      
      private var lastBattleMessage:ChatLogMessage;
      
      public function ChatChallengeResponsesPopupMediator(param1:Player, param2:ChatPopupLogValueObject)
      {
         super(param1);
         this.message = param2;
      }
      
      public function get initiator() : UserInfo
      {
         return message.initiator;
      }
      
      public function get team() : Vector.<UnitEntryValueObject>
      {
         return message.challengeData.enemy.getTeam(0);
      }
      
      public function get timeString() : String
      {
         return message.time;
      }
      
      public function get responses() : ListCollection
      {
         return message.challengeData.responses;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ChatChallengeResponsesPopup(this);
         return new ChatChallengeResponsesPopup(this);
      }
      
      public function action_replay(param1:ChatLogMessage) : void
      {
         lastBattleMessage = param1;
         var _loc2_:CommandBattleStartReplay = new CommandBattleStartReplay(param1.replayData.replayId);
         _loc2_.signal_replayComplete.add(handler_replayComplete);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      public function action_showInfo(param1:ChatLogMessage) : void
      {
         lastBattleMessage = param1;
         var _loc2_:CommandBattleGetReplay = GameModel.instance.actionManager.mission.battleGetReplay(param1.replayData.replayId,player.id);
         _loc2_.onClientExecute(handler_showInfo_commandGetReplay);
      }
      
      private function handler_showInfo_commandGetReplay(param1:CommandBattleGetReplay) : void
      {
         var _loc2_:* = null;
         if(param1.result.body && param1.result.body.replay)
         {
            _loc2_ = new ArenaInstantReplay(param1.result.body.replay,null);
            if(message.challengeData.isTitanBattle)
            {
               _loc2_.config = DataStorage.battleConfig.titanPvp;
            }
            _loc2_.signal_invalidReplay.add(handler_invalidReplay);
            _loc2_.signal_hasInstantReplayResult.add(handler_hasInstantReplayResult);
            _loc2_.start();
         }
      }
      
      public function action_sendReplay(param1:ChatLogMessage) : void
      {
         var _loc2_:String = Translate.translate("UI_DIALOG_CHAT_REPLAY_TEXT");
         var _loc3_:SendReplayPopUpMediator = new SendReplayPopUpMediator(player,param1.replayData.replayId,_loc2_,2);
         _loc3_.open(Stash.click("chat_challenge_log_send_replay",_popup.stashParams));
      }
      
      protected function handler_replayComplete(param1:BattleThread) : void
      {
         if(lastBattleMessage && param1 && param1.battleResult.hasResult)
         {
            lastBattleMessage.replayData.battleResult.value = !!param1.battleResult.victory?1:2;
         }
      }
      
      private function handler_hasInstantReplayResult(param1:ArenaInstantReplay) : void
      {
         var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
         _loc2_.result = param1.result;
         PopUpManager.addPopUp(new BattleStatisticsPopup(_loc2_.attackerTeamStats,_loc2_.defenderTeamStats));
         if(lastBattleMessage)
         {
            lastBattleMessage.replayData.battleResult.value = !!param1.result.victory?1:2;
         }
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
