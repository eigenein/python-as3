package game.model.user.chat
{
   import engine.core.utils.property.IntPropertyWriteable;
   
   public class ChatMessageReplayData
   {
      
      public static const BATTLE_RESULT_UNKNOWN:int = 0;
      
      public static const BATTLE_RESULT_VICTORY:int = 1;
      
      public static const BATTLE_RESULT_DEFEAT:int = 2;
      
      public static const BATTLE_RESULT_DRAW:int = 3;
       
      
      private var _challengeId:int;
      
      private var _replayId:String;
      
      private var _enemyID:String;
      
      private var _enemy:ChatUserData;
      
      public const battleResult:IntPropertyWriteable = new IntPropertyWriteable(0);
      
      public function ChatMessageReplayData(param1:Object)
      {
         super();
         _challengeId = param1.data.challengeId;
         _replayId = param1.data.replayId;
         enemyID = param1.data.enemyId;
         if(param1.users && param1.users[enemyID])
         {
            enemy = new ChatUserData(param1.users[enemyID]);
         }
      }
      
      public function get challengeId() : int
      {
         return _challengeId;
      }
      
      public function get replayId() : String
      {
         return _replayId;
      }
      
      public function get enemyID() : String
      {
         return _enemyID;
      }
      
      public function set enemyID(param1:String) : void
      {
         _enemyID = param1;
      }
      
      public function get enemy() : ChatUserData
      {
         return _enemy;
      }
      
      public function set enemy(param1:ChatUserData) : void
      {
         if(_enemy == param1)
         {
            return;
         }
         _enemy = param1;
      }
   }
}
