package game.mediator.gui.popup.friends
{
   import engine.context.platform.PlatformUser;
   import game.command.rpc.friends.CommandSendDailyGift;
   import game.command.social.CommandSocialSendRequest;
   import game.data.storage.DataStorage;
   import game.data.storage.notification.NotificationDescription;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.friends.FriendsDailyGiftPopup;
   import idv.cjcat.signals.Signal;
   
   public class FriendsDailyGiftPopupMediator extends PopupMediator
   {
       
      
      private var _signal_friendListUpdate:Signal;
      
      private var _appFriendList:Vector.<FriendDataProvider>;
      
      private var _notAppFriendList:Vector.<FriendDataProvider>;
      
      private var _friendList:Vector.<PlayerFriendEntry>;
      
      public function FriendsDailyGiftPopupMediator(param1:Player)
      {
         var _loc4_:int = 0;
         _signal_friendListUpdate = new Signal();
         super(param1);
         _friendList = param1.friends.getFriendsToSendGift();
         _friendList = shuffleFriends_friendEntry(_friendList);
         _friendList.sort(_sortFriends);
         _appFriendList = new Vector.<FriendDataProvider>();
         var _loc2_:int = _friendList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _appFriendList[_loc4_] = new FriendDataProvider(_friendList[_loc4_]);
            _loc4_++;
         }
         _notAppFriendList = new Vector.<FriendDataProvider>();
         var _loc3_:Vector.<PlayerFriendEntry> = param1.friends.getNotAppFriends();
         _loc2_ = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _notAppFriendList[_loc4_] = new FriendDataProvider(_loc3_[_loc4_]);
            _loc4_++;
         }
         _notAppFriendList = shuffleFriends_dataProvider(_notAppFriendList);
      }
      
      public function get signal_friendListUpdate() : Signal
      {
         return _signal_friendListUpdate;
      }
      
      public function get appFriendList() : Vector.<FriendDataProvider>
      {
         return _appFriendList;
      }
      
      public function get notAppFriendList() : Vector.<FriendDataProvider>
      {
         return _notAppFriendList;
      }
      
      public function get friendList() : Vector.<PlayerFriendEntry>
      {
         return _friendList;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new FriendsDailyGiftPopup(this);
         return _popup;
      }
      
      public function action_sendGifts() : void
      {
         var _loc1_:* = null;
         if(_friendList.length > 0)
         {
            _loc1_ = GameModel.instance.actionManager.friends.sendGifts(_friendList,null);
            _loc1_.signal_complete.addOnce(handler_sendGiftsCmdComplete_sendRequests);
            close();
         }
      }
      
      public function action_sendGifts_requestsFirst() : void
      {
         var _loc1_:CommandSocialSendRequest = command_sendRequests();
         _loc1_.onComplete.addOnce(handler_onRequestsSend_execRPC);
         _loc1_.onError.addOnce(handler_onRequestsSend_execRPC);
      }
      
      public function action_openShop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getShopById(9);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
      }
      
      public function action_inviteFriends() : void
      {
         Stash.click("invite",_popup.stashParams);
         GameModel.instance.actionManager.platform.inviteFriends();
      }
      
      protected function command_sendRequests() : CommandSocialSendRequest
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<PlatformUser> = new Vector.<PlatformUser>();
         var _loc2_:int = _friendList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_[_loc3_] = _friendList[_loc3_].platformUser;
            _loc3_++;
         }
         var _loc1_:NotificationDescription = DataStorage.notification.getByIdent("friendGift");
         return GameModel.instance.actionManager.platform.requestSend(_loc4_,_loc1_);
      }
      
      protected function command_sendRPC(param1:Vector.<String>) : CommandSendDailyGift
      {
         var _loc2_:* = null;
         if(_friendList.length > 0)
         {
            _loc2_ = GameModel.instance.actionManager.friends.sendGifts(_friendList,param1);
            return _loc2_;
         }
         return null;
      }
      
      private function shuffleFriends_friendEntry(param1:Vector.<PlayerFriendEntry>) : Vector.<PlayerFriendEntry>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function shuffleFriends_dataProvider(param1:Vector.<FriendDataProvider>) : Vector.<FriendDataProvider>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function _sortFriends(param1:PlayerFriendEntry, param2:PlayerFriendEntry) : int
      {
         return param1.requestSortValue - param2.requestSortValue;
      }
      
      private function _onSingleGiftSent(param1:CommandSendDailyGift) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _appFriendList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_appFriendList[_loc3_].player == param1.friends[0])
            {
               _appFriendList.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         _signal_friendListUpdate.dispatch();
      }
      
      private function handler_sendGiftsCmdComplete_sendRequests(param1:CommandSendDailyGift) : void
      {
         command_sendRequests();
      }
      
      private function handler_sendGiftsCmdComplete_close(param1:CommandSendDailyGift) : void
      {
         close();
      }
      
      private function handler_onRequestsSend_execRPC(param1:CommandSocialSendRequest) : void
      {
         var _loc2_:CommandSendDailyGift = command_sendRPC(!!param1.result?param1.result.uids:null);
         if(_loc2_)
         {
            _loc2_.signal_complete.addOnce(handler_sendGiftsCmdComplete_close);
         }
      }
   }
}
