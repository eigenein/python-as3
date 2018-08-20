package game.mediator.gui.popup.shop.titansoul
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import feathers.data.ListCollection;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.command.rpc.shop.CommandShopBuy;
   import game.command.rpc.shop.CommandShopGet;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.IObtainableResource;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.mediator.gui.popup.shop.buy.BuyItemPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.resource.NotEnoughResourcePopupMediator;
   import game.view.popup.reward.RewardPopup;
   import game.view.popup.shop.titansoul.TitanSoulShopPopup;
   
   public class TitanSoulShopPopupMediator extends PopupMediator
   {
      
      private static const HIDE_UPPER_TAB_IF_NO_ITEMS_LEFT:Boolean = false;
      
      private static const HIDE_UPPER_TABS_IF_JUST_ONE_TAB_LEFT:Boolean = false;
       
      
      private var _shop:ShopDescription;
      
      private var _items:Vector.<ShopSlotValueObject>;
      
      public const itemList:ListCollection = new ListCollection();
      
      private const _dataIsUpToDate:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      public function TitanSoulShopPopupMediator(param1:Player, param2:ShopDescription)
      {
         _items = new Vector.<ShopSlotValueObject>();
         super(param1);
         this._shop = param2;
         _dataIsUpToDate.value = false;
         action_getShop();
      }
      
      public function get shop() : ShopDescription
      {
         return _shop;
      }
      
      public function get name() : String
      {
         return _shop.name;
      }
      
      public function get dataIsUpToDate() : BooleanProperty
      {
         return _dataIsUpToDate;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(_shop.specialCurrency as CoinDescription);
         _loc1_.requre_gold(true);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanSoulShopPopup(this);
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
      
      public function action_getShop() : void
      {
         var _loc1_:CommandShopGet = GameModel.instance.actionManager.shop.shopGet(shop);
         _loc1_.signal_complete.add(onShopGetComplete);
      }
      
      public function action_popupIsOpen() : void
      {
         if(TitanSoulShopUtils.hasFragmentsToSell(player))
         {
            PopupList.instance.dialog_titan_soulshop_sell_fragments(false,!!_popup?_popup.stashParams:null);
         }
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
         _items.length = 0;
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_ is ShopSlotValueObject)
            {
               _items.push(_loc2_);
               if(_loc2_.item.item.type == InventoryItemType.SKIN)
               {
                  updateSkinVoState(_loc2_);
               }
            }
         }
         itemList.data = _items;
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
      
      private function onShopBuyComplete(param1:CommandShopBuy) : void
      {
         var _loc2_:* = null;
         if(param1.reward.outputDisplayFirst && param1.reward.outputDisplayFirst.item.type != InventoryItemType.SKIN)
         {
            _loc2_ = new RewardPopup(param1.reward.outputDisplay,"titanSoulShopBuyReward");
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
      }
      
      private function _sortShopSlots(param1:ShopSlotValueObject, param2:ShopSlotValueObject) : Number
      {
         return param1.id - param2.id;
      }
   }
}
