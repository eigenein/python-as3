package game.data.storage.quest
{
   public class QuestDailyDescription extends QuestDescription
   {
       
      
      private var _startCondition:QuestConditionDescription;
      
      public function QuestDailyDescription(param1:Object)
      {
         super(param1);
         if(param1.startCondition)
         {
            _startCondition = new QuestConditionDescription(param1.startCondition);
         }
      }
      
      public function get startCondition() : QuestConditionDescription
      {
         return _startCondition;
      }
   }
}
