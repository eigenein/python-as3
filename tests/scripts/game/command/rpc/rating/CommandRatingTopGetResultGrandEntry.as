package game.command.rpc.rating
{
   import com.progrestar.common.lang.Translate;
   
   public class CommandRatingTopGetResultGrandEntry extends CommandRatingTopGetResultArenaEntry
   {
       
      
      public function CommandRatingTopGetResultGrandEntry(param1:int, param2:Object, param3:Object)
      {
         super(param1,param2,param3);
      }
      
      override public function get ratingValueLabel() : String
      {
         return Translate.translate("UI_DIALOG_RATING_TYPE_GRAND_ARENA");
      }
   }
}
