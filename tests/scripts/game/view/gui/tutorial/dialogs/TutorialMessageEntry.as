package game.view.gui.tutorial.dialogs
{
   import com.progrestar.common.lang.Translate;
   
   public class TutorialMessageEntry
   {
       
      
      private var _id:int;
      
      private var _text:String;
      
      private var _icon:String;
      
      private var _position:String;
      
      private var _needButton:Boolean = false;
      
      public function TutorialMessageEntry(param1:*)
      {
         super();
         if(param1)
         {
            _id = param1.id;
            if(param1.param1 && param1.param2)
            {
               _text = Translate.translateArgs("LIB_TUTORIAL_TEXT_" + _id,Translate.translate(param1.param1),Translate.translate(param1.param2));
            }
            else if(param1.param1)
            {
               _text = Translate.translateArgs("LIB_TUTORIAL_TEXT_" + _id,Translate.translate(param1.param1));
            }
            else
            {
               _text = Translate.translate("LIB_TUTORIAL_TEXT_" + _id);
            }
            _position = param1.position;
            _icon = param1.icon;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get icon() : String
      {
         return _icon;
      }
      
      public function get position() : String
      {
         return _position;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function set icon(param1:String) : void
      {
         _icon = param1;
      }
      
      public function set position(param1:String) : void
      {
         _position = param1;
      }
      
      public function get needButton() : Boolean
      {
         return _needButton;
      }
      
      public function set needButton(param1:Boolean) : void
      {
         _needButton = param1;
      }
   }
}
