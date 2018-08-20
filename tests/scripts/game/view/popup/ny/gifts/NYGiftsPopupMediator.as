package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.command.rpc.ny.CommandNYGiftGet;
   import game.command.rpc.ny.CommandNYGiftOpen;
   import game.command.rpc.ny.CommandNYGiftSend;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.ny.NewYearGiftData;
   import game.view.popup.PopupBase;
   import game.view.popup.ny.NYPopupMediatorBase;
   import game.view.popup.ny.giftinfo.NYGiftInfoPopupMediator;
   import game.view.popup.ny.notenoughcoin.NotEnoughNYGiftCoinPopupMediator;
   import game.view.popup.ny.reward.NYRewardPopup;
   import game.view.popup.ny.sendgift.SelectFriendToSendNYGiftPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class NYGiftsPopupMediator extends NYPopupMediatorBase
   {
       
      
      public var gifts:Vector.<NewYearGiftData>;
      
      public var signal_giftsChange:Signal;
      
      public function NYGiftsPopupMediator(param1:Player)
      {
         gifts = new Vector.<NewYearGiftData>();
         signal_giftsChange = new Signal();
         super(param1);
         if(!param1.specialOffer.hasSpecialOffer("newYear2018"))
         {
            GameTimer.instance.oneSecTimer.remove(updateTime);
         }
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_gift_coin"));
         return _loc1_;
      }
      
      public function get sortedGiftsList() : Vector.<NYGiftDescription>
      {
         var _loc1_:Vector.<NYGiftDescription> = DataStorage.nyGifts.giftsList;
         _loc1_.sort(sortGifts);
         return _loc1_;
      }
      
      public function get dayHero() : HeroDescription
      {
         return DataStorage.hero.getHeroById(player.ny.dayHeroId);
      }
      
      public function get eventHero() : HeroDescription
      {
         return DataStorage.hero.getHeroById(player.ny.eventHeroId);
      }
      
      public function get tabsListCollection() : ListCollection
      {
         var _loc1_:ListCollection = new ListCollection();
         if(GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018"))
         {
            _loc1_.push(new NYGiftsPopupTabRendererVO(0,Translate.translate("UI_DIALOG_NY_GIFTS_TAB_SEND")));
         }
         _loc1_.push(new NYGiftsPopupTabRendererVO(1,Translate.translate("UI_DIALOG_NY_GIFTS_TAB_RECEIVED")));
         _loc1_.push(new NYGiftsPopupTabRendererVO(2,Translate.translate("UI_DIALOG_NY_GIFTS_TAB_SENDED")));
         return _loc1_;
      }
      
      public function get giftsToOpen() : uint
      {
         return player.ny.giftsToOpen;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new NYGiftsPopup(this);
         return _popup;
      }
      
      public function hasNewYearOffer() : Boolean
      {
         return GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018");
      }
      
      public function getGifts(param1:uint) : void
      {
         var _loc2_:CommandNYGiftGet = new CommandNYGiftGet(param1);
         _loc2_.signal_complete.add(handler_getGifts);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
      }
      
      public function action_showSelectFriendToSendGift(param1:NYGiftDescription) : void
      {
         new SelectFriendToSendNYGiftPopupMediator(player,param1).open(_popup.stashParams);
      }
      
      public function action_showNYGiftInfo(param1:NYGiftDescription) : void
      {
         new NYGiftInfoPopupMediator(player,param1).open(_popup.stashParams);
      }
      
      public function action_openHeroPopup(param1:HeroDescription) : void
      {
         new OpenHeroPopUpCommand(player,param1,_popup.stashParams).execute();
      }
      
      public function action_giftOpen(param1:NewYearGiftData) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = new CommandNYGiftOpen(param1);
            _loc2_.signal_complete.add(handler_getOpen);
            GameModel.instance.actionManager.executeRPCCommand(_loc2_);
         }
      }
      
      public function action_giftSend(param1:NewYearGiftData) : void
      {
         var _loc2_:* = null;
         if(player.canSpend(param1.desc.cost))
         {
            if(param1 && param1.from)
            {
               _loc2_ = new CommandNYGiftSend(param1.from,param1.desc,1,param1.id);
               _loc2_.userGiftId = param1.id;
               _loc2_.signal_complete.add(handler_giftSend);
               GameModel.instance.actionManager.executeRPCCommand(_loc2_);
            }
         }
         else
         {
            new NotEnoughNYGiftCoinPopupMediator(player).open(_popup.stashParams);
         }
      }
      
      private function handler_giftSend(param1:CommandNYGiftSend) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < gifts.length)
         {
            if(gifts[_loc3_].id == param1.userGiftId)
            {
               gifts[_loc3_].replyGiftId = param1.resultGiftIds[0];
            }
            _loc3_++;
         }
         var _loc2_:String = Translate.translate("UI_DIALOG_SEND_NY_GIFT_REWARD_TITLE");
         PopUpManager.addPopUp(new NYRewardPopup(_loc2_,param1.reward.outputDisplay));
      }
      
      private function handler_getOpen(param1:CommandNYGiftOpen) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < gifts.length)
         {
            _loc2_ = gifts[_loc3_];
            if(_loc2_ && _loc2_.id == param1.gift.id)
            {
               _loc2_.reward = new RewardData();
               _loc2_.reward.add(param1.reward);
               _loc2_.opened = true;
            }
            _loc3_++;
         }
      }
      
      private function handler_getGifts(param1:CommandNYGiftGet) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         param1.signal_complete.remove(handler_getGifts);
         gifts.length = 0;
         if(!param1.result.body)
         {
            return;
         }
         var _loc6_:Array = param1.result.body.gifts;
         if(_loc6_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc6_.length)
            {
               _loc2_ = new NewYearGiftData(_loc6_[_loc4_]);
               _loc2_.desc = DataStorage.nyGifts.getNYGifyById(_loc2_.libId);
               _loc2_.from = new UserInfo();
               _loc5_ = param1.result.body.users[_loc2_.fromId];
               _loc2_.from.parse(!!_loc5_?_loc5_:{});
               _loc2_.to = new UserInfo();
               _loc3_ = param1.result.body.users[_loc2_.toId];
               _loc2_.to.parse(!!_loc3_?_loc3_:{});
               _loc2_.fromMe = String(_loc2_.fromId) == player.id;
               if(_loc2_.from && _loc2_.to)
               {
                  gifts.push(_loc2_);
               }
               _loc4_++;
            }
            if(param1.requestType == 0)
            {
               gifts.sort(sortReceivedGifts);
            }
            else if(param1.requestType == 1)
            {
               gifts.sort(sortSendedGifts);
            }
         }
         signal_giftsChange.dispatch();
      }
      
      private function sortReceivedGifts(param1:NewYearGiftData, param2:NewYearGiftData) : int
      {
         if(!param1.opened && param2.opened)
         {
            return -1;
         }
         if(!param2.opened && param1.opened)
         {
            return 1;
         }
         return param2.ctime - param1.ctime;
      }
      
      private function sortSendedGifts(param1:NewYearGiftData, param2:NewYearGiftData) : int
      {
         return param2.ctime - param1.ctime;
      }
      
      private function sortGifts(param1:NYGiftDescription, param2:NYGiftDescription) : int
      {
         return param1.sortIndex - param2.sortIndex;
      }
   }
}
