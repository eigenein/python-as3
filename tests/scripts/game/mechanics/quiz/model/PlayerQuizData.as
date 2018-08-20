package game.mechanics.quiz.model
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.command.timer.GameTimer;
   import game.mechanics.quiz.command.CommandQuizAnswer;
   import game.mechanics.quiz.command.CommandQuizGetInfo;
   import game.mechanics.quiz.mediator.QuizQuestionPopupMediator;
   import game.mechanics.quiz.mediator.QuizStartPopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   
   public class PlayerQuizData
   {
       
      
      private var _initialized:Boolean;
      
      private var lastSourceParams:PopupStashEventParams;
      
      private var _property_points:IntPropertyWriteable;
      
      private var _question:QuizQuestionValueObject;
      
      public function PlayerQuizData()
      {
         _property_points = new IntPropertyWriteable();
         super();
      }
      
      public function get property_points() : IntProperty
      {
         return _property_points;
      }
      
      public function get question() : QuizQuestionValueObject
      {
         return _question;
      }
      
      public function updateQuestion(param1:Object) : void
      {
         _question = new QuizQuestionValueObject(param1);
      }
      
      public function action_answer(param1:QuizAnswerValueObject) : CommandQuizAnswer
      {
         var _loc3_:int = GameTimer.instance.currentServerTime;
         var _loc2_:CommandQuizAnswer = new CommandQuizAnswer(_loc3_ - _question.creationTime,param1.id);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
         _loc2_.onClientExecute(handler_commandAnswer);
         return _loc2_;
      }
      
      public function update(param1:Object) : void
      {
         _property_points.value = param1.points;
         if(param1.question)
         {
            updateQuestion(param1.question);
         }
         else
         {
            _question = null;
         }
      }
      
      public function action_addPoints(param1:int) : void
      {
         _property_points.value = _property_points.value + param1;
      }
      
      public function action_quizNavigateTo(param1:PopupStashEventParams) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.lastSourceParams = param1;
         if(!_initialized)
         {
            _initialized = true;
            _loc4_ = new CommandQuizGetInfo();
            GameModel.instance.actionManager.executeRPCCommand(_loc4_);
            _loc4_.onClientExecute(handler_commandGetInfo);
            return;
         }
         if(_question)
         {
            _loc2_ = new QuizQuestionPopupMediator(GameModel.instance.player,false);
            _loc2_.open(param1);
         }
         else
         {
            _loc3_ = new QuizStartPopupMediator(GameModel.instance.player);
            _loc3_.open(param1);
         }
      }
      
      private function handler_commandGetInfo(param1:CommandQuizGetInfo) : void
      {
         update(param1.result.body);
         action_quizNavigateTo(lastSourceParams);
         lastSourceParams = null;
      }
      
      private function handler_commandAnswer(param1:CommandQuizAnswer) : void
      {
         _question = null;
      }
      
      private function navigateTo_start() : void
      {
      }
      
      private function navigateTo_question() : void
      {
      }
   }
}
