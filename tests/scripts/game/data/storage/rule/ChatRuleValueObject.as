package game.data.storage.rule
{
   public class ChatRuleValueObject
   {
       
      
      private var _banDuration:Array;
      
      private var _maxMessageLength:uint;
      
      private var _minMessageLength:uint;
      
      private var _minTimeoutSeconds:uint;
      
      private var _chatSendChallengeType:Array;
      
      private var _chatSendReplayType:Array;
      
      public function ChatRuleValueObject(param1:Object)
      {
         super();
         _banDuration = param1.banDuration;
         _chatSendChallengeType = param1.chatSendChallengeType;
         _chatSendReplayType = param1.chatSendReplayType;
         _maxMessageLength = param1.maxMessageLength;
         _minMessageLength = param1.minMessageLength;
         _minTimeoutSeconds = param1.minTimeoutSeconds;
      }
      
      public function get banDuration() : Array
      {
         return _banDuration;
      }
      
      public function get maxMessageLength() : uint
      {
         return _maxMessageLength;
      }
      
      public function get minMessageLength() : uint
      {
         return _minMessageLength;
      }
      
      public function get minTimeoutSeconds() : uint
      {
         return _minTimeoutSeconds;
      }
      
      public function get chatSendChallengeType() : Array
      {
         return _chatSendChallengeType;
      }
      
      public function get chatSendReplayType() : Array
      {
         return _chatSendReplayType;
      }
   }
}
