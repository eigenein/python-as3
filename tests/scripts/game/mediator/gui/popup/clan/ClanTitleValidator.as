package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   
   public class ClanTitleValidator
   {
       
      
      private var _oldValue:String;
      
      private var _maxLength:int;
      
      private var _minLength:int;
      
      private var _regexp:RegExp;
      
      private var _message:String;
      
      private var _isValid:Boolean;
      
      public function ClanTitleValidator(param1:String = null)
      {
         super();
         _oldValue = param1;
         _maxLength = DataStorage.rule.clanRule.maxTitleLength;
         _minLength = DataStorage.rule.clanRule.minTitleLength;
         var _loc2_:String = DataStorage.rule.nicknameUpdate.regexp;
         var _loc3_:String = _loc2_.slice(1,_loc2_.lastIndexOf("/"));
         var _loc4_:String = _loc2_.slice(_loc2_.lastIndexOf("/") + 1);
         _regexp = new RegExp(_loc3_,_loc4_);
      }
      
      public function set oldValue(param1:String) : void
      {
         _oldValue = param1;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get isValid() : Boolean
      {
         return _isValid;
      }
      
      public function validate(param1:String) : Boolean
      {
         _isValid = check(param1);
         return check(param1);
      }
      
      private function check(param1:String) : Boolean
      {
         if(param1 == _oldValue)
         {
            _message = Translate.translate("UI_DIALOG_CLAN_EDIT_TITLE_VALIDATION_SAME");
            return false;
         }
         if(param1.length < _minLength)
         {
            _message = Translate.translate("UI_DIALOG_CLAN_EDIT_TITLE_VALIDATION_TOO_SHORT");
            return false;
         }
         if(param1.length > _maxLength)
         {
            _message = Translate.translate("UI_DIALOG_CLAN_EDIT_TITLE_VALIDATION_TOO_LONG");
            return false;
         }
         var _loc2_:Array = param1.toLowerCase().match(_regexp);
         if(_loc2_ && _loc2_.length > 0)
         {
            _message = Translate.translate("UI_DIALOG_NAME_CHANGE_INVALID_CHARECTERS");
            return false;
         }
         _message = "";
         return true;
      }
   }
}
