package game.mediator.gui.popup.shop
{
   import game.command.intern.OpenHeroPopUpCommand;
   import game.command.rpc.shop.CommandShopBuy;
   import game.command.rpc.shop.CommandShopGet;
   import game.command.rpc.shop.CommandShopRefresh;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.shop.soul.SoulShopUtils;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopUtils;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.shop.ShopPopup;
   import org.osflash.signals.Signal;
   
   public class ShopPopupMediator extends PopupMediator
   {
       
      
      private var alarmEvent:AlarmEvent;
      
      private var refillable:PlayerRefillableEntry;
      
      private var _refreshTime:int;
      
      private var _signal_refreshTimeUpdate:Signal;
      
      private var _signal_refreshCostUpdate:Signal;
      
      private var _signal_shopUpdate:Signal;
      
      private var _signal_slotUpdate:Signal;
      
      private var _shop:ShopDescription;
      
      private var _tabs:Vector.<ShopDescription>;
      
      private var _itemList:Vector.<ShopSlotValueObject>;
      
      public function ShopPopupMediator(param1:Player, param2:ShopDescription)
      {
         var _loc5_:int = 0;
         _signal_refreshCostUpdate = new Signal();
         _itemList = new Vector.<ShopSlotValueObject>();
         this._shop = param2;
         super(param1);
         _signal_refreshTimeUpdate = new Signal();
         _signal_shopUpdate = new Signal();
         _signal_slotUpdate = new Signal(ShopSlotValueObject);
         refillable = param1.refillable.getById(param2.resetRefillableId);
         refillable.signal_update.add(handler_refillableUpdated);
         GameTimer.instance.oneSecTimer.add(handler_onGameTimer);
         _tabs = new Vector.<ShopDescription>();
         var _loc3_:Vector.<ShopDescription> = DataStorage.shop.getList();
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(Game.instance.navigator.shopHelper.isShopAvailable(_loc3_[_loc5_]) && _loc3_[_loc5_].ident != TitanSoulShopUtils.shopIdent && _loc3_[_loc5_].ident != ShopDescriptionStorage.IDENT_TITAN_ARTIFACT_SHOP && _loc3_[_loc5_].ident != ShopDescriptionStorage.IDENT_TITAN_TOKEN_SHOP)
            {
               tabs.push(_loc3_[_loc5_]);
            }
            _loc5_++;
         }
      }
      
      override protected function dispose() : void
      {
         super.dispose();
      }
      
      public function get name() : String
      {
         return _shop.name;
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
      
      public function get shop() : ShopDescription
      {
         return _shop;
      }
      
      public function get tabs() : Vector.<ShopDescription>
      {
         return _tabs;
      }
      
      public function get itemList() : Vector.<ShopSlotValueObject>
      {
         return _itemList;
      }
      
      public function get nextRefreshTime() : String
      {
         return TimeFormatter.toMS2(_refreshTime - GameTimer.instance.currentServerTime).toString();
      }
      
      public function get refreshCost() : CostData
      {
         var _loc1_:PlayerRefillableEntry = player.refillable.getById(_shop.resetRefillableId);
         return _loc1_.refillCost;
      }
      
      public function get hasRefillable() : Boolean
      {
         return _shop.resetRefillableId != 0;
      }
      
      override public function close() : void
      {
         if(refillable)
         {
            refillable.signal_update.remove(handler_refillableUpdated);
         }
         super.close();
         GameTimer.instance.oneSecTimer.remove(handler_onGameTimer);
         if(alarmEvent)
         {
            GameTimer.instance.removeAlarm(alarmEvent);
         }
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         if(_shop.specialCurrency)
         {
            _loc1_.requre_coin(_shop.specialCurrency as CoinDescription);
            _loc1_.requre_starmoney(true);
         }
         else
         {
            _loc1_.requre_gold(true);
            _loc1_.requre_starmoney(true);
         }
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ShopPopup(this);
         _popup.stashParams.windowName = "store:" + _shop.ident;
         return _popup;
      }
      
      public function action_getShop() : void
      {
         var _loc1_:CommandShopGet = GameModel.instance.actionManager.shop.shopGet(_shop);
         _loc1_.signal_complete.add(onShopGetComplete);
      }
      
      public function action_refreshShop() : void
      {
         var _loc1_:CommandShopRefresh = GameModel.instance.actionManager.shop.shopRefresh(_shop);
         _loc1_.signal_complete.add(onShopRefreshComplete);
      }
      
      public function action_buySlot(param1:ShopSlotValueObject) : void
      {
         var _loc2_:CommandShopBuy = GameModel.instance.actionManager.shop.shopBuy(_shop,param1);
         _loc2_.signal_complete.add(onShopBuyComplete);
      }
      
      public function action_showInfo(param1:ShopSlotValueObject) : void
      {
         var _loc2_:* = null;
         if(!param1)
         {
            return;
         }
         if(param1.item.item is HeroDescription)
         {
            _loc2_ = new OpenHeroPopUpCommand(player,param1.item.item as HeroDescription,Stash.click("shop_item_info",_popup.stashParams));
            _loc2_.recieveInfoMode = false;
            _loc2_.closeAllPopups = true;
            _loc2_.execute();
         }
         else if(param1.item.item is SkinDescription)
         {
            PopupList.instance.dialog_skin_info(param1.item.item.id);
         }
      }
      
      public function action_setTab(param1:ShopDescription) : void
      {
      }
      
      private function onShopGetComplete(param1:CommandShopGet) : void
      {
         _itemList = param1.shopData;
         _itemList.sort(_sortShopSlots);
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
         if(param1.shop.ident == SoulShopUtils.shopIdent)
         {
            if(SoulShopUtils.hasFragmentsToSell(player))
            {
               PopupList.instance.dialog_soulshop_sell_fragments(false,!!_popup?_popup.stashParams:null);
            }
         }
      }
      
      private function onShopBuyComplete(param1:CommandShopBuy) : void
      {
         _signal_slotUpdate.dispatch(param1.slot);
      }
      
      private function onShopRefreshComplete(param1:CommandShopRefresh) : void
      {
         _itemList = param1.shopData;
         _signal_shopUpdate.dispatch();
      }
      
      private function handler_onGameTimer() : void
      {
         if(_refreshTime)
         {
            _signal_refreshTimeUpdate.dispatch();
         }
      }
      
      private function handler_updateAlarm() : void
      {
         action_getShop();
      }
      
      private function handler_refillableUpdated() : void
      {
         _signal_refreshCostUpdate.dispatch();
      }
      
      private function _sortShopSlots(param1:ShopSlotValueObject, param2:ShopSlotValueObject) : int
      {
         return param1.id - param2.id;
      }
      
      public function action_selectTab(param1:int) : void
      {
         if(_shop != tabs[param1])
         {
            if(tabs[param1].mechanicIdent == MechanicStorage.CLAN_PVP.type)
            {
               Game.instance.navigator.navigateToShop(tabs[param1],Stash.click("shop:" + _shop.id,_popup.stashParams));
               close();
            }
            else
            {
               _shop = tabs[param1];
               GamePopupManager.instance.resourcePanel.setMediator(_popup as ShopPopup,GamePopupManager.instance.root);
               if(refillable)
               {
                  refillable.signal_update.remove(handler_refillableUpdated);
               }
               refillable = player.refillable.getById(_shop.resetRefillableId);
               if(refillable)
               {
                  refillable.signal_update.add(handler_refillableUpdated);
               }
               action_getShop();
            }
         }
      }
   }
}
