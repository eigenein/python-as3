package game.mechanics.quiz.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.mechanics.quiz.command.CommandQuizAnswer;
   import game.mechanics.quiz.model.QuizAnswerValueObject;
   import game.mechanics.quiz.model.QuizQuestionValueObject;
   import game.mechanics.quiz.popup.QuizQuestionPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class QuizQuestionPopupMediator extends PopupMediator
   {
       
      
      private var openedFromStartPopup:Boolean;
      
      private var _question:QuizQuestionValueObject;
      
      private var _signal_rewardReceived:Signal;
      
      private var _timerString:String;
      
      public function QuizQuestionPopupMediator(param1:Player, param2:Boolean)
      {
         _signal_rewardReceived = new Signal(CommandQuizAnswer);
         super(param1);
         this.openedFromStartPopup = param2;
         _question = param1.quizData.question;
      }
      
      public function get question() : QuizQuestionValueObject
      {
         return _question;
      }
      
      public function get signal_rewardReceived() : Signal
      {
         return _signal_rewardReceived;
      }
      
      public function get timerString() : String
      {
         var _loc1_:int = _question.multiplier * DataStorage.rule.quizRule.getTimerBonus(_question.age);
         var _loc2_:int = DataStorage.rule.quizRule.getTimerTimeLeft(_question.age);
         if(_loc1_)
         {
            return Translate.translateArgs("UI_QUIZ_QUESTION_POPUP_TF_TIMED_POINTS",ColorUtils.addWhiteAndDefault(_loc1_.toString()),ColorUtils.addWhiteAndDefault(TimeFormatter.toMS(_loc2_)),_loc1_);
         }
         return "";
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new QuizQuestionPopup(this);
         return _popup;
      }
      
      public function action_select(param1:QuizAnswerValueObject) : void
      {
         var _loc2_:CommandQuizAnswer = player.quizData.action_answer(param1);
         _loc2_.onClientExecute(handler_commandAnswer);
      }
      
      public function action_continue() : void
      {
         player.quizData.action_quizNavigateTo(Stash.click("continue",_popup.stashParams));
         close();
      }
      
      private function handler_commandAnswer(param1:CommandQuizAnswer) : void
      {
         _signal_rewardReceived.dispatch(param1);
      }
   }
}
