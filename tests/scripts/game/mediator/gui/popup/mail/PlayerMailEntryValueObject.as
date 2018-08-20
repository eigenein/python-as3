package game.mediator.gui.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.model.user.friends.PlayerFriendEntry;
   import game.model.user.mail.PlayerMailEntry;
   import game.util.TimeFormatter;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMailEntryValueObject
   {
       
      
      private var _mail:PlayerMailEntry;
      
      private var _reward:RewardData;
      
      private var _signal_deleted:Signal;
      
      public var title:String;
      
      public var text:String;
      
      public var playerFriend:PlayerFriendEntry;
      
      private var _canMassFarm:Boolean;
      
      private var _isImportant:Boolean;
      
      public function PlayerMailEntryValueObject(param1:PlayerMailEntry)
      {
         super();
         this._mail = param1;
         _mail.signal_deleted.add(onMailDeleted);
         if(_mail.reward && !_mail.reward.isEmpty)
         {
            _reward = _mail.reward;
         }
         _signal_deleted = new Signal(PlayerMailEntryValueObject);
         _isImportant = param1.type == "massImportant";
         _canMassFarm = DataStorage.mailType.canMassFarm(param1.type);
      }
      
      public function dispose() : void
      {
         _mail.signal_deleted.remove(onMailDeleted);
      }
      
      public function get mail() : PlayerMailEntry
      {
         return _mail;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get signal_deleted() : Signal
      {
         return _signal_deleted;
      }
      
      public function get date() : String
      {
         return TimeFormatter.timeStampToDateStr(_mail.ctime);
      }
      
      public function get userName() : String
      {
         return !!_mail.user?_mail.user.nickname:"";
      }
      
      public function get avatar() : PlayerAvatarDescription
      {
         if(_mail.user)
         {
            return DataStorage.playerAvatar.getAvatarById(_mail.user.avatarId);
         }
         return null;
      }
      
      public function get canMassFarm() : Boolean
      {
         return _canMassFarm;
      }
      
      public function get isImportant() : Boolean
      {
         return _isImportant;
      }
      
      public function get hasTimeLimit() : Boolean
      {
         return _mail.availableUntil > 0;
      }
      
      public function get farmIsAvailable() : Boolean
      {
         return !hasTimeLimit || GameTimer.instance.currentServerTime < _mail.availableUntil;
      }
      
      public function get timeLeftString() : String
      {
         var _loc3_:int = 0;
         _loc3_ = 86400;
         var _loc1_:int = 0;
         var _loc2_:int = _mail.availableUntil - GameTimer.instance.currentServerTime;
         if(_loc2_ > 108000)
         {
            _loc1_ = Math.ceil(_loc2_ / _loc3_);
            if(Translate.has("UI_DIALOG_MAIL_AVAILABLE_DAYS"))
            {
               return Translate.translateArgs("UI_DIALOG_MAIL_AVAILABLE_DAYS",_loc1_);
            }
            return "";
         }
         if(_loc2_ > 3600)
         {
            if(Translate.has("UI_DIALOG_MAIL_AVAILABLE_HOURS"))
            {
               return Translate.translateArgs("UI_DIALOG_MAIL_AVAILABLE_HOURS",int(_loc2_ / 3600));
            }
            return "";
         }
         if(_loc2_ > 0)
         {
            if(Translate.has("UI_DIALOG_MAIL_AVAILABLE_TIMER"))
            {
               return Translate.translateArgs("UI_DIALOG_MAIL_AVAILABLE_TIMER",TimeFormatter.toString(_loc2_));
            }
            return "";
         }
         return Translate.translate("UI_POPUP_MAIL_REWARD_DELETED");
      }
      
      private function onMailDeleted(param1:PlayerMailEntry) : void
      {
         _signal_deleted.dispatch(this);
      }
   }
}
