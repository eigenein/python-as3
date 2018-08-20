package game.model.user
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.rpc.player.CommandUserResetDay;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.GamePopupManager;
   import game.model.GameModel;
   import game.view.popup.MessagePopup;
   
   public class NextDayUpdatedManager
   {
       
      
      public function NextDayUpdatedManager()
      {
         super();
         updateAlarmEvent();
      }
      
      public static function simulateEndOfDayUserState(param1:*) : void
      {
         param1["dailyBonusGetInfo"] = JSON.parse("{\"year\":\"2016\",\"availableToday\":false,\"currentDay\":\"3\",\"month\":3,\"availableVip\":false}");
         param1["userGetInfo"].refillable = JSON.parse("[{\"lastRefill\":1459431451,\"id\":1,\"amount\":88,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":2,\"amount\":3,\"boughtToday\":10},{\"lastRefill\":1459431451,\"id\":3,\"amount\":3,\"boughtToday\":1},{\"lastRefill\":1459412916,\"id\":4,\"amount\":0,\"boughtToday\":1},{\"lastRefill\":1459431451,\"id\":5,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":6,\"amount\":2,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":7,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":3,\"amount\":1,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":10,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":11,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":12,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":13,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":14,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":15,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":16,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":17,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":19,\"amount\":0,\"boughtToday\":135},{\"lastRefill\":1459431451,\"id\":20,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":21,\"amount\":5,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":22,\"amount\":0,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":23,\"amount\":2,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":24,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":25,\"amount\":2,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":26,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":27,\"amount\":5,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":28,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":29,\"amount\":5,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":30,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":31,\"amount\":5,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":32,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":33,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":34,\"amount\":3,\"boughtToday\":0},{\"lastRefill\":1459431451,\"id\":35,\"amount\":3,\"boughtToday\":0}]");
         param1["questGetAll"] = JSON.parse("[{\"id\":36,\"state\":1,\"progress\":1},{\"id\":68,\"state\":1,\"progress\":28},{\"id\":76,\"state\":1,\"progress\":0},{\"id\":109,\"state\":2,\"progress\":10},{\"id\":13,\"state\":1,\"progress\":0},{\"id\":20,\"state\":1,\"progress\":0},{\"id\":90,\"state\":1,\"progress\":0},{\"id\":10001,\"state\":1,\"progress\":0},{\"id\":10002,\"state\":1,\"progress\":1},{\"id\":10003,\"state\":1,\"progress\":1},{\"id\":10004,\"state\":1,\"progress\":0},{\"id\":10006,\"state\":2,\"progress\":1},{\"id\":10007,\"state\":2,\"progress\":12},{\"id\":10009,\"state\":1,\"progress\":0},{\"id\":10010,\"state\":1,\"progress\":0},{\"id\":10011,\"state\":2,\"progress\":1},{\"id\":10015,\"state\":1,\"progress\":0},{\"id\":10016,\"state\":2,\"progress\":3},{\"id\":10018,\"state\":1,\"progress\":0}]");
         param1["mailGetAll"] = JSON.parse("{\"letters\":[{\"id\":\"10699\",\"params\":{\"lastBest\":\"285\",\"best\":\"280\"},\"ctime\":\"1459510045\",\"message\":\"\",\"type\":\"arena\",\"senderId\":\"-3\",\"read\":\"0\",\"reward\":{\"starmoney\":7}}],\"users\":{\"-3\":{\"experience\":141645,\"avatarId\":30,\"name\":\"Disposer\",\"id\":-3}}}");
      }
      
      private function updateAlarmEvent() : void
      {
         var _loc1_:AlarmEvent = new AlarmEvent(GameTimer.instance.nextDayTimestamp,"nextDayReset");
         _loc1_.callback = nextDayUpdate;
         GameTimer.instance.addAlarm(_loc1_);
      }
      
      private function nextDayUpdate() : void
      {
         GamePopupManager.closeAll();
         var _loc2_:String = "";
         var _loc3_:String = Translate.translate("UI_POPUP_MESSAGE_DAY_RESET");
         var _loc1_:MessagePopup = new MessagePopup(_loc3_,_loc2_);
         _loc1_.signal_okClose.add(handler_okClicked);
         PopUpManager.addPopUp(_loc1_);
      }
      
      private function handler_resetClientExecute(param1:CommandUserResetDay) : void
      {
         GameTimer.instance.nextDayTimestamp = param1.result.data.body.nextDayTs;
         updateAlarmEvent();
      }
      
      private function handler_okClicked(param1:MessagePopup) : void
      {
         var _loc2_:CommandUserResetDay = GameModel.instance.actionManager.playerCommands.userResetDay(GameModel.instance.player.levelData.level.level);
         _loc2_.onClientExecute(handler_resetClientExecute);
      }
   }
}
