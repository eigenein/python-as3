package game.model.user.chat
{
   import game.model.user.ClanUserInfoValueObject;
   
   public class ChatLogMessage
   {
      
      public static const TYPE_TEXT:String = "text";
      
      public static const TYPE_REPLAY:String = "replay";
      
      public static const TYPE_CHALLENGE:String = "challenge";
      
      public static const TYPE_X100:String = "x100";
      
      public static const TYPE_HERO:String = "hero";
      
      public static const TYPE_COIN_SUPER:String = "coinSuper";
      
      public static const TYPE_TITAN:String = "titan";
      
      public static const TYPE_TITAN_POTION:String = "titanPotion";
      
      public static const TYPE_ARTIFACT_CHEST_LU:String = "artifactChestLU";
       
      
      private var _chatType:String;
      
      private var _text:String;
      
      private var _id:int;
      
      private var _userId:String;
      
      private var _messageType:String;
      
      private var _data:Object;
      
      private var _ctime:int;
      
      private var _userIsBanned:Boolean;
      
      private var _initiator:ChatUserData;
      
      private var _challengeData:ChatMessageChallengeData;
      
      private var _replayData:ChatMessageReplayData;
      
      public function ChatLogMessage(param1:Object, param2:ClanUserInfoValueObject = null)
      {
         super();
         _chatType = param1.chatType;
         _text = param1.data.text;
         _id = param1.id;
         _userId = param1.userId;
         _messageType = param1.messageType;
         _data = param1.data;
         _ctime = param1.ctime;
         if(param1.user)
         {
            initiator = new ChatUserData(param1.user,param2);
         }
         if(_messageType == "challenge")
         {
            _challengeData = new ChatMessageChallengeData(param1.data);
         }
         if(_messageType == "replay")
         {
            _replayData = new ChatMessageReplayData(param1);
         }
      }
      
      public function get chatType() : String
      {
         return _chatType;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get messageType() : String
      {
         return _messageType;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get ctime() : int
      {
         return _ctime;
      }
      
      public function get userIsBanned() : Boolean
      {
         return _userIsBanned;
      }
      
      public function get initiator() : ChatUserData
      {
         return _initiator;
      }
      
      public function set initiator(param1:ChatUserData) : void
      {
         if(_initiator == param1)
         {
            return;
         }
         _initiator = param1;
      }
      
      public function get challengeData() : ChatMessageChallengeData
      {
         return _challengeData;
      }
      
      public function get replayData() : ChatMessageReplayData
      {
         return _replayData;
      }
      
      public function setBanned() : void
      {
         _userIsBanned = true;
      }
   }
}
