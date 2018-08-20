package game.mechanics.quiz.model
{
   import starling.textures.Texture;
   
   public class QuizAnswerValueObject
   {
       
      
      private var _icon:Texture;
      
      private var _frame:Texture;
      
      private var _text:String;
      
      private var _answerIcon:String;
      
      private var _id:int;
      
      public function QuizAnswerValueObject(param1:Object)
      {
         super();
         _text = param1.answerText;
         if(!_text)
         {
            _text = "";
         }
         if(_text.charCodeAt(0) == 8206)
         {
            _text = _text.substr(1);
         }
         _answerIcon = param1.answerIcon;
         _id = param1.id;
      }
      
      public function get icon() : Texture
      {
         return _icon;
      }
      
      public function get frame() : Texture
      {
         return _frame;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get answerIcon() : String
      {
         return _answerIcon;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
