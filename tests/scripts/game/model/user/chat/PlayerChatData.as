package game.model.user.chat
{
   import flash.utils.Dictionary;
   import game.command.realtime.SocketClientEvent;
   import game.command.rpc.chat.CommandChatGetAll;
   import game.model.GameModel;
   import idv.cjcat.signals.Signal;
   
   public class PlayerChatData
   {
       
      
      private var _chatLogByType:Dictionary;
      
      private var serverChatLog:Vector.<ChatLogMessage>;
      
      private var _signal_chatMessage:Signal;
      
      private var _signal_hasUnreadMessage:Signal;
      
      private var _signal_banUntilChange:Signal;
      
      private var _signal_banUserServerMessages:Signal;
      
      private var _signal_updateChatLog:Signal;
      
      private var _signal_blackListUpdate:Signal;
      
      private var _hasUnreadMessage:Boolean;
      
      private var _banUntil:Number;
      
      private var _blackList:Dictionary;
      
      private var _lastMessageTime:Number;
      
      private var _settings:Object;
      
      public var settingsChange:Boolean;
      
      public function PlayerChatData()
      {
         _chatLogByType = new Dictionary();
         super();
         _signal_chatMessage = new Signal(ChatLogMessage);
         _signal_hasUnreadMessage = new Signal(Boolean);
         _signal_updateChatLog = new Signal(String);
         _signal_banUntilChange = new Signal(Number);
         _signal_banUserServerMessages = new Signal(String,Number);
         _signal_blackListUpdate = new Signal();
      }
      
      public function get signal_chatMessage() : Signal
      {
         return _signal_chatMessage;
      }
      
      public function get signal_hasUnreadMessage() : Signal
      {
         return _signal_hasUnreadMessage;
      }
      
      public function get signal_banUntilChange() : Signal
      {
         return _signal_banUntilChange;
      }
      
      public function get signal_banUserServerMessages() : Signal
      {
         return _signal_banUserServerMessages;
      }
      
      public function get signal_updateChatLog() : Signal
      {
         return _signal_updateChatLog;
      }
      
      public function get signal_blackListUpdate() : Signal
      {
         return _signal_blackListUpdate;
      }
      
      public function get hasUnreadMessage() : Boolean
      {
         return _hasUnreadMessage;
      }
      
      public function get banUntil() : Number
      {
         return _banUntil;
      }
      
      public function get blackList() : Dictionary
      {
         return _blackList;
      }
      
      public function get lastMessageTime() : Number
      {
         return _lastMessageTime;
      }
      
      public function set lastMessageTime(param1:Number) : void
      {
         _lastMessageTime = param1;
      }
      
      public function get settings() : Object
      {
         return _settings;
      }
      
      public function set settings(param1:Object) : void
      {
         _settings = param1;
      }
      
      public function init(param1:Object, param2:Object) : void
      {
         var _loc4_:* = null;
         if(param2)
         {
            _banUntil = param2.banUntil;
            _lastMessageTime = param2.lastMessageTime;
            _blackList = new Dictionary();
            _loc4_ = param2.blackList;
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for(var _loc5_ in _loc4_)
            {
               _blackList[_loc4_[_loc5_]] = true;
            }
            if(param2.settings)
            {
               settings = param2.settings;
            }
            else
            {
               settings = {};
            }
         }
         writeInLog(param1.chat,param1.users,"clan");
         var _loc9_:int = 0;
         var _loc8_:* = _chatLogByType;
         for each(var _loc3_ in _chatLogByType)
         {
            if(_loc3_.length > 0)
            {
               if(!(_loc3_[_loc3_.length - 1].initiator && blackList[_loc3_[_loc3_.length - 1].initiator.id]))
               {
                  _hasUnreadMessage = _loc3_[_loc3_.length - 1].id > int(settings.lastReadMessageId);
               }
            }
         }
         GameModel.instance.actionManager.messageClient.subscribe("chatMessage",onAsyncChatMessage);
         GameModel.instance.actionManager.messageClient.subscribe("chatBan",onAsyncChatBan);
         GameModel.instance.player.clan.signal_clanUpdate.add(onClanUpdate);
      }
      
      public function serverChatUpdate() : void
      {
         writeInLog([],{},"server");
         var _loc1_:CommandChatGetAll = GameModel.instance.actionManager.chat.chatGetAll("server");
         _loc1_.signal_complete.add(onServerChatUpdate);
      }
      
      private function onServerChatUpdate(param1:CommandChatGetAll) : void
      {
         param1.signal_complete.remove(onServerChatUpdate);
         var _loc3_:Object = param1.result.body;
         var _loc2_:Array = _loc3_.chat;
         writeInLog(_loc2_,_loc3_.users,param1.chatType);
      }
      
      public function clanChatUpdate() : void
      {
         var _loc1_:* = null;
         writeInLog([],{},"clan");
         if(GameModel.instance.player.clan.clan != null)
         {
            _loc1_ = GameModel.instance.actionManager.chat.chatGetAll("clan");
            _loc1_.signal_complete.add(onClanChatUpdate);
         }
      }
      
      private function onClanChatUpdate(param1:CommandChatGetAll) : void
      {
         param1.signal_complete.remove(onClanChatUpdate);
         var _loc3_:Object = param1.result.body;
         var _loc2_:Array = _loc3_.chat;
         writeInLog(_loc2_,_loc3_.users,param1.chatType);
      }
      
      private function onClanChatUpdateAfterClanUpdate(param1:CommandChatGetAll) : void
      {
         onClanChatUpdate(param1);
         var _loc3_:Object = param1.result.body;
         var _loc2_:Array = _loc3_.chat;
         setHasUnreadMessage(_loc2_.length > 0);
      }
      
      private function onClanUpdate() : void
      {
         var _loc1_:* = null;
         setHasUnreadMessage(false);
         writeInLog([],{},"clan");
         if(GameModel.instance.player.clan.clan != null)
         {
            _loc1_ = GameModel.instance.actionManager.chat.chatGetAll("clan");
            _loc1_.signal_complete.add(onClanChatUpdateAfterClanUpdate);
         }
      }
      
      private function writeInLog(param1:Array, param2:Object, param3:String) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         param1.reverse();
         var _loc5_:int = param1.length;
         var _loc6_:Vector.<ChatLogMessage> = getLog(param3);
         _loc6_.length = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = new ChatLogMessage(param1[_loc7_]);
            if(param2)
            {
               if(param2[_loc4_.userId])
               {
                  _loc4_.initiator = new ChatUserData(param2[_loc4_.userId]);
               }
               if(param2[_loc4_.data.userId] && (_loc4_.messageType == "hero" || _loc4_.messageType == "x100" || _loc4_.messageType == "coinSuper" || _loc4_.messageType == "x100"))
               {
                  _loc4_.initiator = new ChatUserData(param2[_loc4_.data.userId]);
               }
               if(_loc4_.messageType == "replay")
               {
                  if(param2[_loc4_.replayData.enemyID])
                  {
                     _loc4_.replayData.enemy = new ChatUserData(param2[_loc4_.replayData.enemyID]);
                  }
               }
            }
            if(_loc4_.initiator != null)
            {
               if(tryCreateChallengeResponse(_loc6_,_loc4_))
               {
                  _loc4_ = null;
               }
               else
               {
                  _loc6_.push(_loc4_);
               }
            }
            _loc7_++;
         }
         _signal_updateChatLog.dispatch(param3);
      }
      
      public function setLastReadMessageId(param1:int) : void
      {
         if(param1 != settings.lastReadMessageId)
         {
            settings.lastReadMessageId = param1;
            settingsChange = true;
         }
         setHasUnreadMessage(false);
      }
      
      private function onAsyncChatMessage(param1:SocketClientEvent) : void
      {
         var _loc2_:ChatLogMessage = new ChatLogMessage(param1.data.body,GameModel.instance.player.clan.clan);
         if(_loc2_.messageType == "titan" || _loc2_.messageType == "titanPotion")
         {
            return;
         }
         var _loc4_:String = param1.data.body["chatType"];
         var _loc3_:Vector.<ChatLogMessage> = getLog(_loc4_);
         if(_loc4_ == "clan")
         {
            if(!(_loc2_.initiator && blackList[_loc2_.initiator.id]))
            {
               setHasUnreadMessage(true);
            }
         }
         if(tryCreateChallengeResponse(_loc3_,_loc2_) == false)
         {
            _loc3_.push(_loc2_);
            _signal_chatMessage.dispatch(_loc2_);
         }
      }
      
      private function onAsyncChatBan(param1:SocketClientEvent) : void
      {
         var _loc3_:Object = param1.data.body;
         var _loc4_:String = _loc3_.userId;
         var _loc2_:Number = _loc3_.banUntil;
         if(_loc4_ == GameModel.instance.player.id || _loc4_ == null)
         {
            _banUntil = _loc2_;
            banUserMessages(GameModel.instance.player.id,"server",_loc2_);
            _signal_banUntilChange.dispatch(_loc2_);
         }
         else
         {
            banUserMessages(_loc4_,"server",_loc2_);
         }
      }
      
      private function setHasUnreadMessage(param1:Boolean) : void
      {
         if(_hasUnreadMessage != param1)
         {
            _hasUnreadMessage = param1;
            _signal_hasUnreadMessage.dispatch(_hasUnreadMessage);
         }
      }
      
      public function getLog(param1:String) : Vector.<ChatLogMessage>
      {
         var _loc2_:Vector.<ChatLogMessage> = _chatLogByType[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<ChatLogMessage>();
            _chatLogByType[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      protected function tryCreateChallengeResponse(param1:Vector.<ChatLogMessage>, param2:ChatLogMessage) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function banUserMessages(param1:String, param2:String, param3:Number) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc5_:Vector.<ChatLogMessage> = getLog(param2);
         var _loc4_:int = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _loc5_[_loc6_];
            if(_loc7_.userId == param1)
            {
               _loc7_.setBanned();
            }
            _loc6_++;
         }
         _signal_banUserServerMessages.dispatch(param1,param3);
      }
   }
}
