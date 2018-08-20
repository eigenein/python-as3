package game.model.user.quest
{
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import idv.cjcat.signals.Signal;
   
   public class PlayerQuestEventEntry
   {
       
      
      private var alarm:AlarmEvent;
      
      public var id:int;
      
      public var endTime:Number;
      
      public var icon:String;
      
      public var background:String;
      
      public var localeKey:String;
      
      public var sortOrder:int;
      
      private var _desc_localeKey:String;
      
      private var _name_localeKey:String;
      
      private var _signal_timeLeft:Signal;
      
      public function PlayerQuestEventEntry(param1:Object)
      {
         super();
         parseData(param1);
         updateAlarm();
         _signal_timeLeft = new Signal(PlayerQuestEventEntry);
      }
      
      public function get desc_localeKey() : String
      {
         return _desc_localeKey;
      }
      
      public function get name_localeKey() : String
      {
         return _name_localeKey;
      }
      
      public function get signal_timeLeft() : Signal
      {
         return _signal_timeLeft;
      }
      
      function applyUpdate(param1:Object) : void
      {
         parseData(param1);
         updateAlarm();
      }
      
      private function parseData(param1:Object) : void
      {
         if(param1)
         {
            this.id = param1.id;
            this.endTime = param1.endTime;
            this.icon = param1.icon;
            this.background = param1.background;
            this.localeKey = param1.localeKey;
            this.sortOrder = param1.sortOrder;
            _name_localeKey = param1.name_localeKey;
            _desc_localeKey = param1.desc_localeKey;
         }
      }
      
      private function updateAlarm() : void
      {
         if(alarm)
         {
            GameTimer.instance.removeAlarm(alarm);
            alarm.callback = null;
         }
         if(endTime > GameTimer.instance.currentServerTime)
         {
            alarm = new AlarmEvent(endTime);
            alarm.callback = onAlarmCallback;
            GameTimer.instance.addAlarm(alarm);
         }
      }
      
      private function onAlarmCallback() : void
      {
         _signal_timeLeft.dispatch(this);
      }
   }
}
