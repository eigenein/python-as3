package game.data.storage.resource
{
   import com.progrestar.common.lang.Translate;
   
   public class ObtainNavigatorType
   {
       
      
      private var source:Object;
      
      private var _button_label:String;
      
      private var _mechanicIdent:String;
      
      private var _methodIdent:String;
      
      private var _not_enough_title:String;
      
      private var _not_enough_message:String;
      
      private var _mechanicIdentParams:Array;
      
      public function ObtainNavigatorType(param1:Object)
      {
         super();
         this.source = param1;
         if(param1)
         {
            if(param1.mechanic)
            {
               if(param1.mechanic.indexOf(":") != -1)
               {
                  _mechanicIdentParams = param1.mechanic.split(":");
                  _mechanicIdent = _mechanicIdentParams[0];
                  _mechanicIdentParams.splice(0,1);
               }
               else
               {
                  _mechanicIdent = param1.mechanic;
               }
            }
            if(param1.method)
            {
               _methodIdent = param1.method;
            }
            _button_label = param1.button_label;
            _not_enough_title = param1.not_enough_title;
            _not_enough_message = param1.not_enough_message;
         }
      }
      
      public function get mechanicIdent() : String
      {
         return _mechanicIdent;
      }
      
      public function get methodIdent() : String
      {
         return _methodIdent;
      }
      
      public function get not_enough_title() : String
      {
         return Translate.translate(_not_enough_title);
      }
      
      public function get not_enough_message() : String
      {
         return Translate.translate(_not_enough_message);
      }
      
      public function get mechanicIdentParams() : Array
      {
         return _mechanicIdentParams;
      }
      
      public function get navString() : String
      {
         if(_button_label)
         {
            return Translate.translate(_button_label);
         }
         if(_mechanicIdent)
         {
            return Translate.translate("LIB_MECHANIC_NAVIGATE_" + _mechanicIdent.toUpperCase());
         }
         return Translate.translate("UI_COMMON_OK");
      }
   }
}
