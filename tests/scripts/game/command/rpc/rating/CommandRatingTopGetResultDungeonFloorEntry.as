package game.command.rpc.rating
{
   import com.progrestar.common.lang.Translate;
   
   public class CommandRatingTopGetResultDungeonFloorEntry extends CommandRatingTopGetResultUserEntry
   {
       
      
      public function CommandRatingTopGetResultDungeonFloorEntry(param1:int, param2:Object, param3:Object)
      {
         var _loc4_:int = !!param2?param2.maxFloorNum:0;
         super(param1,_loc4_,param3);
      }
      
      override public function get ratingValueLabel() : String
      {
         return Translate.translate("UI_DIALOG_RATING_TYPE_DUNGEON_FLOOR");
      }
   }
}
