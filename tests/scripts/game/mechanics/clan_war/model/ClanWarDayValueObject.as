package game.mechanics.clan_war.model
{
   import game.data.storage.DataStorage;
   import game.util.DateFormatter;
   
   public class ClanWarDayValueObject
   {
       
      
      private var _season:String;
      
      private var _day:int;
      
      public function ClanWarDayValueObject(param1:Object = null)
      {
         super();
         if(param1)
         {
            updateFromRawData(param1);
         }
      }
      
      public function get season() : String
      {
         return _season;
      }
      
      public function get day() : int
      {
         return _day;
      }
      
      public function get week() : int
      {
         var _loc3_:int = _season.slice(0,4);
         var _loc2_:int = _season.slice(4);
         var _loc1_:String = DataStorage.rule.clanWarRule.firstSeason;
         var _loc4_:int = _loc1_.slice(0,4);
         var _loc5_:int = _loc1_.slice(4);
         if(_loc3_ == _loc4_)
         {
            return _loc2_ - _loc5_ + 1;
         }
         return _loc2_;
      }
      
      public function get date() : String
      {
         var _loc3_:int = _season.slice(0,4);
         var _loc2_:int = _season.slice(4);
         var _loc1_:Date = new Date(_loc3_,0,0,0,0,0);
         while(_loc1_.day != 1)
         {
            _loc1_ = new Date(_loc1_.time + 86400000);
         }
         _loc1_ = new Date(_loc1_.time + (7 * (_loc2_ - 1) + (_day - 1)) * 24 * 3600 * 1000);
         return DateFormatter.dateToDDMMYYYY(_loc1_);
      }
      
      public function updateFromRawData(param1:Object) : void
      {
         _season = param1.season;
         _day = param1.day;
      }
      
      public function isEqual(param1:ClanWarDayValueObject) : Boolean
      {
         return _day == param1._day && _season == param1._season;
      }
   }
}
