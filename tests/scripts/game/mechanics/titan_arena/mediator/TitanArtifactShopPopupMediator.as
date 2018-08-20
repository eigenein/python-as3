package game.mechanics.titan_arena.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.VectorUtil;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.command.rpc.shop.CommandShopBuy;
   import game.command.rpc.shop.CommandShopGet;
   import game.command.rpc.shop.CommandShopRefresh;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.IObtainableResource;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.shop.StaticSlotsShopDescription;
   import game.data.storage.shop.StaticSlotsShopTabDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mechanics.titan_arena.popup.TitanArtifactShopPopup;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.mediator.gui.popup.shop.buy.BuyItemPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.resource.NotEnoughResourcePopupMediator;
   import game.view.popup.reward.RewardPopup;
   import org.osflash.signals.Signal;
   
   public class TitanArtifactShopPopupMediator extends PopupMediator
   {
      
      private static const HIDE_UPPER_TAB_IF_NO_ITEMS_LEFT:Boolean = false;
      
      private static const HIDE_UPPER_TABS_IF_JUST_ONE_TAB_LEFT:Boolean = true;
      
      private static const EMPTY_UPPER_TABS:Vector.<*> = new Vector.<StaticSlotsShopTabDescription>() as Vector.<*>;
       
      
      private var _refreshTime:int;
      
      private var alarmEvent:AlarmEvent;
      
      private var refillable:PlayerRefillableEntry;
      
      private var _shop:ShopDescription;
      
      private var _tabs:Vector.<ShopDescription>;
      
      private var _allTabsItems:Vector.<ShopSlotValueObject>;
      
      public var itemList:Vector.<ShopSlotValueObject>;
      
      private var _upperTabIndex:IntPropertyWriteable;
      
      private var _upperTabs:Vector.<StaticSlotsShopTabDescription>;
      
      private const _upperTabsVector:VectorPropertyWriteable = new VectorPropertyWriteable(EMPTY_UPPER_TABS);
      
      private const _dataIsUpToDate:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private var _signal_refreshTimeUpdate:Signal;
      
      private var _signal_refreshCostUpdate:Signal;
      
      private var _signal_shopUpdate:Signal;
      
      private var _signal_slotUpdate:Signal;
      
      public function TitanArtifactShopPopupMediator(param1:Player, param2:ShopDescription)
      {
         _allTabsItems = new Vector.<ShopSlotValueObject>();
         _upperTabIndex = new IntPropertyWriteable(-1);
         _signal_refreshTimeUpdate = new Signal();
         _signal_refreshCostUpdate = new Signal();
         _signal_shopUpdate = new Signal();
         _signal_slotUpdate = new Signal();
         super(param1);
         this._shop = param2;
         _tabs = new Vector.<ShopDescription>();
         _tabs.push(DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_TITAN_ARTIFACT_SHOP));
         _tabs.push(DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_TITAN_TOKEN_SHOP));
         setRefillable(param1.refillable.getById(_shop.resetRefillableId));
         _dataIsUpToDate.value = false;
         if(staticShop)
         {
            updateSlots(staticShop.slots);
         }
         GameTimer.instance.oneSecTimer.add(handler_onGameTimer);
      }
      
      override public function close() : void
      {
         setRefillable(null);
         GameTimer.instance.oneSecTimer.remove(handler_onGameTimer);
         if(alarmEvent)
         {
            GameTimer.instance.removeAlarm(alarmEvent);
         }
         super.close();
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         _loc1_.requre_coin(DataStorage.coin.getByIdent("titan_arena"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("titan_token"));
         return _loc1_;
      }
      
      public function get staticShop() : StaticSlotsShopDescription
      {
         return _shop as StaticSlotsShopDescription;
      }
      
      public function get refreshCost() : CostData
      {
         var _loc1_:PlayerRefillableEntry = player.refillable.getById(_shop.resetRefillableId);
         return !!_loc1_?_loc1_.refillCost:null;
      }
      
      public function get shop() : ShopDescription
      {
         return _shop;
      }
      
      public function get name() : String
      {
         return _shop.name;
      }
      
      public function get tabs() : Vector.<ShopDescription>
      {
         return _tabs;
      }
      
      public function get upperTabIndex() : IntProperty
      {
         return _upperTabIndex;
      }
      
      public function get upperTabs() : Vector.<StaticSlotsShopTabDescription>
      {
         return _upperTabs;
      }
      
      public function get upperTabsVector() : VectorProperty
      {
         return _upperTabsVector;
      }
      
      public function get dataIsUpToDate() : BooleanProperty
      {
         return _dataIsUpToDate;
      }
      
      public function get signal_refreshTimeUpdate() : Signal
      {
         return _signal_refreshTimeUpdate;
      }
      
      public function get signal_refreshCostUpdate() : Signal
      {
         return _signal_refreshCostUpdate;
      }
      
      public function get signal_shopUpdate() : Signal
      {
         return _signal_shopUpdate;
      }
      
      public function get signal_slotUpdate() : Signal
      {
         return _signal_slotUpdate;
      }
      
      public function get nextRefreshTime() : String
      {
         return TimeFormatter.toMS2(_refreshTime - GameTimer.instance.currentServerTime).toString();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArtifactShopPopup(this);
         _popup.stashParams.windowName = "store:" + _shop.ident;
         return _popup;
      }
      
      public function action_buySlot(param1:ShopSlotValueObject) : void
      {
         var _loc2_:* = null;
         if(param1.staticShopMultiplePurchase)
         {
            if(player.canSpend(param1.cost))
            {
               new BuyItemPopupMediator(player,_shop,param1).open(Stash.click("shop_item_buy",_popup.stashParams));
            }
            else
            {
               new NotEnoughResourcePopupMediator((param1.cost.outputDisplayFirst.item as IObtainableResource).obtainNavigatorType).open(Stash.click("shop_item_buy",_popup.stashParams));
            }
         }
         else
         {
            _loc2_ = GameModel.instance.actionManager.shop.shopBuy(_shop,param1);
            _loc2_.onClientExecute(onShopBuyComplete);
         }
      }
      
      public function action_showInfo(param1:ShopSlotValueObject) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = false;
         _loc4_ = null;
         if(!param1)
         {
            return;
         }
         if(param1.item.item is HeroDescription)
         {
            _loc4_ = new OpenHeroPopUpCommand(player,param1.item.item as HeroDescription,Stash.click("shop_item_info",_popup.stashParams));
            _loc4_.recieveInfoMode = false;
            _loc4_.closeAllPopups = true;
            _loc4_.execute();
         }
         else if(param1.item.item is SkinDescription)
         {
            _loc2_ = param1.item.item as SkinDescription;
            _loc5_ = player.heroes.getById(_loc2_.heroId);
            if(_loc5_)
            {
               _loc3_ = _loc5_.skinData.getSkinLevelByID(_loc2_.id) > 0;
            }
            if(_loc3_)
            {
               _loc4_ = new OpenHeroPopUpCommand(player,_loc5_.hero,Stash.click("shop_item_info",_popup.stashParams));
               _loc4_.recieveInfoMode = false;
               _loc4_.closeAllPopups = false;
               _loc4_.selectedTab = "TAB_SKINS";
               _loc4_.selectedSkin = _loc2_;
               _loc4_.execute();
            }
            else
            {
               PopupList.instance.dialog_skin_info(_loc2_.id);
            }
         }
      }
      
      public function action_selectTab(param1:int) : void
      {
         _shop = tabs[param1];
         setRefillable(player.refillable.getById(_shop.resetRefillableId));
         action_getShop();
      }
      
      public function action_selectUpperTab(param1:int) : void
      {
         if(param1 < _upperTabs.length && param1 >= 0)
         {
            _upperTabIndex.value = param1;
            updateItems();
         }
      }
      
      public function action_getShop() : void
      {
         var _loc1_:CommandShopGet = GameModel.instance.actionManager.shop.shopGet(shop);
         _loc1_.signal_complete.add(onShopGetComplete);
      }
      
      public function action_refreshShop() : void
      {
         var _loc1_:CommandShopRefresh = GameModel.instance.actionManager.shop.shopRefresh(_shop);
         _loc1_.signal_complete.add(onShopRefreshComplete);
      }
      
      protected function getSlotsByTab(param1:int) : Vector.<ShopSlotValueObject>
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Vector.<ShopSlotValueObject> = new Vector.<ShopSlotValueObject>();
         var _loc4_:int = _allTabsItems.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = _allTabsItems[_loc2_];
            if(_loc3_.staticShopTab == param1)
            {
               _loc5_.push(_loc3_);
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      protected function getTabIsEmty(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Vector.<ShopSlotValueObject> = new Vector.<ShopSlotValueObject>();
         var _loc4_:int = _allTabsItems.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = _allTabsItems[_loc2_];
            if(_loc3_.staticShopTab == param1 && !_loc3_.bought)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      protected function updateItems() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(_upperTabs)
         {
            _loc2_ = _upperTabs[_upperTabIndex.value];
            _loc1_ = _loc2_.id;
            itemList = getSlotsByTab(_loc1_);
         }
      }
      
      protected function getTabs() : Vector.<StaticSlotsShopTabDescription>
      {
         var _loc2_:* = null;
         var _loc1_:Vector.<StaticSlotsShopTabDescription> = new Vector.<StaticSlotsShopTabDescription>();
         if(staticShop)
         {
            _loc2_ = getUniqueTabIdsFromSlots(staticShop.slots);
            _loc2_.sort(sortInt);
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               _loc1_.push(new StaticSlotsShopTabDescription(staticShop,_loc3_));
            }
         }
         return _loc1_;
      }
      
      protected function sortInt(param1:int, param2:int) : int
      {
         return param1 - param2;
      }
      
      protected function updateSkinVoState(param1:ShopSlotValueObject) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:PlayerHeroEntry = player.heroes.getById((param1.item.item as SkinDescription).heroId);
         if(_loc3_)
         {
            if(_loc3_.skinData.getSkinLevelByID(param1.item.id) > 0)
            {
               _loc2_ = true;
            }
         }
         else if(player.inventory.getFragmentCount(param1.item.item) > 0)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            param1.bought = true;
         }
      }
      
      private function updateSlots(param1:Vector.<ShopSlotValueObject>) : void
      {
         if(staticShop)
         {
            _allTabsItems.length = 0;
            var _loc4_:int = 0;
            var _loc3_:* = param1;
            for each(var _loc2_ in param1)
            {
               if(_loc2_ is ShopSlotValueObject)
               {
                  _allTabsItems.push(_loc2_);
                  if(_loc2_.item.item.type == InventoryItemType.SKIN)
                  {
                     updateSkinVoState(_loc2_);
                  }
               }
            }
            _upperTabs = getTabs();
            if(_upperTabIndex.value == -1)
            {
               _upperTabIndex.value = 0;
            }
            if(_upperTabs.length > 1 || false)
            {
               _upperTabsVector.value = _upperTabs as Vector.<*>;
            }
            else
            {
               _upperTabsVector.value = EMPTY_UPPER_TABS;
            }
            updateItems();
         }
         else
         {
            itemList = param1;
         }
      }
      
      private function getUniqueTabIdsFromSlots(param1:Vector.<ShopSlotValueObject>) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Array = [];
         var _loc5_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_ && _loc2_.indexOf(_loc4_.staticShopTab) == -1)
            {
               _loc2_.push(_loc4_.staticShopTab);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function removeEmptyTabIds(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(getTabIsEmty(param1[_loc2_]))
            {
               VectorUtil.removeAt(param1,_loc2_);
               _loc2_--;
               _loc3_--;
            }
            _loc2_++;
         }
      }
      
      private function setRefillable(param1:PlayerRefillableEntry) : void
      {
         if(refillable != null)
         {
            refillable.signal_update.remove(handler_refillableUpdated);
         }
         refillable = param1;
         if(refillable != null)
         {
            refillable.signal_update.add(handler_refillableUpdated);
         }
      }
      
      private function onShopBuyComplete(param1:CommandShopBuy) : void
      {
         var _loc2_:* = null;
         if(param1.shop is StaticSlotsShopDescription && param1.reward.outputDisplayFirst && param1.reward.outputDisplayFirst.item.type != InventoryItemType.SKIN)
         {
            _loc2_ = new RewardPopup(param1.reward.outputDisplay,"clawWarBuyReward");
            _loc2_.header = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
            _loc2_.label = "";
            _loc2_.open();
         }
         updateSlots(param1.staticShopData);
         _dataIsUpToDate.value = true;
      }
      
      private function onShopGetComplete(param1:CommandShopGet) : void
      {
         updateSlots(param1.shopData);
         _dataIsUpToDate.value = true;
         _refreshTime = param1.refreshTime;
         _signal_shopUpdate.dispatch();
         _signal_refreshTimeUpdate.dispatch();
         _signal_refreshCostUpdate.dispatch();
         if(alarmEvent)
         {
            GameTimer.instance.removeAlarm(alarmEvent);
         }
         alarmEvent = new AlarmEvent(_refreshTime,"ShopPopupMediator_alarmEvent");
         alarmEvent.callback = handler_updateAlarm;
         GameTimer.instance.addAlarm(alarmEvent);
      }
      
      private function _sortShopSlots(param1:ShopSlotValueObject, param2:ShopSlotValueObject) : Number
      {
         return param1.id - param2.id;
      }
      
      private function handler_updateAlarm() : void
      {
         action_getShop();
      }
      
      private function handler_refillableUpdated() : void
      {
         _signal_refreshCostUpdate.dispatch();
      }
      
      private function onShopRefreshComplete(param1:CommandShopRefresh) : void
      {
         itemList = param1.shopData;
         _signal_shopUpdate.dispatch();
      }
      
      private function handler_onGameTimer() : void
      {
         if(_refreshTime)
         {
            _signal_refreshTimeUpdate.dispatch();
         }
      }
   }
}
