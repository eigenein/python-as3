package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   import game.model.user.chat.ChatLogMessage;
   import game.model.user.chat.ChatMessageChallengeData;
   import game.model.user.chat.ChatMessageReplayData;
   import game.model.user.chat.ChatUserData;
   import game.util.DateFormatter;
   
   public class ChatPopupLogValueObject
   {
       
      
      private var actionHandler:IChatMessageActionHandler;
      
      private var msg:ChatLogMessage;
      
      private var _header:String;
      
      private var _time:String;
      
      public function ChatPopupLogValueObject(param1:IChatMessageActionHandler, param2:ChatLogMessage)
      {
         super();
         this.actionHandler = param1;
         this.msg = param2;
         var _loc6_:Date = new Date(param2.ctime * 1000);
         var _loc3_:Date = new Date(GameTimer.instance.currentServerTime * 1000);
         if(_loc6_.date == _loc3_.date)
         {
            _time = DateFormatter.dateToHHMM(_loc6_);
         }
         else
         {
            _time = DateFormatter.dateToDDMMYYYY(_loc6_);
         }
         var _loc4_:String = "";
         if(param2.initiator.frameId > 0)
         {
            _loc4_ = " ^{sprite:icon_crown_" + param2.initiator.frameId + "}^";
         }
         var _loc5_:String = param2.initiator && param2.initiator.nickname != null?param2.initiator.nickname + _loc4_:Translate.translate("UI_COMMON_USR_NO_NAME");
         _header = _loc5_;
      }
      
      public function get id() : int
      {
         return msg.id;
      }
      
      public function get userId() : String
      {
         return msg.userId;
      }
      
      public function get chatType() : String
      {
         return msg.chatType;
      }
      
      public function get text() : String
      {
         return msg.text;
      }
      
      public function get header() : String
      {
         return _header;
      }
      
      public function get time() : String
      {
         return _time;
      }
      
      public function get initiator() : ChatUserData
      {
         return msg.initiator;
      }
      
      public function get messageType() : String
      {
         return msg.messageType;
      }
      
      public function get challengeData() : ChatMessageChallengeData
      {
         return msg.challengeData;
      }
      
      public function get replayData() : ChatMessageReplayData
      {
         return msg.replayData;
      }
      
      public function get data() : Object
      {
         return msg.data;
      }
      
      public function get myMessage() : Boolean
      {
         return msg.userId == GameModel.instance.player.id;
      }
      
      public function get serverMessage() : Boolean
      {
         return messageType == "hero" || messageType == "x100" || messageType == "coinSuper" || messageType == "artifactChestLU";
      }
      
      public function get playerIsModerator() : Boolean
      {
         return GameModel.instance.player.isChatModerator;
      }
      
      public function get userIsBanned() : Boolean
      {
         return msg.userIsBanned;
      }
      
      public function action_replayMessage(param1:ChatLogMessage) : void
      {
         actionHandler.action_replayMessage(param1);
      }
      
      public function action_showResponses() : void
      {
         actionHandler.action_showResponses(this);
      }
   }
}
