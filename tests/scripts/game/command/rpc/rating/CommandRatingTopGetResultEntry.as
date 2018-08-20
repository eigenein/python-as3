package game.command.rpc.rating
{
   import com.progrestar.common.lang.Translate;
   
   public class CommandRatingTopGetResultEntry
   {
       
      
      protected var _place:int;
      
      protected var _ratingValue:int;
      
      public function CommandRatingTopGetResultEntry(param1:int, param2:int)
      {
         super();
         _place = param1;
         _ratingValue = param2;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function get ratingValue() : String
      {
         return String(_ratingValue);
      }
      
      public function get ratingValueLabel() : String
      {
         return "";
      }
      
      public function get name() : String
      {
         return Translate.translate("UI_COMMON_USR_NO_NAME");
      }
      
      public function get hasLevel() : Boolean
      {
         return false;
      }
      
      public function get levelString() : String
      {
         return "";
      }
      
      public function get noLevelString() : String
      {
         return "";
      }
   }
}
