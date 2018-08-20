package game.util
{
   import com.progrestar.common.lang.Translate;
   
   public class TimeDelayAbstract
   {
      
      public static const SECONDS_IN_A_DAY:int = 86400;
      
      public static const SECONDS_IN_AN_HOUR:int = 3600;
      
      public static const SECONDS_IN_A_MINUTE:int = 60;
       
      
      public function TimeDelayAbstract()
      {
         super();
      }
      
      public function get timeLeft() : int
      {
         return 0;
      }
      
      public function get toDHMorHMS() : String
      {
         var _loc1_:int = this.timeLeft;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > 86400)
         {
            return TimeFormatter.toDH(_loc1_,"{d} {h} {m}"," ",true);
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      public function get toDHorHMS() : String
      {
         var _loc1_:int = this.timeLeft;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > 86400)
         {
            return TimeFormatter.toDH(_loc1_,"{d} {h}"," ",true);
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      public function get toDHorHMorMS() : String
      {
         var _loc1_:int = this.timeLeft;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > 86400)
         {
            return TimeFormatter.toDH(_loc1_,"{d} {h}"," ",true);
         }
         if(_loc1_ > 3600)
         {
            return TimeFormatter.toDH(_loc1_,"{h}:{m}"," ",true);
         }
         return TimeFormatter.toDH(_loc1_,"{m}:{s}"," ",true);
      }
      
      public function get toDaysLeftOrHMS() : String
      {
         if(someDaysLeft)
         {
            return toDaysLeft;
         }
         return toHMS;
      }
      
      public function get toHMS() : String
      {
         var _loc1_:int = this.timeLeft;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      public function get toDaysLeft() : String
      {
         return Translate.translateArgs("UI_SPECIALOFFER_DAYS_LEFT",daysLeftCeil);
      }
      
      public function get someDaysLeft() : Boolean
      {
         return timeLeft > 30 * 3600;
      }
      
      public function get moreThanOneDayLeft() : Boolean
      {
         return timeLeft > 86400;
      }
      
      public function get toDaysOrHoursAndMinutes() : String
      {
         if(someDaysLeft)
         {
            return Translate.translateArgs("COMMON_UI_HOURS",daysLeftCeil);
         }
         var _loc1_:int = hoursLeft;
         var _loc2_:int = minutesLeftCeilMod;
         if(_loc2_ == 60)
         {
            _loc2_ = 0;
            _loc1_++;
         }
         if(_loc1_ > 0)
         {
            if(_loc2_ > 0)
            {
               return Translate.translateArgs("COMMON_UI_HOURS_MINUTES",_loc1_,_loc2_);
            }
            return Translate.translateArgs("COMMON_UI_HOURS",_loc1_);
         }
         if(_loc2_ > 1)
         {
            return Translate.translateArgs("COMMON_UI_MINUTES",_loc2_);
         }
         return TimeFormatter.toMS2(timeLeft);
      }
      
      public function get toDaysOrHoursOrMinutes() : String
      {
         if(someDaysLeft)
         {
            return Translate.translateArgs("COMMON_UI_HOURS",daysLeftCeil);
         }
         var _loc1_:int = hoursLeft;
         var _loc2_:int = minutesLeftCeilMod;
         if(_loc2_ == 60)
         {
            _loc2_ = 0;
            _loc1_++;
         }
         if(_loc1_ > 0)
         {
            return Translate.translateArgs("COMMON_UI_HOURS",_loc1_);
         }
         if(_loc2_ > 1)
         {
            return Translate.translateArgs("COMMON_UI_MINUTES",_loc2_);
         }
         return TimeFormatter.toMS2(timeLeft);
      }
      
      protected function get daysLeftCeil() : int
      {
         return Math.ceil(timeLeft / 86400);
      }
      
      protected function get hoursLeftCeil() : int
      {
         return Math.ceil(timeLeft / 3600);
      }
      
      protected function get hoursLeft() : int
      {
         return int(timeLeft / 3600);
      }
      
      protected function get minutesLeft() : int
      {
         return int(timeLeft / 60);
      }
      
      protected function get minutesLeftCeilMod() : int
      {
         return Math.ceil(timeLeft % 3600 / 60);
      }
   }
}
