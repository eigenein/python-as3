package game.model.user.chat
{
   import feathers.data.ListCollection;
   import game.model.user.arena.PlayerArenaEnemy;
   
   public class ChatMessageChallengeData
   {
       
      
      protected var _enemy:PlayerArenaEnemy;
      
      protected var _text:String;
      
      private var _itTitanBattle:Boolean;
      
      public const responses:ListCollection = new ListCollection();
      
      public function ChatMessageChallengeData(param1:Object)
      {
         super();
         _text = param1.text;
         _itTitanBattle = param1.type == "titan";
         _enemy = new PlayerArenaEnemy(param1);
      }
      
      public function get enemy() : PlayerArenaEnemy
      {
         return _enemy;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get isTitanBattle() : Boolean
      {
         return _itTitanBattle;
      }
   }
}
