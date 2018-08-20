package game.command.rpc.rating
{
   import com.progrestar.common.lang.Translate;
   import game.model.user.clan.ClanBasicInfoValueObject;
   
   public class CommandRatingTopGetResultNYTreeDecorateActionsEntry extends CommandRatingTopGetResultEntry
   {
       
      
      private var _clan:ClanBasicInfoValueObject;
      
      public function CommandRatingTopGetResultNYTreeDecorateActionsEntry(param1:int, param2:Object, param3:Object)
      {
         var _loc4_:int = param2.decorateActions;
         if(param3 is ClanBasicInfoValueObject)
         {
            _clan = param3 as ClanBasicInfoValueObject;
         }
         else if(param3)
         {
            _clan = new ClanBasicInfoValueObject(param3);
         }
         super(param1,_loc4_);
      }
      
      override public function get name() : String
      {
         if(!_clan)
         {
            return "";
         }
         return _clan.title;
      }
      
      override public function get hasLevel() : Boolean
      {
         return true;
      }
      
      override public function get levelString() : String
      {
         if(!_clan)
         {
            return "";
         }
         return Translate.translateArgs("UI_DIALOG_RATING_CLAN_MEMBERS_COUNT",_clan.membersCount);
      }
      
      override public function get ratingValueLabel() : String
      {
         if(!_clan)
         {
            return "";
         }
         return Translate.translate("UI_DIALOG_RATING_TYPE_DECORATE_ACTIONS");
      }
      
      public function get clan() : ClanBasicInfoValueObject
      {
         return _clan;
      }
   }
}
