package game.mechanics.quiz.model
{
   public class QuizRule
   {
       
      
      private var data:Object;
      
      private var timerBonus:Array;
      
      public function QuizRule(param1:Object)
      {
         var _loc2_:* = null;
         super();
         this.data = param1;
         timerBonus = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1.timerBonus;
         for(var _loc3_ in param1.timerBonus)
         {
            _loc2_ = param1.timerBonus[_loc3_];
            _loc2_.time = _loc3_;
            timerBonus.push(param1.timerBonus[_loc3_]);
         }
         timerBonus.sort(_sort);
      }
      
      private function _sort(param1:*, param2:*) : int
      {
         return param1.time - param2.time;
      }
      
      public function getTimerBonus(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = timerBonus.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(timerBonus[_loc3_].time > param1)
            {
               return timerBonus[_loc3_].quizPoints;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function getTimerTimeLeft(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = timerBonus.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(timerBonus[_loc3_].time > param1)
            {
               return timerBonus[_loc3_].time - param1;
            }
            _loc3_++;
         }
         return 0;
      }
   }
}
