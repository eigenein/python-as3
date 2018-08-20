package game.mechanics.quiz.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.timer.GameTimer;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.mechanics.quiz.command.CommandQuizAnswer;
   import game.mechanics.quiz.mediator.QuizQuestionPopupMediator;
   import game.mechanics.quiz.model.QuizAnswerValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class QuizQuestionPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:QuizQuestionPopupMediator;
      
      private var clip:QuizQuestionPopupClip;
      
      private var _selectedAnswer:QuizAnswerValueObject;
      
      public function QuizQuestionPopup(param1:QuizQuestionPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName("quiz_popup"));
         this.mediator = param1;
         param1.signal_rewardReceived.add(handler_rewardReceived);
      }
      
      override public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:int = 0;
         super.onAssetLoaded(param1);
         clip = param1.create(QuizQuestionPopupClip,"quiz_question_popup");
         addChild(clip.graphics);
         clip.question.setData(mediator.question);
         var _loc2_:int = clip.answer.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.answer[_loc3_].setData(mediator.question.answers[_loc3_]);
            clip.answer[_loc3_].signal_click.add(handler_selectAnswer);
            _loc3_++;
         }
         clip.button_continue.label = Translate.translate("UI_QUIZ_QUESTION_POPUP_BUTTON_CONTINUE");
         clip.button_confirm.label = Translate.translate("UI_QUIZ_QUESTION_POPUP_BUTTON_CONFIRM");
         clip.layout_reward.visible = false;
         clip.button_confirm.graphics.visible = false;
         clip.button_close.signal_click.add(mediator.close);
         clip.playback.gotoAndStop(0);
         clip.button_confirm.signal_click.add(handler_confirm);
         clip.button_continue.signal_click.add(mediator.action_continue);
         GameTimer.instance.oneSecTimer.add(handler_timer);
         handler_timer();
         clip.blessing_anim.stop();
         clip.blessing_anim.graphics.visible = false;
      }
      
      private function handler_selectAnswer(param1:QuizQuestionPopupAnswerClip) : void
      {
         var _loc3_:int = 0;
         _selectedAnswer = param1.data;
         var _loc2_:int = clip.answer.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.answer[_loc3_].selected = clip.answer[_loc3_] == param1;
            _loc3_++;
         }
         clip.button_confirm.graphics.visible = true;
      }
      
      private function handler_confirm() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = clip.answer.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(clip.answer[_loc2_].selected)
            {
               mediator.action_select(clip.answer[_loc2_].data);
               return;
            }
            _loc2_++;
         }
      }
      
      private function handler_rewardReceived(param1:CommandQuizAnswer) : void
      {
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         clip.playback.gotoAndStop(1);
         var _loc2_:int = 0;
         var _loc8_:Vector.<InventoryItem> = param1.reward.outputDisplay;
         clip.reward_1.setData(_loc8_[0]);
         if(_loc8_.length == 2)
         {
            clip.reward_2.setData(_loc8_[1]);
         }
         else
         {
            clip.reward_2.graphics.visible = false;
         }
         _loc3_ = _loc8_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(!(_loc8_[_loc5_].item is PseudoResourceDescription))
            {
               _loc2_ = _loc8_[_loc5_].amount;
            }
            _loc5_++;
         }
         clip.tf_answer_info.text = "";
         if(param1.isCorrect)
         {
            clip.tf_answer_info.text = clip.tf_answer_info.text + Translate.translateArgs("UI_QUIZ_QUESTION_POPUP_CORRECT",ColorUtils.addWhiteAndDefault(_selectedAnswer.text));
            clip.blessing_anim.graphics.visible = true;
            clip.blessing_anim.playOnceAndHide();
            clip.blessing_anim.graphics.touchable = false;
         }
         else
         {
            _loc7_ = null;
            _loc9_ = mediator.question.answers.length;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               if(mediator.question.answers[_loc6_].id == param1.correctAnswer)
               {
                  _loc7_ = mediator.question.answers[_loc6_];
               }
               _loc6_++;
            }
            _loc4_ = !!_loc7_?_loc7_.text:"?";
            clip.tf_answer_info.text = clip.tf_answer_info.text + Translate.translateArgs("UI_QUIZ_QUESTION_POPUP_INCORRECT",ColorUtils.addWhiteAndDefault(_selectedAnswer.text),ColorUtils.addWhiteAndDefault(_loc4_));
         }
         clip.tf_answer_info.text = clip.tf_answer_info.text + "\n";
         clip.tf_answer_info.text = clip.tf_answer_info.text + Translate.translateArgs("UI_QUIZ_QUESTION_POPUP_REWARD",param1.reward.quizPoints,_loc2_);
         clip.layout_reward.visible = true;
         clip.layout_time.visible = false;
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         clip.button_confirm.graphics.visible = false;
         clip.button_continue.graphics.visible = true;
         _loc3_ = clip.answer.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            clip.answer[_loc5_].graphics.touchable = false;
            if(clip.answer[_loc5_].data.id == param1.correctAnswer)
            {
               clip.answer[_loc5_].setState("STATE_CORRECT");
            }
            if(clip.answer[_loc5_].data.id == _selectedAnswer.id && !param1.isCorrect)
            {
               clip.answer[_loc5_].setState("STATE_INCORRECT");
            }
            _loc5_++;
         }
      }
      
      private function handler_timer() : void
      {
         clip.layout_time.graphics.visible = mediator.timerString;
         if(mediator.timerString != "")
         {
            clip.tf_timed_points.text = mediator.timerString;
         }
      }
   }
}
