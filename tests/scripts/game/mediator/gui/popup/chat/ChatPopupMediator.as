package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import flash.desktop.Clipboard;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.battle.controller.thread.TitanChallengeBattleThread;
   import game.command.rpc.chat.CommandChatAcceptChallenge;
   import game.command.rpc.mission.CommandBattleGetReplay;
   import game.command.rpc.mission.CommandBattleStartReplay;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chat.responses.ChatChallengeResponsesPopupMediator;
   import game.mediator.gui.popup.chat.sendreplay.SendReplayPopUpMediator;
   import game.mediator.gui.popup.chat.userinfo.ChatUserInfoPopUpMediator;
   import game.mediator.gui.popup.chat.userinfo.challenge.SendChallengePopUp;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.chat.ChatLogMessage;
   import game.model.user.chat.ChatMessageReplayData;
   import game.model.user.chat.ChatUserData;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.ISignal;
   import idv.cjcat.signals.Signal;
   
   public class ChatPopupMediator extends PopupMediator implements IChatMessageActionHandler
   {
      
      public static const SERVER_TAB:String = "SERVER_TAB";
      
      public static const CLAN_TAB:String = "CLAN_TAB";
       
      
      private var log:Vector.<ChatLogMessage>;
      
      private var chatSettingsTimer:Timer;
      
      private const MAX_MESSAGES:int = 50;
      
      private const MIN_MESSAGES:int = 10;
      
      private var _currentIndex:int;
      
      private var _chatLog:ListCollection;
      
      private var _tabs:Vector.<String>;
      
      private var _signal_tabSelect:Signal;
      
      private var _signal_tabsUpdate:Signal;
      
      private var _signal_banUntilChange:Signal;
      
      private var _signal_blackListUpdate:Signal;
      
      private var _challengeHeroesIDs:Array;
      
      private var _challengeAcceptMessageID:int;
      
      private var _selectedTab:String;
      
      public function ChatPopupMediator(param1:Player)
      {
         super(param1);
         _chatLog = new ListCollection();
         param1.chat.signal_chatMessage.add(onChatMessage);
         param1.chat.signal_updateChatLog.add(onUpdateChatLog);
         param1.chat.signal_banUntilChange.add(onChangeBanUntil);
         param1.chat.signal_banUserServerMessages.add(onBanAnotherUser);
         param1.chat.signal_blackListUpdate.add(onBlackListUpdate);
         param1.clan.signal_clanUpdate.add(onClanUpdate);
         _tabs = new Vector.<String>();
         _tabs.push("SERVER_TAB");
         if(param1.clan.clan)
         {
            _tabs.push("CLAN_TAB");
         }
         _selectedTab = tabs[0];
         if(_tabs.length > 1 && param1.chat.settings.hasOwnProperty("chatSelectedTab") && param1.chat.settings.chatSelectedTab == "CLAN_TAB")
         {
            _selectedTab = tabs[1];
         }
         _signal_tabSelect = new Signal();
         _signal_tabsUpdate = new Signal();
         _signal_banUntilChange = new Signal(Number);
         _signal_blackListUpdate = new Signal();
         chatSettingsTimer = new Timer(3000,2147483647);
         chatSettingsTimer.addEventListener("timer",handler_chatSettingsTimerTick);
         chatSettingsTimer.start();
      }
      
      public static function copy_text_to_clipboard(param1:String) : void
      {
         Clipboard.generalClipboard.setData("air:text",param1);
      }
      
      private function onClanUpdate() : void
      {
         if(player.clan.clan && _tabs.length == 1)
         {
            _tabs.push("CLAN_TAB");
            _signal_tabsUpdate.dispatch();
         }
      }
      
      private function onUpdateChatLog(param1:String) : void
      {
         if(param1 == "clan" && selectedTab == "CLAN_TAB" || param1 == "server" && selectedTab == "SERVER_TAB")
         {
            writeInChatLog(param1);
         }
      }
      
      public function writeInChatLog(param1:String) : void
      {
         var _loc3_:int = 0;
         GameTimer.instance.oneFrameTimer.remove(addMessage);
         log = player.chat.getLog(param1);
         if(log.length > 50)
         {
            log = log.slice(log.length - 50);
         }
         if(log.length > 0 && param1 == "clan")
         {
            player.chat.setLastReadMessageId(log[log.length - 1].id);
         }
         var _loc2_:int = log.length;
         var _loc4_:Vector.<ChatPopupLogValueObject> = new Vector.<ChatPopupLogValueObject>();
         if(_loc2_ > 10)
         {
            _currentIndex = _loc2_ - 10;
            _loc3_ = _currentIndex;
            while(_loc3_ < _loc2_)
            {
               if(!(log[_loc3_].initiator && player.chat.blackList[log[_loc3_].initiator.id]))
               {
                  _loc4_.push(new ChatPopupLogValueObject(this,log[_loc3_]));
               }
               _loc3_++;
            }
            GameTimer.instance.oneFrameTimer.add(addMessage);
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(!(log[_loc3_].initiator && player.chat.blackList[log[_loc3_].initiator.id]))
               {
                  _loc4_.push(new ChatPopupLogValueObject(this,log[_loc3_]));
               }
               _loc3_++;
            }
            if(selectedTab == "CLAN_TAB")
            {
               saveChatSettings();
            }
         }
         _chatLog.data = _loc4_;
      }
      
      private function addMessage() : void
      {
         if(_currentIndex > 0)
         {
            _currentIndex = Number(_currentIndex) - 1;
            if(log[_currentIndex].initiator && player.chat.blackList[log[_currentIndex].initiator.id])
            {
               return;
            }
            _chatLog.addItemAt(new ChatPopupLogValueObject(this,log[_currentIndex]),0);
         }
         else
         {
            GameTimer.instance.oneFrameTimer.remove(addMessage);
            if(selectedTab == "CLAN_TAB")
            {
               saveChatSettings();
            }
         }
      }
      
      private function onChatMessage(param1:ChatLogMessage) : void
      {
         var _loc2_:ChatPopupLogValueObject = new ChatPopupLogValueObject(this,param1);
         if(selectedTab == "SERVER_TAB" && _loc2_.chatType == "server" || selectedTab == "CLAN_TAB" && _loc2_.chatType == "clan")
         {
            if(_loc2_.initiator && player.chat.blackList[_loc2_.initiator.id])
            {
               return;
            }
            _chatLog.push(_loc2_);
            if(_loc2_.chatType == "clan")
            {
               player.chat.setLastReadMessageId(param1.id);
            }
         }
      }
      
      private function onBanAnotherUser(param1:String, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = _chatLog.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _chatLog.updateItemAt(_loc4_);
            _loc4_++;
         }
      }
      
      private function onChangeBanUntil(param1:Number) : void
      {
         _signal_banUntilChange.dispatch(param1);
      }
      
      private function onBlackListUpdate() : void
      {
         _signal_blackListUpdate.dispatch();
      }
      
      override protected function dispose() : void
      {
         player.chat.signal_chatMessage.remove(onChatMessage);
         player.chat.signal_updateChatLog.remove(onUpdateChatLog);
         player.chat.signal_banUntilChange.remove(onChangeBanUntil);
         player.chat.signal_banUserServerMessages.remove(onBanAnotherUser);
         player.chat.signal_blackListUpdate.remove(onBlackListUpdate);
         player.clan.signal_clanUpdate.remove(onClanUpdate);
         GameTimer.instance.oneFrameTimer.remove(addMessage);
         if(chatSettingsTimer)
         {
            chatSettingsTimer.reset();
            chatSettingsTimer.removeEventListener("timer",handler_chatSettingsTimerTick);
            chatSettingsTimer = null;
         }
         super.dispose();
      }
      
      public function get serverName() : String
      {
         return player.serverId + " " + Translate.translate("LIB_SERVER_NAME_" + player.serverId);
      }
      
      public function get chatLog() : ListCollection
      {
         return _chatLog;
      }
      
      public function get clan_model() : ClanPrivateInfoValueObject
      {
         return player.clan.clan;
      }
      
      public function canEditClanNews() : Boolean
      {
         return player.clan.playerRole.permission_edit_settings;
      }
      
      public function get banned() : Boolean
      {
         return banTime > 0;
      }
      
      public function get banUntil() : Number
      {
         return player.chat.banUntil;
      }
      
      public function get banTime() : Number
      {
         return player.chat.banUntil - GameTimer.instance.currentServerTime;
      }
      
      public function get teamLevel() : Number
      {
         return player.levelData.level.level;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get signal_tabSelect() : Signal
      {
         return _signal_tabSelect;
      }
      
      public function get signal_tabsUpdate() : Signal
      {
         return _signal_tabsUpdate;
      }
      
      public function get signal_banUntilChange() : ISignal
      {
         return _signal_banUntilChange;
      }
      
      public function get signal_blackListUpdate() : ISignal
      {
         return _signal_blackListUpdate;
      }
      
      public function get challengeHeroesIDs() : Array
      {
         return _challengeHeroesIDs;
      }
      
      public function get challengeAcceptMessageID() : int
      {
         return _challengeAcceptMessageID;
      }
      
      public function get selectedTab() : String
      {
         return _selectedTab;
      }
      
      public function set selectedTab(param1:String) : void
      {
         if(_selectedTab != param1)
         {
            _selectedTab = param1;
         }
      }
      
      public function save_clan_news(param1:String) : void
      {
         GameModel.instance.actionManager.clan.clanUpdate(null,param1);
      }
      
      public function action_send(param1:String, param2:String) : Boolean
      {
         if(checkMessageTimeout())
         {
            if(param1.length >= DataStorage.rule.chatRule.minMessageLength && param1.length <= DataStorage.rule.chatRule.maxMessageLength)
            {
               if(param2 == "clan" || param2 == "server" && player.levelData.level.level >= MechanicStorage.CHAT.teamLevel)
               {
                  GameModel.instance.actionManager.chat.chatSendText(param1,param2);
                  return true;
               }
               PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",MechanicStorage.CHAT.teamLevel));
            }
            else
            {
               PopupList.instance.message(Translate.translateArgs("UI_POPUP_CHAT_MESSAGE_LENGHT",DataStorage.rule.chatRule.minMessageLength,DataStorage.rule.chatRule.maxMessageLength));
            }
         }
         return false;
      }
      
      public function showChallengePopUp() : void
      {
         var _loc1_:ChatChallengeTypeSelectPopup = new ChatChallengeTypeSelectPopup();
         _loc1_.signal_battleType.add(handler_challengeBattleType);
         _loc1_.open();
      }
      
      private function handler_challengeBattleType(param1:String) : void
      {
         var _loc3_:* = param1 == "titan";
         if(_loc3_ && player.titans.getAmount() < 1)
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_CHAT_NOT_ENOUGH_TITANS"));
            return;
         }
         var _loc2_:ChatChallengeDefenceTeamGatherPopupMediator = new ChatChallengeDefenceTeamGatherPopupMediator(player,new Vector.<UnitDescription>(),_loc3_);
         _loc2_.startButtonLabel = Translate.translate("UI_DIALOG_GRAND_GATHER_NEXT");
         _loc2_.signal_teamGatherComplete.addOnce(handler_teamGatherComplete);
         _loc2_.open();
      }
      
      public function action_tabSelect(param1:int) : void
      {
         _selectedTab = tabs[param1];
         _signal_tabSelect.dispatch();
         if(player.chat.settings.chatSelectedTab != selectedTab)
         {
            player.chat.settings.chatSelectedTab = selectedTab;
            player.chat.settingsChange = true;
            saveChatSettings();
         }
      }
      
      public function updateChatServer() : void
      {
         player.chat.serverChatUpdate();
      }
      
      public function updateChatClan() : void
      {
         player.chat.clanChatUpdate();
      }
      
      public function chatServerSubscribe() : void
      {
         GameModel.instance.actionManager.chat.chatServerSubscribe();
      }
      
      public function chatServerUnSubscribe() : void
      {
         GameModel.instance.actionManager.chat.chatServerUnSubscribe();
      }
      
      public function showUserInfo(param1:ChatUserData) : void
      {
         var _loc2_:ChatUserInfoPopUpMediator = new ChatUserInfoPopUpMediator(player,param1);
         _loc2_.banAvaliable = selectedTab == "SERVER_TAB";
         _loc2_.open(Stash.click("chat_message_info",_popup.stashParams));
      }
      
      public function action_copyReplay(param1:ChatMessageReplayData) : void
      {
         new SendReplayPopUpMediator(player,param1.replayId,null,2).open(Stash.click("char_message_replay",_popup.stashParams));
      }
      
      public function replay(param1:ChatPopupLogValueObject) : void
      {
         var _loc2_:CommandBattleStartReplay = new CommandBattleStartReplay(param1.replayData.replayId);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      public function action_replayMessage(param1:ChatLogMessage) : void
      {
         var _loc2_:CommandBattleStartReplay = new CommandBattleStartReplay(param1.replayData.replayId);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      public function action_showResponses(param1:ChatPopupLogValueObject) : void
      {
         var _loc2_:ChatChallengeResponsesPopupMediator = new ChatChallengeResponsesPopupMediator(player,param1);
         _loc2_.open(Stash.click("chat_challenge_respones",_popup.stashParams));
      }
      
      public function getTabMarkerVisibleByID(param1:String) : Boolean
      {
         if(param1 == "CLAN_TAB" && selectedTab != "CLAN_TAB")
         {
            if(player.chat.hasUnreadMessage || player.clan.clan != null && player.clan.clan.hasUnreadNews)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ChatPopup(this);
         return _popup;
      }
      
      public function saveChatSettings() : void
      {
         if(player.chat.settingsChange)
         {
            GameModel.instance.actionManager.chat.chatSetSettings(player);
         }
      }
      
      private function onGetBattleReplay(param1:CommandBattleGetReplay) : void
      {
         var _loc7_:* = null;
         var _loc3_:* = false;
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc4_:* = null;
         if(param1.result.body && param1.result.body.replay)
         {
            _loc7_ = param1.result.body.replay.typeId;
            _loc3_ = param1.playerId == _loc7_;
            _loc9_ = {};
            _loc2_ = param1.result.body.users;
            var _loc12_:int = 0;
            var _loc11_:* = _loc2_;
            for each(var _loc8_ in _loc2_)
            {
               _loc5_ = new UserInfo();
               _loc5_.parse(_loc8_);
               _loc9_[_loc5_.id] = _loc5_;
            }
            _loc6_ = _loc9_[param1.result.body.replay.userId];
            _loc10_ = _loc9_[param1.result.body.replay.typeId];
            _loc4_ = new ReplayBattleThread(param1.result.body.replay,_loc3_,_loc6_,_loc10_);
            _loc4_.onComplete.addOnce(onBattleEnded);
            _loc4_.run();
         }
      }
      
      private function onBattleEnded(param1:BattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
      
      private function handler_teamGatherComplete(param1:TeamGatherPopupMediator) : void
      {
         var _loc3_:int = 0;
         var _loc5_:ChatChallengeDefenceTeamGatherPopupMediator = param1 as ChatChallengeDefenceTeamGatherPopupMediator;
         _challengeHeroesIDs = [];
         var _loc4_:Vector.<UnitDescription> = _loc5_.descriptionList;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _challengeHeroesIDs.push(_loc4_[_loc3_].id);
            _loc3_++;
         }
         var _loc2_:PopupBase = new SendChallengePopUp(this,_loc5_.isTitanTeam);
         _loc2_.open();
         _loc5_.close();
      }
      
      public function closeChallengePopUp(param1:PopupBase) : void
      {
         if(param1)
         {
            PopUpManager.removePopUp(param1);
            param1.dispose();
         }
      }
      
      public function sendChallenge(param1:String, param2:Boolean) : void
      {
         if(checkMessageTimeout())
         {
            if(param1.length <= DataStorage.rule.chatRule.maxMessageLength)
            {
               GameModel.instance.actionManager.chat.chatSendChallenge("clan",challengeHeroesIDs,param1,param2);
            }
            else
            {
               PopupList.instance.message(Translate.translateArgs("UI_POPUP_CHAT_MESSAGE_LENGHT",DataStorage.rule.chatRule.minMessageLength,DataStorage.rule.chatRule.maxMessageLength));
            }
         }
      }
      
      public function showChallengeInfo(param1:ChatPopupLogValueObject) : void
      {
         if(param1.challengeData.isTitanBattle && player.titans.getAmount() < 1)
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_CHAT_NOT_ENOUGH_TITANS"));
            return;
         }
         _challengeAcceptMessageID = param1.id;
         var _loc2_:ChatChallengeAttackTeamGatherPopupMediator = new ChatChallengeAttackTeamGatherPopupMediator(player,param1.challengeData.isTitanBattle,param1.challengeData.enemy,param1.initiator);
         _loc2_.signal_teamGatherComplete.addOnce(onChallengeAccept);
         _loc2_.open();
      }
      
      private function onChallengeAccept(param1:TeamGatherPopupMediator) : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc7_:ChatChallengeAttackTeamGatherPopupMediator = param1 as ChatChallengeAttackTeamGatherPopupMediator;
         var _loc2_:Array = [];
         var _loc4_:Vector.<UnitDescription> = _loc7_.descriptionList;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_.push(_loc4_[_loc3_].id);
            _loc3_++;
         }
         var _loc6_:int = 1;
         if(checkChallengeAvaliable(player.levelData.level.level,_loc6_))
         {
            if(checkMessageTimeout())
            {
               _loc5_ = GameModel.instance.actionManager.chat.chatAcceptChallenge(_challengeAcceptMessageID,_loc2_,_loc7_.isTitanBattle,player.getUserInfo(),_loc7_.enemyUser);
               _loc5_.signal_complete.add(onAcceptChallengeComplete);
            }
         }
         _loc7_.close();
      }
      
      private function onAcceptChallengeComplete(param1:CommandChatAcceptChallenge) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:Object = param1.result.body;
         if(_loc2_ && _loc2_.battle)
         {
            if(param1.isTitanBattle)
            {
               _loc4_ = new TitanChallengeBattleThread(_loc2_.battle,param1.attacker,param1.defender);
               _loc4_.onComplete.addOnce(onBattleEnded);
               _loc4_.run();
            }
            else
            {
               _loc3_ = new ReplayBattleThread(_loc2_.battle,false,param1.attacker,param1.defender);
               _loc3_.onComplete.addOnce(onBattleEnded);
               _loc3_.run();
            }
         }
      }
      
      private function checkMessageTimeout() : Boolean
      {
         var _loc1_:int = GameTimer.instance.currentServerTime - player.chat.lastMessageTime;
         if(_loc1_ > DataStorage.rule.chatRule.minTimeoutSeconds)
         {
            return true;
         }
         PopupList.instance.message(Translate.translateArgs("UI_POPUP_CHAT_MESSAGE_TIMEOUT",DataStorage.rule.chatRule.minTimeoutSeconds));
         return false;
      }
      
      private function checkChallengeAvaliable(param1:int, param2:int) : Boolean
      {
         if(param1 >= MechanicStorage.CHALLENGE.teamLevel)
         {
            if(param2 >= MechanicStorage.CHALLENGE.minHeroLevel)
            {
               return true;
            }
            PopupList.instance.message(Translate.translateArgs("UI_DIALOG_TEAM_GATHER_LEVEL_NEEDED",MechanicStorage.CHALLENGE.minHeroLevel));
         }
         else
         {
            PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",MechanicStorage.CHALLENGE.teamLevel));
         }
         return false;
      }
      
      private function handler_chatSettingsTimerTick(param1:TimerEvent) : void
      {
         if(selectedTab == "CLAN_TAB")
         {
            saveChatSettings();
         }
      }
   }
}
