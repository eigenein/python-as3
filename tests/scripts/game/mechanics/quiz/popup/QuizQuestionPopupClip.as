package game.mechanics.quiz.popup
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class QuizQuestionPopupClip extends ClipAnimatedContainer
   {
       
      
      public var reward_1:InventoryItemRenderer;
      
      public var reward_2:InventoryItemRenderer;
      
      public var layout_reward_items:ClipLayout;
      
      public var button_continue:ClipButtonLabeled;
      
      public var tf_answer_info:SpecialClipLabel;
      
      public var layout_reward:ClipLayout;
      
      public var tf_timed_points:SpecialClipLabel;
      
      public var icon_time:ClipSprite;
      
      public var layout_time:ClipLayout;
      
      public var button_close:ClipButton;
      
      public var button_confirm:ClipButtonLabeled;
      
      public var quiz_button_inst0:ClipButton;
      
      public var question:QuizQuestionTextRenderer;
      
      public var answer:Vector.<QuizQuestionPopupAnswerClip>;
      
      public var blessing_anim:GuiAnimation;
      
      public function QuizQuestionPopupClip()
      {
         reward_1 = new InventoryItemRenderer();
         reward_2 = new InventoryItemRenderer();
         layout_reward_items = ClipLayout.horizontalMiddleCentered(4,reward_1,reward_2);
         button_continue = new ClipButtonLabeled();
         tf_answer_info = new SpecialClipLabel();
         layout_reward = ClipLayout.verticalMiddleCenter(4,tf_answer_info,layout_reward_items,button_continue);
         tf_timed_points = new SpecialClipLabel(true);
         icon_time = new ClipSprite();
         layout_time = ClipLayout.horizontalMiddleCentered(4,icon_time,tf_timed_points);
         button_close = new ClipButton();
         button_confirm = new ClipButtonLabeled();
         quiz_button_inst0 = new ClipButton();
         question = new QuizQuestionTextRenderer();
         answer = new Vector.<QuizQuestionPopupAnswerClip>();
         blessing_anim = new GuiAnimation();
         super();
      }
   }
}
