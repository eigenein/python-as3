package game.command.rpc.rating
{
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.arena.IUnitEntryValueObjectTeamProvider;
   
   public class CommandRatingTopGetResultArenaEntry extends CommandRatingTopGetResultUserEntry implements IUnitEntryValueObjectTeamProvider
   {
      
      private static const HIDDEN_TEAM:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>(0);
       
      
      private var _heroes:Vector.<Vector.<UnitEntryValueObject>>;
      
      public function CommandRatingTopGetResultArenaEntry(param1:int, param2:Object, param3:Object)
      {
         _heroes = new Vector.<Vector.<UnitEntryValueObject>>(0);
         var _loc4_:int = !!param2?param2.place:0;
         super(param1,_loc4_,param3);
         if(param2.heroes)
         {
            parseHeroes(param2.heroes);
         }
      }
      
      override public function get ratingValue() : String
      {
         return _ratingValue != 0?String(_ratingValue):"?";
      }
      
      override public function get ratingValueLabel() : String
      {
         return Translate.translate("UI_DIALOG_RATING_TYPE_FULL_ARENA");
      }
      
      public function get hasTeams() : Boolean
      {
         return _heroes.length > 0;
      }
      
      public function getTeam(param1:int) : Vector.<UnitEntryValueObject>
      {
         return param1 < _heroes.length?_heroes[param1]:HIDDEN_TEAM;
      }
      
      protected function parseHeroes(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _heroes = new Vector.<Vector.<UnitEntryValueObject>>(0);
         if(param1[0] is Array)
         {
            _loc3_ = param1.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               parseTeam(param1[_loc2_]);
               _loc2_++;
            }
         }
         else
         {
            parseTeam(param1);
         }
      }
      
      private function parseTeam(param1:*) : void
      {
         var _loc3_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>(0);
         _heroes.push(_loc3_);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(UnitUtils.createEntryValueObjectFromRawData(_loc2_));
         }
      }
   }
}
