package game.mediator.gui.popup.shop
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.model.user.inventory.InventoryItem;
   import org.osflash.signals.Signal;
   
   public class ShopSlotValueObject
   {
       
      
      protected var _cost:CostData;
      
      protected var _item:InventoryItem;
      
      protected var _id:int;
      
      protected var _staticShopTab:int;
      
      protected var _updateSignal:Signal;
      
      protected var _bought:Boolean;
      
      protected var _reward:RewardData;
      
      private var _staticShopMultiplePurchase:Boolean;
      
      public function ShopSlotValueObject(param1:Object)
      {
         super();
         parseRawData(param1);
      }
      
      public function get hasExtendedInfo() : Boolean
      {
         return item.item is UnitDescription || item.item is SkinDescription;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get item() : InventoryItem
      {
         return _item;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get staticShopTab() : int
      {
         return _staticShopTab;
      }
      
      public function get updateSignal() : Signal
      {
         return _updateSignal;
      }
      
      public function set bought(param1:Boolean) : void
      {
         if(_bought != param1)
         {
            _updateSignal.dispatch();
            _bought = param1;
         }
      }
      
      public function get bought() : Boolean
      {
         return _bought;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get itemStats() : Vector.<BattleStatValueObject>
      {
         if(item is GearItemDescription)
         {
            return BattleStatValueObjectProvider.fromBattleStats((item as GearItemDescription).battleStatData);
         }
         return null;
      }
      
      public function get name() : String
      {
         var _loc1_:* = null;
         var _loc2_:InventoryItemDescription = item.item;
         if(_loc2_ is SkinDescription)
         {
            _loc1_ = DataStorage.hero.getHeroById((_loc2_ as SkinDescription).heroId).name;
            return _loc1_ + " - " + (_loc2_ as SkinDescription).name;
         }
         return _loc2_.name;
      }
      
      public function get staticShopMultiplePurchase() : Boolean
      {
         return _staticShopMultiplePurchase;
      }
      
      public function set staticShopMultiplePurchase(param1:Boolean) : void
      {
         _staticShopMultiplePurchase = param1;
      }
      
      protected function parseRawData(param1:Object) : void
      {
         _id = param1.id;
         _updateSignal = new Signal();
         _cost = new CostData(param1.cost);
         _reward = new RewardData(param1.reward);
         _item = _reward.outputDisplayFirst;
         if(_item && _item.item is SkinDescription)
         {
            _item = new InventoryFragmentSkinItem(_item.item,_item.amount);
         }
         _bought = param1.bought;
         _staticShopTab = param1.staticShopTab;
         _staticShopMultiplePurchase = Boolean(param1.staticShopMultiplePurchase);
      }
   }
}
