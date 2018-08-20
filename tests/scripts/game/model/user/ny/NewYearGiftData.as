package game.model.user.ny
{
   import game.data.reward.RewardData;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.model.user.UserInfo;
   import idv.cjcat.signals.Signal;
   
   public class NewYearGiftData
   {
       
      
      private var reason:String;
      
      public var id:int;
      
      public var libId:int;
      
      public var ctime:Number;
      
      public var desc:NYGiftDescription;
      
      public var fromId:int;
      
      public var toId:int;
      
      public var from:UserInfo;
      
      public var to:UserInfo;
      
      public var reward:RewardData;
      
      private var _replyGiftId:int;
      
      private var _opened:Boolean;
      
      private var _fromMe:Boolean;
      
      public var signal_giftOpenedChange:Signal;
      
      public var signal_giftReplayGiftIdChange:Signal;
      
      public function NewYearGiftData(param1:Object)
      {
         signal_giftOpenedChange = new Signal();
         signal_giftReplayGiftIdChange = new Signal();
         super();
         this.id = param1.id;
         this.libId = param1.libId;
         this.ctime = param1.ctime;
         this.fromId = param1.from;
         this.toId = param1.to;
         this.replyGiftId = param1.replayGiftId;
         _opened = Boolean(int(param1.opened));
         if(param1.reward)
         {
            this.reward = new RewardData(param1.reward);
         }
         reason = param1.reason;
      }
      
      public function get replyGiftId() : int
      {
         return _replyGiftId;
      }
      
      public function set replyGiftId(param1:int) : void
      {
         if(_replyGiftId == param1)
         {
            return;
         }
         _replyGiftId = param1;
         signal_giftReplayGiftIdChange.dispatch();
      }
      
      public function get opened() : Boolean
      {
         return _opened;
      }
      
      public function set opened(param1:Boolean) : void
      {
         if(_opened == param1)
         {
            return;
         }
         _opened = param1;
         signal_giftOpenedChange.dispatch();
      }
      
      public function get senderIsWendy() : Boolean
      {
         return fromId < 0;
      }
      
      public function get senderIsWiped() : Boolean
      {
         return from.id == null;
      }
      
      public function get hasReplyGift() : Boolean
      {
         return replyGiftId > 0;
      }
      
      public function get fromMe() : Boolean
      {
         return _fromMe;
      }
      
      public function set fromMe(param1:Boolean) : void
      {
         _fromMe = param1;
      }
      
      public function get reason_isDaily() : Boolean
      {
         return senderIsWendy && reason && reason.indexOf("quest") != -1;
      }
      
      public function get reason_isTreeLevel() : Boolean
      {
         return senderIsWendy && reason && reason.indexOf("2018treeLevel_") != -1;
      }
      
      public function get treeLevel() : int
      {
         var _loc1_:* = null;
         if(reason)
         {
            _loc1_ = reason.split("_");
            return _loc1_[1];
         }
         return 0;
      }
   }
}
