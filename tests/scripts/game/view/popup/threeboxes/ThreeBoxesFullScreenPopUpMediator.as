package game.view.popup.threeboxes
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.threebox.CommandLootBoxBuy;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.loot.LootBoxDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.model.user.specialoffer.PlayerSpecialOfferLootBox;
   import game.model.user.specialoffer.PlayerSpecialOfferThreeBoxes;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.threeboxes.reward.LootBoxRewardPopupMediator;
   import game.view.popup.threeboxes.reward.LootBoxRewardVO;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ThreeBoxesFullScreenPopUpMediator extends PopupMediator
   {
       
      
      private var offer:PlayerSpecialOfferThreeBoxes;
      
      private var currentBoxRefillable:PlayerRefillableEntry;
      
      private var _currentBox:PlayerSpecialOfferLootBox;
      
      public var signalTimerUpdate:Signal;
      
      public var signalRefillableUpdate:Signal;
      
      private var _currentBoxAvailableNextFreeIn:int;
      
      public function ThreeBoxesFullScreenPopUpMediator(param1:Player, param2:PlayerSpecialOfferThreeBoxes)
      {
         signalTimerUpdate = new Signal(String);
         signalRefillableUpdate = new Signal();
         super(param1);
         this.offer = param2;
         GameTimer.instance.oneSecTimer.add(updateTime);
      }
      
      public function get currentBox() : PlayerSpecialOfferLootBox
      {
         return _currentBox;
      }
      
      public function set currentBox(param1:PlayerSpecialOfferLootBox) : void
      {
         if(_currentBox == param1)
         {
            return;
         }
         _currentBox = param1;
         if(currentBox)
         {
            currentBoxRefillable = player.refillable.getById(currentBox.refillable);
         }
      }
      
      public function get box1() : PlayerSpecialOfferLootBox
      {
         if(offer && offer.boxes.length > 0)
         {
            return offer.boxes[0];
         }
         return null;
      }
      
      public function get box2() : PlayerSpecialOfferLootBox
      {
         if(offer && offer.boxes.length > 1)
         {
            return offer.boxes[1];
         }
         return null;
      }
      
      public function get box3() : PlayerSpecialOfferLootBox
      {
         if(offer && offer.boxes.length > 2)
         {
            return offer.boxes[2];
         }
         return null;
      }
      
      public function get popupTitle() : String
      {
         if(offer)
         {
            return Translate.translate(offer.localeIdent);
         }
         return null;
      }
      
      public function get timerText() : String
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = null;
         var _loc1_:String = "";
         if(offer)
         {
            _loc3_ = offer.endTime - GameTimer.instance.currentServerTime;
            _loc2_ = "";
            if(_loc3_ > 86400)
            {
               _loc2_ = TimeFormatter.toDH(_loc3_,"{d} {h} {m}"," ",true);
            }
            else
            {
               _loc2_ = TimeFormatter.toDH(_loc3_,"{h}:{m}:{s}"," ",true);
            }
            _loc1_ = Translate.translateArgs("UI_DIALOG_THREE_BOXES_TIMER_TEXT",ColorUtils.hexToRGBFormat(16645626) + _loc2_);
         }
         return _loc1_;
      }
      
      public function get currentBoxAvailableNextFreeIn() : int
      {
         return _currentBoxAvailableNextFreeIn;
      }
      
      public function set currentBoxAvailableNextFreeIn(param1:int) : void
      {
         _currentBoxAvailableNextFreeIn = param1;
      }
      
      public function get currentBoxAvailableNextFreeAt() : int
      {
         if(currentBoxAvailableFreeToday > 0)
         {
            return currentBoxRefillable.lastRefill + currentBoxRefillable.desc.refillSeconds;
         }
         return GameTimer.instance.nextDayTimestamp;
      }
      
      public function get currentBoxAvailableFreeNow() : Boolean
      {
         if(currentBoxRefillable)
         {
            return currentBoxRefillable.canRefill && currentBoxRefillable.value > 0;
         }
         return false;
      }
      
      public function get currentBoxMaxFreeCount() : int
      {
         if(currentBoxRefillable)
         {
            return currentBoxRefillable.maxRefillCount;
         }
         return 0;
      }
      
      public function get currentBoxAvailableFreeToday() : int
      {
         if(currentBoxRefillable)
         {
            return currentBoxRefillable.maxRefillCount - currentBoxRefillable.refillCount;
         }
         return 0;
      }
      
      public function get currentBoxCooldownFormatted() : String
      {
         if(currentBoxAvailableFreeNow)
         {
            if(currentBoxMaxFreeCount <= 1)
            {
               return Translate.translate("UI_POPUP_CHEST_FREE_NOW");
            }
            return Translate.translateArgs("UI_POPUP_CHEST_FREE_NOW_AMT",currentBoxAvailableFreeToday,currentBoxMaxFreeCount);
         }
         if(currentBoxAvailableNextFreeIn > 0)
         {
            return Translate.translateArgs("UI_POPUP_CHEST_UNTIL_FREE",TimeFormatter.toMS2(currentBoxAvailableNextFreeIn) + "\n");
         }
         return "";
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ThreeBoxesFullScreenPopUp(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      override public function close() : void
      {
         GameTimer.instance.oneSecTimer.remove(updateTime);
         super.close();
      }
      
      public function getTitleByBox(param1:PlayerSpecialOfferLootBox) : String
      {
         if(param1)
         {
            return Translate.translate("LOOT_BOX_" + param1.id.toUpperCase());
         }
         return null;
      }
      
      public function getDropByBox(param1:PlayerSpecialOfferLootBox) : Vector.<InventoryItem>
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         if(param1)
         {
            _loc4_ = DataStorage.lootBox.getByIdent(param1.id) as LootBoxDescription;
            if(_loc4_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc4_.drop.length)
               {
                  _loc2_ = _loc2_.concat(_loc4_.drop[_loc3_].reward.outputDisplay);
                  _loc3_++;
               }
            }
         }
         _loc2_.sort(dropSort);
         return _loc2_;
      }
      
      public function getBoxAvailableFreeNowStatus(param1:PlayerSpecialOfferLootBox) : Boolean
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = player.refillable.getById(param1.refillable);
            return _loc2_.canRefill && _loc2_.value > 0;
         }
         return false;
      }
      
      public function action_boxBuy(param1:Boolean, param2:Boolean) : void
      {
         if(!offer || !currentBox)
         {
            return;
         }
         var _loc3_:CostData = null;
         if(!param1)
         {
            if(param2)
            {
               _loc3_ = currentBox.x10Cost;
            }
            else
            {
               _loc3_ = currentBox.x1Cost;
            }
         }
         var _loc4_:CommandLootBoxBuy = GameModel.instance.actionManager.lootBoxBuy(currentBox,offer.id,param1,param2,_loc3_);
         _loc4_.stashClick = Stash.click("lootBox open:" + currentBox.id + ":" + (!!param1?"free":_loc3_.starmoney),_popup.stashParams);
         _loc4_.signal_complete.add(onLootBoxBuy);
         HeroRewardPopupHandler.instance.hold();
      }
      
      private function dropSort(param1:InventoryItem, param2:InventoryItem) : int
      {
         if(param1.item is HeroDescription && !(param2.item is HeroDescription))
         {
            return -1;
         }
         if(!(param1.item is HeroDescription) && param2.item is HeroDescription)
         {
            return 1;
         }
         if(param1.item is ConsumableDescription && !(param2.item is ConsumableDescription))
         {
            return -1;
         }
         if(!(param1.item is ConsumableDescription) && param2.item is ConsumableDescription)
         {
            return 1;
         }
         if(param1.item.id < param2.item.id)
         {
            return -1;
         }
         if(param1.item.id > param2.item.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function onLootBoxBuy(param1:CommandLootBoxBuy) : void
      {
         var _loc2_:RewardValueObjectList = new RewardValueObjectList(param1.rewardList);
         var _loc3_:LootBoxRewardVO = new LootBoxRewardVO(player,param1.box,param1.pack,_loc2_);
         var _loc4_:LootBoxRewardPopupMediator = new LootBoxRewardPopupMediator(player,_loc3_);
         _loc4_.signal_reBuy.add(handler_chestReBuy);
         _loc4_.open(param1.stashClick);
      }
      
      private function handler_chestReBuy(param1:LootBoxRewardVO, param2:PopupStashEventParams) : void
      {
         action_boxBuy(false,param1.pack);
      }
      
      public function updateTime() : void
      {
         if(_popup)
         {
            if(currentBoxRefillable)
            {
               currentBoxAvailableNextFreeIn = currentBoxAvailableNextFreeAt - GameTimer.instance.currentServerTime;
               signalRefillableUpdate.dispatch();
            }
            if(offer && offer.endTime > GameTimer.instance.currentServerTime)
            {
               signalTimerUpdate.dispatch(timerText);
            }
            else
            {
               close();
            }
         }
      }
   }
}
