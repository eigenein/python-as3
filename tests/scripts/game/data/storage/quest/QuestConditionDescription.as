package game.data.storage.quest
{
   import game.data.storage.DataStorage;
   
   public class QuestConditionDescription
   {
       
      
      private var _amount:int;
      
      private var _function:QuestConditionFunction;
      
      private var _functionArgs:Object;
      
      public function QuestConditionDescription(param1:Object)
      {
         super();
         _amount = param1.amount;
         if(param1.stateFunc)
         {
            _function = DataStorage.quest.getStateFunction(param1.stateFunc.name);
            _functionArgs = param1.stateFunc.args;
         }
         else if(param1.eventFunc)
         {
            _function = DataStorage.quest.getEventFunction(param1.eventFunc.name);
            _functionArgs = param1.eventFunc.args;
         }
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get stateFunc() : QuestConditionFunction
      {
         return _function;
      }
      
      public function get functionArgs() : Object
      {
         return _functionArgs;
      }
   }
}
