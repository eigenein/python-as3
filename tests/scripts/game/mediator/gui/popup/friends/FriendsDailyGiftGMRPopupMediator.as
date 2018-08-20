package game.mediator.gui.popup.friends
{
   import game.command.rpc.friends.CommandSendDailyGift;
   import game.data.storage.DataStorage;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.model.user.quest.PlayerQuestEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.friends.FriendsDailyGiftGMRPopup;
   
   public class FriendsDailyGiftGMRPopupMediator extends PopupMediator
   {
       
      
      public var socialGiftsQuest:PlayerQuestEntry;
      
      public function FriendsDailyGiftGMRPopupMediator(param1:Player)
      {
         var _loc3_:int = 0;
         super(param1);
         var _loc2_:Vector.<PlayerQuestEntry> = param1.questData.getDailyList();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] && _loc2_[_loc3_].desc.farmCondition.stateFunc.ident == "socialGiftsSent")
            {
               socialGiftsQuest = _loc2_[_loc3_];
               break;
            }
            _loc3_++;
         }
      }
      
      public function get taskComplete() : Boolean
      {
         return !socialGiftsQuest || socialGiftsQuest && socialGiftsQuest.canFarm;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new FriendsDailyGiftGMRPopup(this);
         return _popup;
      }
      
      public function action_openShop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getShopById(9);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
      }
      
      public function action_sendGifts_requestsFirst() : void
      {
         var _loc1_:CommandSendDailyGift = GameModel.instance.actionManager.friends.sendGifts(new Vector.<PlayerFriendEntry>(),null);
         _loc1_.signal_complete.addOnce(handler_sendGiftsCmdComplete_close);
      }
      
      private function handler_sendGiftsCmdComplete_close(param1:CommandSendDailyGift) : void
      {
      }
   }
}
