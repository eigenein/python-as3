package game.model.user.quest
{
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   
   public class PlayerDayTimeQuestEntry extends PlayerQuestEntry
   {
      
      private static const secondsInAnHour:int = 3600;
      
      private static const secondsInADay:int = 86400;
      
      private static const serverSafetyDelayInSeconds:Number = 7;
      
      private static const clientSafetyDelayInSeconds:Number = 6;
       
      
      private var _playerQuestData:PlayerQuestData;
      
      private var alarms:Vector.<AlarmEvent>;
      
      public function PlayerDayTimeQuestEntry(param1:PlayerQuestData, param2:*)
      {
         alarms = new Vector.<AlarmEvent>();
         super(param2);
         this._playerQuestData = param1;
         setupUpdateHour(desc.farmCondition.functionArgs.startHour);
         setupUpdateHour(desc.farmCondition.functionArgs.endHour);
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = alarms;
         for each(var _loc1_ in alarms)
         {
            GameTimer.instance.removeAlarm(_loc1_);
         }
         alarms.length = 0;
      }
      
      override public function get progressCurrent() : int
      {
         return !!canFarm?1:0;
      }
      
      override public function get canFarm() : Boolean
      {
         var _loc2_:int = desc.farmCondition.functionArgs.startHour;
         var _loc1_:int = desc.farmCondition.functionArgs.endHour;
         var _loc3_:int = currentLocalHour;
         return _loc3_ >= _loc2_ && _loc3_ < _loc1_;
      }
      
      public function get sortValue() : int
      {
         var _loc1_:int = desc.farmCondition.functionArgs.startHour;
         if(currentLocalHour > _loc1_)
         {
            return -_loc1_;
         }
         return 24 - _loc1_;
      }
      
      protected function get currentLocalHour() : int
      {
         var _loc2_:int = GameModel.instance.player.timeZone;
         var _loc1_:int = GameTimer.instance.currentServerTime;
         var _loc3_:int = Math.floor((_loc1_ - 6) % 86400 / 3600) + _loc2_;
         while(_loc3_ < 0)
         {
            _loc3_ = _loc3_ + 24;
         }
         return _loc3_ % 24;
      }
      
      private function setupUpdateHour(param1:int) : void
      {
         var _loc3_:int = GameModel.instance.player.timeZone;
         var _loc4_:Number = int(GameTimer.instance.currentServerTime / 86400) * 86400;
         var _loc2_:Number = _loc4_ + param1 * 3600 - _loc3_ * 3600;
         while(GameTimer.instance.currentServerTime >= _loc2_)
         {
            _loc2_ = _loc2_ + 86400;
         }
         setupUpdateTimestamp(_loc2_ + 7);
      }
      
      private function setupUpdateTimestamp(param1:Number) : void
      {
         var _loc2_:AlarmEvent = new AlarmEvent(param1);
         _loc2_.callback = handler_updateState;
         _loc2_.data = _loc2_;
         alarms.push(_loc2_);
         GameTimer.instance.addAlarm(_loc2_);
      }
      
      private function handler_updateState(param1:AlarmEvent) : void
      {
         GameTimer.instance.removeAlarm(param1);
         var _loc2_:int = alarms.indexOf(param1);
         if(_loc2_ != -1)
         {
            alarms.splice(_loc2_,1);
         }
         setupUpdateTimestamp(param1.time + 86400);
         signal_progressUpdate.dispatch(this);
         _playerQuestData.signal_questProgress.dispatch(this);
      }
   }
}
