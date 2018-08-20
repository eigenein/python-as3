package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.model.user.Player;
   import game.util.TimeFormatter;
   import org.osflash.signals.Signal;
   
   public class PlayerSpecialOfferWithTimer extends PlayerSpecialOfferEntry
   {
       
      
      protected var _endTime:int;
      
      protected var endAlarm:AlarmEvent;
      
      public function PlayerSpecialOfferWithTimer(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      public function set unsafeEndTime(param1:int) : void
      {
         _endTime = param1;
      }
      
      public function get isOver() : Boolean
      {
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
         return _loc1_ <= 0;
      }
      
      public function get timerString() : String
      {
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
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
      
      public function get redMarkerVisible() : Boolean
      {
         return false;
      }
      
      public function get timerStringDHorHMS() : String
      {
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
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
      
      public function get timerStringConstrained() : String
      {
         if(someDaysLeft)
         {
            return daysLeftString;
         }
         return hmsLeftString;
      }
      
      public function get hmsTimeLeft() : String
      {
         var _loc2_:int = _endTime;
         var _loc1_:int = _loc2_ - GameTimer.instance.currentServerTime;
         if(_loc1_ <= 0)
         {
            return TimeFormatter.toMS2(0);
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      public function get someDaysLeft() : Boolean
      {
         return _endTime - GameTimer.instance.currentServerTime > 108000;
      }
      
      public function get moreThanOneDayLeft() : Boolean
      {
         return _endTime - GameTimer.instance.currentServerTime > 82800;
      }
      
      public function get hasEndTime() : Boolean
      {
         return _endTime != 0;
      }
      
      override public function get signal_updated() : Signal
      {
         return GameTimer.instance.oneSecTimer;
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         if(param1.endTime)
         {
            setEndTime(param1.endTime);
         }
         else
         {
            _endTime = 0;
            if(endAlarm)
            {
               GameTimer.instance.removeAlarm(endAlarm);
               endAlarm = null;
            }
         }
      }
      
      protected function get daysLeftString() : String
      {
         var _loc2_:int = 0;
         _loc2_ = 86400;
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
         return Translate.translateArgs("UI_SPECIALOFFER_DAYS_LEFT",Math.ceil(_loc1_ / 86400));
      }
      
      protected function get hmsLeftString() : String
      {
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      protected function get dhmLeftString() : String
      {
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      private function setEndTime(param1:int) : void
      {
         _endTime = param1;
         if(endAlarm)
         {
            GameTimer.instance.removeAlarm(endAlarm);
            endAlarm.time = param1;
         }
         else
         {
            endAlarm = new AlarmEvent(param1);
            endAlarm.callback = handler_endAlarm;
         }
         GameTimer.instance.addAlarm(endAlarm);
      }
      
      protected function handler_endAlarm() : void
      {
         player.specialOffer.specialOfferEnded(this);
      }
   }
}
