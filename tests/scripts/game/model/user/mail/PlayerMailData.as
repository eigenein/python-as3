package game.model.user.mail
{
   import flash.utils.Dictionary;
   import game.command.realtime.SocketClientEvent;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMailData
   {
       
      
      private var unreadMail:Dictionary;
      
      private var _updateRequired:Boolean;
      
      public const signal_newMail:Signal = new Signal();
      
      private var _signal_mailUpdated:Signal;
      
      private var player:Player;
      
      public function PlayerMailData(param1:Player)
      {
         super();
         this.player = param1;
         unreadMail = new Dictionary();
         _signal_mailUpdated = new Signal();
      }
      
      private function get uid() : String
      {
         return player.id;
      }
      
      public function get updateRequired() : Boolean
      {
         return _updateRequired;
      }
      
      public function get signal_mailUpdated() : Signal
      {
         return _signal_mailUpdated;
      }
      
      public function get hasImportantUpdate() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = unreadMail;
         for each(var _loc1_ in unreadMail)
         {
            if(_loc1_.type == "massImportant")
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasUnreadMail() : Boolean
      {
         if(_updateRequired)
         {
            return true;
         }
         var _loc3_:int = 0;
         var _loc2_:* = unreadMail;
         for each(var _loc1_ in unreadMail)
         {
            if(!_loc1_.read)
            {
               return true;
            }
         }
         return false;
      }
      
      public function init(param1:Object) : void
      {
         var _loc4_:* = null;
         var _loc9_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc10_:Object = param1.users;
         var _loc5_:Object = {};
         var _loc12_:int = 0;
         var _loc11_:* = _loc10_;
         for(var _loc8_ in _loc10_)
         {
            _loc4_ = _loc10_[_loc8_];
            _loc9_ = new UserInfo();
            _loc9_.parse(_loc4_);
            _loc5_[_loc8_] = _loc9_;
         }
         var _loc2_:Array = param1.letters as Array || [];
         var _loc3_:int = _loc2_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = new PlayerMailEntry(_loc2_[_loc6_]);
            _loc7_.user = _loc5_[_loc7_.senderId];
            unreadMail[_loc7_.id] = _loc7_;
            _loc6_++;
         }
         GameModel.instance.actionManager.messageClient.subscribe("newMail",onAsyncNewMail);
      }
      
      public function update(param1:Object) : void
      {
         var _loc8_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = null;
         _updateRequired = false;
         var _loc9_:Object = param1.users;
         var _loc11_:int = 0;
         var _loc10_:* = _loc9_;
         for each(var _loc4_ in _loc9_)
         {
            _loc8_ = new UserInfo();
            _loc8_.parse(_loc4_);
            _loc9_[_loc8_.id] = _loc8_;
         }
         var _loc2_:Array = param1.letters as Array || [];
         var _loc3_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc5_];
            if(!unreadMail[_loc6_.id])
            {
               _loc7_ = new PlayerMailEntry(_loc6_);
               _loc7_.user = _loc9_[_loc7_.senderId];
               unreadMail[_loc7_.id] = _loc7_;
            }
            _loc5_++;
         }
         _signal_mailUpdated.dispatch();
      }
      
      public function action_addUnknownMessage() : void
      {
         _updateRequired = true;
         player.mail.signal_mailUpdated.dispatch();
      }
      
      public function farmLetters(param1:Vector.<PlayerMailEntry>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            param1[_loc3_].deleteLetter();
            delete unreadMail[param1[_loc3_].id];
            _loc3_++;
         }
         _signal_mailUpdated.dispatch();
      }
      
      public function readLetter(param1:PlayerMailEntry) : void
      {
         if(param1.reward)
         {
            param1.markAsRead();
         }
         else
         {
            delete unreadMail[param1.id];
         }
         _signal_mailUpdated.dispatch();
      }
      
      private function _sortMail(param1:PlayerMailEntry, param2:PlayerMailEntry) : int
      {
         return param2.ctime - param1.ctime;
      }
      
      public function getList() : Vector.<PlayerMailEntry>
      {
         var _loc1_:Vector.<PlayerMailEntry> = new Vector.<PlayerMailEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = unreadMail;
         for each(var _loc2_ in unreadMail)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(_sortMail);
         return _loc1_;
      }
      
      private function onAsyncNewMail(param1:SocketClientEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         trace("onAsyncNewMail");
         trace(JSON.stringify(param1.data));
         try
         {
            _loc5_ = param1.data.body.pushUserId;
            if(uid != _loc5_)
            {
               return;
            }
            _loc3_ = param1.data.body.letter;
            _loc4_ = param1.data.body.user;
         }
         catch(error:Error)
         {
         }
         if(!_loc3_ || !_loc4_)
         {
            return;
         }
         var _loc2_:PlayerMailEntry = new PlayerMailEntry(_loc3_);
         var _loc6_:UserInfo = new UserInfo();
         _loc6_.parse(_loc4_);
         _loc2_.user = _loc6_;
         unreadMail[_loc2_.id] = _loc2_;
         _signal_mailUpdated.dispatch();
         signal_newMail.dispatch();
      }
   }
}
