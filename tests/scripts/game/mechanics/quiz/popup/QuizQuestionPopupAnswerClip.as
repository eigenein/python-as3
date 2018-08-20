package game.mechanics.quiz.popup
{
   import engine.core.clipgui.GuiClipScale9Image;
   import game.mechanics.quiz.model.QuizAnswerValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   
   public class QuizQuestionPopupAnswerClip extends DataClipButton
   {
      
      public static const STATE_NORMAL:String = "STATE_NORMAL";
      
      public static const STATE_CORRECT:String = "STATE_CORRECT";
      
      public static const STATE_INCORRECT:String = "STATE_INCORRECT";
       
      
      public var tf_image_label:ClipLabel;
      
      public var tf_text_answer:ClipLabel;
      
      public var boring:GuiClipScale9Image;
      
      public var glow:GuiClipScale9Image;
      
      public var green:GuiClipScale9Image;
      
      public var red:GuiClipScale9Image;
      
      public var item_tile:QuizIconRenderer;
      
      public var layout_text_answer:ClipLayout;
      
      private var _data:QuizAnswerValueObject;
      
      private var _selected:Boolean;
      
      private var _state:String;
      
      public function QuizQuestionPopupAnswerClip()
      {
         tf_image_label = new ClipLabel();
         tf_text_answer = new ClipLabel();
         boring = new GuiClipScale9Image();
         glow = new GuiClipScale9Image();
         green = new GuiClipScale9Image();
         red = new GuiClipScale9Image();
         item_tile = new QuizIconRenderer();
         layout_text_answer = ClipLayout.horizontalMiddleCentered(4,tf_text_answer);
         super(QuizQuestionPopupAnswerClip);
      }
      
      public function get data() : QuizAnswerValueObject
      {
         return _data;
      }
      
      public function setData(param1:QuizAnswerValueObject) : void
      {
         this._data = param1;
         var _loc2_:* = param1.answerIcon;
         item_tile.graphics.visible = _loc2_;
         tf_image_label.visible = _loc2_;
         layout_text_answer.visible = !param1.answerIcon;
         if(param1.answerIcon)
         {
            item_tile.setData(param1.answerIcon);
            tf_image_label.text = param1.text;
         }
         else
         {
            tf_text_answer.text = param1.text;
         }
         selected = false;
         setState("STATE_NORMAL");
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         glow.graphics.visible = _selected;
      }
      
      public function setState(param1:String) : void
      {
         if(_state == param1)
         {
            return;
         }
         this._state = param1;
         boring.graphics.visible = param1 == "STATE_NORMAL";
         green.graphics.visible = param1 == "STATE_CORRECT";
         red.graphics.visible = param1 == "STATE_INCORRECT";
         var _loc2_:* = param1;
         if("STATE_NORMAL" !== _loc2_)
         {
            if("STATE_CORRECT" !== _loc2_)
            {
               if("STATE_INCORRECT" === _loc2_)
               {
                  selected = false;
                  graphics.touchable = false;
               }
            }
            else
            {
               selected = false;
               graphics.touchable = false;
            }
         }
         else
         {
            graphics.touchable = true;
         }
      }
      
      override protected function getClickData() : *
      {
         return this;
      }
   }
}
