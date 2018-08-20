package game.data.storage.quest
{
   public class QuestChainDescription
   {
       
      
      private var _id:int;
      
      private var _startCondition:QuestConditionDescription;
      
      public function QuestChainDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _startCondition = new QuestConditionDescription(param1.startCondition);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get startCondition() : QuestConditionDescription
      {
         return _startCondition;
      }
   }
}
