package game.model.user.mail
{
   import game.data.reward.RewardData;
   import game.model.user.UserInfo;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMailEntry
   {
       
      
      private var _id:int;
      
      private var _type:String;
      
      private var _senderId:String;
      
      private var _message:String;
      
      private var _reward:RewardData;
      
      private var _read:Boolean;
      
      private var _params:Object;
      
      private var _signal_deleted:Signal;
      
      private var _signal_updateReadStatus:Signal;
      
      private var _ctime:int;
      
      private var _availableUntil:int;
      
      public var user:UserInfo;
      
      public function PlayerMailEntry(param1:Object)
      {
         super();
         _signal_deleted = new Signal(PlayerMailEntry);
         _signal_updateReadStatus = new Signal(PlayerMailEntry);
         this._id = param1.id;
         this._type = param1.type;
         this._senderId = param1.senderId;
         this._message = param1.message;
         this._reward = new RewardData(param1.reward);
         this._ctime = int(param1.ctime);
         this._availableUntil = int(param1.availableUntil);
         if(_reward.isEmpty)
         {
            _reward = null;
         }
         if(param1.params is Array && (param1.params as Array).length == 0)
         {
            this._params = {};
         }
         else
         {
            this._params = param1.params;
         }
         this._read = int(param1.read);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get senderId() : String
      {
         return _senderId;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get read() : Boolean
      {
         return _read;
      }
      
      public function get params() : Object
      {
         return _params;
      }
      
      public function get signal_deleted() : Signal
      {
         return _signal_deleted;
      }
      
      public function get signal_updateReadStatus() : Signal
      {
         return _signal_updateReadStatus;
      }
      
      public function get ctime() : int
      {
         return _ctime;
      }
      
      public function get availableUntil() : int
      {
         return _availableUntil - 5;
      }
      
      function markAsRead() : void
      {
         _read = true;
         _signal_updateReadStatus.dispatch(this);
      }
      
      function deleteLetter() : void
      {
         _signal_deleted.dispatch(this);
      }
   }
}
