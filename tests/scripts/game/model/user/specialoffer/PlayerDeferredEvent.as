package game.model.user.specialoffer
{
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.util.TimeDelayAbstract;
   import org.osflash.signals.Signal;
   
   public class PlayerDeferredEvent extends TimeDelayAbstract
   {
       
      
      protected var _endTime:int;
      
      protected var endAlarm:AlarmEvent;
      
      private var _signal_complete:Signal;
      
      public function PlayerDeferredEvent()
      {
         super();
      }
      
      public function get signal_complete() : Signal
      {
         if(_signal_complete == null)
         {
            _signal_complete = new Signal();
            updateAlarm();
         }
         return _signal_complete;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      override public function get timeLeft() : int
      {
         return _endTime - GameTimer.instance.currentServerTime;
      }
      
      public function get hasPassed() : Boolean
      {
         return GameTimer.instance.currentServerTime > _endTime;
      }
      
      public function setEndTime(param1:int) : void
      {
         _endTime = param1;
         updateAlarm();
      }
      
      public function cancel() : void
      {
         _endTime = 0;
         if(endAlarm)
         {
            GameTimer.instance.removeAlarm(endAlarm);
            endAlarm.time = 0;
         }
      }
      
      protected function updateAlarm() : void
      {
         if(endAlarm)
         {
            GameTimer.instance.removeAlarm(endAlarm);
            endAlarm.time = _endTime;
         }
         if(_endTime > GameTimer.instance.currentServerTime && _signal_complete != null)
         {
            if(endAlarm == null)
            {
               endAlarm = new AlarmEvent(_endTime);
               endAlarm.callback = handler_endAlarm;
            }
            GameTimer.instance.addAlarm(endAlarm);
         }
      }
      
      private function handler_endAlarm() : void
      {
         if(_signal_complete)
         {
            _signal_complete.dispatch();
         }
      }
   }
}
