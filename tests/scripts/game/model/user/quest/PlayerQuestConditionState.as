package game.model.user.quest
{
   import game.data.storage.quest.QuestConditionDescription;
   
   public class PlayerQuestConditionState
   {
      
      public static const STATE_AVAILABLE:int = 1;
      
      public static const STATE_CAN_BE_FARMED:int = 2;
      
      public static const STATE_FARMED:int = 3;
       
      
      private var _progress:int;
      
      private var state:int;
      
      private var desc:QuestConditionDescription;
      
      public function PlayerQuestConditionState(param1:QuestConditionDescription, param2:int, param3:int)
      {
         super();
         this.desc = param1;
         this.state = param3;
         this._progress = param2;
      }
      
      public function get progress() : int
      {
         return _progress;
      }
      
      function applyUpdate(param1:Object) : void
      {
         _progress = param1.progress;
         state = param1.state;
      }
   }
}
