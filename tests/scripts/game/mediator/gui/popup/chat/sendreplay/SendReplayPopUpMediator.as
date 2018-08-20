package game.mediator.gui.popup.chat.sendreplay
{
   import com.progrestar.common.lang.Translate;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.command.rpc.mission.CommandBattleGetReplay;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.view.popup.PopupBase;
   
   public class SendReplayPopUpMediator extends PopupMediator
   {
      
      public static const SHARE_TYPE_CHAT:int = 1;
      
      public static const SHARE_TYPE_URL:int = 2;
      
      public static const SHARE_TYPE_BOTH:int = 3;
       
      
      private var replayID:String;
      
      private var shareType:int;
      
      private var _defauiltText:String;
      
      public function SendReplayPopUpMediator(param1:Player, param2:String, param3:String, param4:int = 3)
      {
         super(param1);
         this.replayID = param2;
         _defauiltText = param3;
         this.shareType = param4;
      }
      
      public function get defauiltText() : String
      {
         return _defauiltText;
      }
      
      public function get replayURL() : String
      {
         return GameModel.instance.context.platformFacade.gameURL + GameModel.instance.context.platformFacade.urlParamsSeparator + "replay_id" + "=" + replayID;
      }
      
      public function get playerClan() : *
      {
         return GameModel.instance.player.clan.clan;
      }
      
      public function get canShareChat() : Boolean
      {
         return playerClan && (shareType & 1) != 0;
      }
      
      public function get canShareUrl() : Boolean
      {
         return (shareType | 2) != 0;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SendReplayPopUp(this);
         return _popup;
      }
      
      public function replay() : void
      {
         var _loc1_:CommandBattleGetReplay = GameModel.instance.actionManager.mission.battleGetReplay(replayID,player.id);
         _loc1_.onClientExecute(onGetBattleReplay);
      }
      
      public function sendReplay(param1:String) : void
      {
         var _loc2_:int = 0;
         if(param1.length <= DataStorage.rule.chatRule.maxMessageLength)
         {
            _loc2_ = GameTimer.instance.currentServerTime - player.chat.lastMessageTime;
            if(_loc2_ > DataStorage.rule.chatRule.minTimeoutSeconds)
            {
               GameModel.instance.actionManager.chat.chatSendReplay("clan",replayID,param1);
               close();
            }
            else
            {
               PopupList.instance.message(Translate.translateArgs("UI_POPUP_CHAT_MESSAGE_TIMEOUT",DataStorage.rule.chatRule.minTimeoutSeconds));
            }
         }
         else
         {
            PopupList.instance.message(Translate.translateArgs("UI_POPUP_CHAT_MESSAGE_LENGHT",DataStorage.rule.chatRule.minMessageLength,DataStorage.rule.chatRule.maxMessageLength));
            close();
         }
      }
      
      private function onGetBattleReplay(param1:CommandBattleGetReplay) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = false;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc9_:* = null;
         var _loc3_:* = null;
         if(param1.result.body && param1.result.body.replay)
         {
            _loc6_ = param1.result.body.replay.typeId;
            _loc2_ = param1.playerId == _loc6_;
            _loc8_ = {};
            var _loc11_:int = 0;
            var _loc10_:* = param1.result.body.users;
            for each(var _loc7_ in param1.result.body.users)
            {
               _loc4_ = new UserInfo();
               _loc4_.parse(_loc7_);
               _loc8_[_loc4_.id] = _loc4_;
            }
            _loc5_ = _loc8_[param1.result.body.replay.userId];
            _loc9_ = _loc8_[param1.result.body.replay.typeId];
            _loc3_ = new ReplayBattleThread(param1.result.body.replay,_loc2_,_loc5_,_loc9_);
            _loc3_.onComplete.addOnce(onBattleEnded);
            _loc3_.run();
         }
      }
      
      private function onBattleEnded(param1:ArenaBattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
   }
}
