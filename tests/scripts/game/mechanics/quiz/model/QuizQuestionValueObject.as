package game.mechanics.quiz.model
{
   import game.command.timer.GameTimer;
   
   public class QuizQuestionValueObject
   {
       
      
      private var _text:String;
      
      private var _answers:Vector.<QuizAnswerValueObject>;
      
      private var _questionIcon:String;
      
      private var _difficulty:int;
      
      private var _creationTime:int;
      
      private var _multiplier:int;
      
      public function QuizQuestionValueObject(param1:Object)
      {
         super();
         parse(param1);
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get answers() : Vector.<QuizAnswerValueObject>
      {
         return _answers;
      }
      
      public function get questionIcon() : String
      {
         return _questionIcon;
      }
      
      public function get difficulty() : int
      {
         return _difficulty;
      }
      
      public function get creationTime() : int
      {
         return _creationTime;
      }
      
      public function get age() : int
      {
         return GameTimer.instance.serverTime.time - creationTime;
      }
      
      public function get multiplier() : int
      {
         return _multiplier;
      }
      
      private function parse(param1:Object) : void
      {
         var _loc3_:int = 0;
         _difficulty = param1.difficulty;
         _creationTime = param1.ctime;
         _text = param1.question;
         if(!_text)
         {
            _text = "";
         }
         _text = _text.split(String.fromCharCode(8206)).join("");
         _questionIcon = param1.questionIcon;
         _answers = new Vector.<QuizAnswerValueObject>();
         var _loc2_:int = param1.answers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _answers.push(new QuizAnswerValueObject(param1.answers[_loc3_]));
            _loc3_++;
         }
         _multiplier = param1.multiplier;
      }
   }
}
