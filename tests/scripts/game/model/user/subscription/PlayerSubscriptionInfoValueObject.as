package game.model.user.subscription
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.subscription.SubscriptionDescription;
   import game.model.GameModel;
   import org.osflash.signals.Signal;
   
   public class PlayerSubscriptionInfoValueObject
   {
       
      
      private var subscription:SubscriptionDescription;
      
      private var endTime:int;
      
      private var endLoginTime:int;
      
      private var status:int;
      
      private var testHC:Boolean = false;
      
      private var _pendingCancel:Boolean;
      
      private var _vkSubscriptionId:int;
      
      private var _currentLevel:IntPropertyWriteable;
      
      private var alarmEvent:AlarmEvent;
      
      private var _signal_update:Signal;
      
      public function PlayerSubscriptionInfoValueObject(param1:Object)
      {
         _currentLevel = new IntPropertyWriteable();
         _signal_update = new Signal();
         super();
         update(param1);
      }
      
      public function get pendingCancel() : Boolean
      {
         return _pendingCancel;
      }
      
      public function get vkSubscriptionId() : int
      {
         return _vkSubscriptionId;
      }
      
      public function get currentLevel() : IntProperty
      {
         return _currentLevel;
      }
      
      public function get isActive() : Boolean
      {
         return status == 1;
      }
      
      public function get isAuto() : Boolean
      {
         if(testHC)
         {
            return false;
         }
         return GameModel.instance.context.platformFacade.network == "vkontakte";
      }
      
      public function get isLastChanceToRenew() : Boolean
      {
         return endLoginTime != 0;
      }
      
      public function get isAvailableToProlong() : Boolean
      {
         return buyAvailable;
      }
      
      public function get daysLeft() : Number
      {
         var _loc2_:int = 0;
         _loc2_ = 86400;
         if(!subscription)
         {
            return 0;
         }
         var _loc1_:int = endTime - GameTimer.instance.currentServerTime;
         return _loc1_ / 86400;
      }
      
      public function get fullDaysLeft() : int
      {
         return int(daysLeft);
      }
      
      public function get hoursLeft() : int
      {
         var _loc2_:int = 0;
         _loc2_ = 3600;
         if(!subscription)
         {
            return 0;
         }
         var _loc1_:int = endTime - GameTimer.instance.currentServerTime;
         return _loc1_ / 3600;
      }
      
      public function get secondsLeft() : int
      {
         var _loc1_:int = 0;
         return endTime - GameTimer.instance.currentServerTime;
      }
      
      public function get secondsLeftToRenew() : int
      {
         var _loc1_:int = 0;
         if(isAuto)
         {
            _loc1_ = endTime - GameTimer.instance.currentServerTime;
         }
         else
         {
            _loc1_ = endTime - subscription.renewDuration * 24 * 60 * 60 - GameTimer.instance.currentServerTime;
         }
         return _loc1_;
      }
      
      public function get secondsLeftToRenewRed() : int
      {
         var _loc1_:int = endLoginTime - GameTimer.instance.currentServerTime;
         return _loc1_;
      }
      
      public function get localeTimeLeft() : String
      {
         return Translate.translateArgs("UI_DIALOG_BILLING_DAYS_LEFT",fullDaysLeft);
      }
      
      public function get hasCurrent() : Boolean
      {
         return subscription;
      }
      
      public function get current() : SubscriptionDescription
      {
         return subscription;
      }
      
      public function get buyAvailable() : Boolean
      {
         if(isActive)
         {
            if(isAuto)
            {
               return false;
            }
            return daysLeft <= subscription.renewDuration;
         }
         return true;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      function update(param1:Object) : void
      {
         if(alarmEvent)
         {
            GameTimer.instance.removeAlarm(alarmEvent);
            alarmEvent = null;
         }
         if(param1)
         {
            status = param1.status;
            subscription = DataStorage.subscription.getSubscriptionById(param1.type);
            endTime = param1.endTime;
            _vkSubscriptionId = param1.vkSubscriptionId;
            if(!endLoginTime)
            {
               _pendingCancel = param1.pendingCancel;
            }
            if(testHC)
            {
               endTime = GameTimer.instance.currentServerTime + 180;
            }
            _currentLevel.value = param1.level;
            endLoginTime = param1.endLoginTime;
            if(endLoginTime)
            {
               if(testHC)
               {
                  endLoginTime = GameTimer.instance.currentServerTime + 180;
               }
               alarmEvent = new AlarmEvent(endLoginTime,"PlayerSubscriptionInfoValueObject_subscriptionEnd");
               alarmEvent.callback = handler_updateAlarm;
               GameTimer.instance.addAlarm(alarmEvent);
            }
            else
            {
               alarmEvent = new AlarmEvent(endTime,"PlayerSubscriptionInfoValueObject_subscriptionEnd");
               alarmEvent.callback = handler_updateAlarm;
               GameTimer.instance.addAlarm(alarmEvent);
            }
         }
         else
         {
            status = 0;
            subscription = null;
            endTime = 0;
            _currentLevel.value = 0;
            endLoginTime = 0;
         }
         _signal_update.dispatch();
      }
      
      function action_VKResume() : void
      {
         _pendingCancel = false;
         _signal_update.dispatch();
      }
      
      private function handler_updateAlarm() : void
      {
         if(endLoginTime)
         {
            update(null);
         }
         else
         {
            if(!isAuto || pendingCancel)
            {
               endLoginTime = GameTimer.instance.currentServerTime + 86400;
               if(testHC)
               {
                  endLoginTime = GameTimer.instance.currentServerTime + 30;
               }
               alarmEvent = new AlarmEvent(endLoginTime,"PlayerSubscriptionInfoValueObject_subscriptionEnd");
               alarmEvent.callback = handler_updateAlarm;
               GameTimer.instance.addAlarm(alarmEvent);
               status = 3;
            }
            else
            {
               endTime = GameTimer.instance.currentServerTime + DataStorage.subscription.theSubscription.duration * 24 * 60 * 60;
               GameModel.instance.actionManager.playerCommands.specialOfferGetAll();
            }
            _signal_update.dispatch();
         }
      }
   }
}
