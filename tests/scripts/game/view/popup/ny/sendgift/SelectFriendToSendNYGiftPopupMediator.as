package game.view.popup.ny.sendgift
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.rpc.ny.CommandNYGiftSend;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.mediator.gui.popup.friends.SearchableFriendListPopupMediatorBase;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.ClanMemberValueObject;
   import game.model.user.friends.PlayerFriendEntry;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.ny.notenoughcoin.NotEnoughNYGiftCoinPopupMediator;
   import game.view.popup.ny.reward.NYRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class SelectFriendToSendNYGiftPopupMediator extends SearchableFriendListPopupMediatorBase
   {
      
      public static const TAB_ALL:String = "tab_all";
      
      public static const TAB_FRIENDS:String = "tab_friends";
      
      public static const TAB_GUILD:String = "tab_guild";
       
      
      private var gift:NYGiftDescription;
      
      private var valueObjectsAll:Vector.<FriendDataProvider>;
      
      public var signal_giftAmountChange:Signal;
      
      public var signal_receiverChange:Signal;
      
      private var _selectedFriend:FriendDataProvider;
      
      private var _giftAmount:uint = 1;
      
      private var _tabs:Vector.<String>;
      
      private var _selectedTabIndex:int;
      
      private var _signal_tabChange:Signal;
      
      public function SelectFriendToSendNYGiftPopupMediator(param1:Player, param2:NYGiftDescription)
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = undefined;
         var _loc7_:int = 0;
         signal_giftAmountChange = new Signal();
         signal_receiverChange = new Signal();
         super(param1);
         this.gift = param2;
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
         var _loc8_:Object = {};
         valueObjectsAll = new Vector.<FriendDataProvider>();
         _loc5_ = new FriendToSendNYGiftVO(new PlayerFriendEntry(null,GameModel.instance.context.platformFacade.user,param1.getUserInfo()));
         _loc5_.type = 0;
         valueObjectsAll.push(_loc5_);
         _loc8_[_loc5_.userInfo.id] = _loc5_.userInfo.id;
         var _loc4_:Vector.<PlayerFriendEntry> = param1.friends.getAppFriends();
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = new FriendToSendNYGiftVO(_loc4_[_loc6_]);
            _loc5_.type = 1;
            if(_loc5_.player && _loc5_.userInfo)
            {
               if(_loc5_.userInfo.serverId == param1.serverId)
               {
                  valueObjectsAll.push(_loc5_);
                  _loc8_[_loc5_.userInfo.id] = _loc5_.userInfo.id;
               }
            }
            _loc6_++;
         }
         if(param1.clan.clan)
         {
            _loc3_ = param1.clan.clan.members;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               if(_loc3_[_loc7_].id != param1.id)
               {
                  _loc5_ = new FriendToSendNYGiftVO(new PlayerFriendEntry(null,null,_loc3_[_loc7_]));
                  _loc5_.type = 2;
                  _loc5_.repeated = _loc8_[_loc3_[_loc7_].id] != null;
                  if(_loc5_.player && _loc5_.userInfo)
                  {
                     valueObjectsAll.push(_loc5_);
                     _loc8_[_loc5_.userInfo.id] = _loc5_.userInfo.id;
                  }
               }
               _loc7_++;
            }
         }
         _tabs = new Vector.<String>();
         _tabs.push("tab_all");
         _tabs.push("tab_friends");
         if(param1.clan.clan)
         {
            _tabs.push("tab_guild");
         }
         _selectedTabIndex = 0;
         _signal_tabChange = new Signal();
         filterData();
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_clanUpdate.remove(handler_clanUpdate);
         super.dispose();
      }
      
      public function get selectedFriend() : FriendDataProvider
      {
         return _selectedFriend;
      }
      
      public function set selectedFriend(param1:FriendDataProvider) : void
      {
         if(_selectedFriend == param1)
         {
            return;
         }
         _selectedFriend = param1;
         signal_receiverChange.dispatch();
      }
      
      public function get selectedSelf() : Boolean
      {
         return _selectedFriend && _selectedFriend.userInfo.id == player.id;
      }
      
      public function get giftAmount() : uint
      {
         return _giftAmount;
      }
      
      public function set giftAmount(param1:uint) : void
      {
         if(giftAmount == param1)
         {
            return;
         }
         _giftAmount = param1;
         signal_giftAmountChange.dispatch();
      }
      
      public function get giftTitle() : String
      {
         return gift.name;
      }
      
      public function get presentPrice() : InventoryItem
      {
         return new InventoryItem(gift.cost.outputDisplayFirst.item,gift.cost.outputDisplayFirst.amount * giftAmount);
      }
      
      public function get dailyHeroReward() : InventoryItem
      {
         return new InventoryItem(gift.senderReward.outputDisplay[0].item,gift.senderReward.outputDisplay[0].amount * giftAmount);
      }
      
      public function get eventHeroReward() : InventoryItem
      {
         if(gift.senderReward.outputDisplay.length > 1)
         {
            return new InventoryItem(gift.senderReward.outputDisplay[1].item,gift.senderReward.outputDisplay[1].amount * giftAmount);
         }
         return null;
      }
      
      public function get playerServerId() : int
      {
         return player.serverId;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get selectedTabIndex() : int
      {
         return _selectedTabIndex;
      }
      
      public function set selectedTabIndex(param1:int) : void
      {
         _selectedTabIndex = param1;
      }
      
      public function get signal_tabChange() : Signal
      {
         return _signal_tabChange;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SelectFriendToSendNYGiftPopup(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_gift_coin"));
         return _loc1_;
      }
      
      public function getTabVisibleByID(param1:String) : Boolean
      {
         if(param1 == "tab_all")
         {
            return false;
         }
         if(param1 == "tab_friends")
         {
            return false;
         }
         if(param1 == "tab_guild")
         {
            return false;
         }
         return false;
      }
      
      public function action_sendGift() : void
      {
         var _loc2_:* = null;
         var _loc1_:CostData = new CostData();
         _loc1_.addInventoryItem(gift.cost.outputDisplayFirst.item,gift.cost.outputDisplayFirst.amount * giftAmount);
         if(player.canSpend(_loc1_))
         {
            if(gift && selectedFriend)
            {
               _loc2_ = new CommandNYGiftSend(selectedFriend.userInfo,gift,giftAmount);
               _loc2_.signal_complete.add(handler_giftSend);
               GameModel.instance.actionManager.executeRPCCommand(_loc2_);
            }
         }
         else
         {
            new NotEnoughNYGiftCoinPopupMediator(player).open(_popup.stashParams);
         }
      }
      
      override public function action_searchUpdate(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         param1 = param1.toLowerCase();
         var _loc2_:Vector.<FriendDataProvider> = new Vector.<FriendDataProvider>();
         var _loc3_:int = valueObjects.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = valueObjects[_loc5_];
            if(param1 == "" || _loc4_.name.toLowerCase().indexOf(param1) != -1 || _loc4_.nickname.toLowerCase().indexOf(param1) != -1 || _loc4_.userInfo.id.indexOf(param1) != -1)
            {
               _loc2_.push(_loc4_);
            }
            _loc5_++;
         }
         _friendList = new ListCollection(_loc2_);
         _signal_updateData.dispatch(param1 == "");
      }
      
      public function incrementPresentAmount() : void
      {
         giftAmount = Number(giftAmount) + 1;
      }
      
      public function decrementPresentAmount() : void
      {
      }
      
      private function handler_giftSend(param1:CommandNYGiftSend) : void
      {
         var _loc2_:String = Translate.translate("UI_DIALOG_SEND_NY_GIFT_REWARD_TITLE");
         PopUpManager.addPopUp(new NYRewardPopup(_loc2_,param1.reward.outputDisplay));
         close();
      }
      
      private function filterData() : void
      {
         switch(int(selectedTabIndex))
         {
            case 0:
               valueObjects = valueObjectsAll.filter(filter_all);
               break;
            case 1:
               valueObjects = valueObjectsAll.filter(filter_friends);
               break;
            case 2:
               valueObjects = valueObjectsAll.filter(filter_guild);
         }
         _friendList = new ListCollection(valueObjects);
         _signal_updateData.dispatch(true);
      }
      
      private function filter_all(param1:FriendDataProvider, param2:int, param3:Vector.<FriendDataProvider>) : Boolean
      {
         return !(param1 as FriendToSendNYGiftVO).repeated;
      }
      
      private function filter_friends(param1:FriendDataProvider, param2:int, param3:Vector.<FriendDataProvider>) : Boolean
      {
         return (param1 as FriendToSendNYGiftVO).type == 1;
      }
      
      private function filter_guild(param1:FriendDataProvider, param2:int, param3:Vector.<FriendDataProvider>) : Boolean
      {
         return (param1 as FriendToSendNYGiftVO).type == 2;
      }
      
      public function action_tabSelect(param1:int) : void
      {
         selectedTabIndex = param1;
         signal_tabChange.dispatch();
         filterData();
      }
      
      private function handler_clanUpdate() : void
      {
         if(player.clan.clan == null)
         {
            close();
         }
      }
   }
}
