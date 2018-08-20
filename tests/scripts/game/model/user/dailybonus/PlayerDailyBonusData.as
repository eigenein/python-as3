package game.model.user.dailybonus
{
   import game.data.storage.DataStorage;
   import game.data.storage.dailybonus.DailyBonusDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerDailyBonusData
   {
       
      
      private var _lastDayOfMonth:int;
      
      private var _availableVip:Boolean;
      
      private var _availableToday:Boolean;
      
      private var _year:String;
      
      private var _month:String;
      
      private var _day:int;
      
      private var _signal_update:Signal;
      
      public function PlayerDailyBonusData()
      {
         super();
         _signal_update = new Signal();
      }
      
      public function get availableDouble() : Boolean
      {
         return _availableVip;
      }
      
      public function get availableSingle() : Boolean
      {
         return _availableToday;
      }
      
      public function get year() : String
      {
         return _year;
      }
      
      public function get month() : String
      {
         return _month;
      }
      
      public function get day() : int
      {
         return _day;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function init(param1:Object) : void
      {
         var _loc5_:int = 0;
         _month = param1.month;
         _day = param1.currentDay;
         _availableVip = param1.availableVip;
         _availableToday = param1.availableToday;
         _year = param1.year;
         _lastDayOfMonth = param1.daysInMonth;
         var _loc4_:int = DataStorage.rule.dailyBonusMonthlyHeroList.getHeroIdByMonth(int(_month));
         var _loc3_:Vector.<DailyBonusDescription> = DataStorage.dailyBonus.getVector();
         var _loc2_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_[_loc5_].heroId = _loc4_;
            _loc5_++;
         }
         _signal_update.dispatch();
      }
      
      public function farmVip() : void
      {
         if(availableDouble)
         {
            _availableVip = false;
            _signal_update.dispatch();
         }
      }
      
      public function farmNormal() : void
      {
         if(availableSingle)
         {
            _availableToday = false;
            _signal_update.dispatch();
         }
      }
      
      public function getDescriptionVector() : Vector.<DailyBonusDescription>
      {
         var _loc1_:Vector.<DailyBonusDescription> = DataStorage.dailyBonus.getVector();
         _loc1_ = _loc1_.slice(0,_lastDayOfMonth);
         return _loc1_;
      }
   }
}
