package game.data.storage.shop
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.level.LevelRequirement;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class ShopDescription extends DescriptionBase
   {
       
      
      private var resetTimes:Array;
      
      private var slotCount:int;
      
      private var teamLevelRange:int;
      
      private var _resetRefillableId:int;
      
      private var _vipLevelPermanent:int;
      
      private var lifetime:int;
      
      private var _levelRequirement:LevelRequirement;
      
      private var _ident:String;
      
      private var _mechanicIdent:String;
      
      private var _specialCurrency:InventoryItemDescription;
      
      public function ShopDescription(param1:Object)
      {
         super();
         _ident = param1.ident;
         _id = param1.id;
         resetTimes = param1.resetTimes;
         slotCount = param1.slotCount;
         teamLevelRange = param1.teamLevelRange;
         _resetRefillableId = param1.resetRefillableId;
         _vipLevelPermanent = param1.vipLevelPermanent;
         lifetime = param1.lifetime;
         if(param1.specialCurrency && param1.specialCurrency.type == InventoryItemType.COIN.type)
         {
            _specialCurrency = DataStorage.coin.getById(param1.specialCurrency.id) as CoinDescription;
         }
         _levelRequirement = new LevelRequirement({"teamLevel":param1.teamLevelToUnlock});
         _mechanicIdent = param1.mechanic;
      }
      
      public function get resetRefillableId() : int
      {
         return _resetRefillableId;
      }
      
      public function get levelRequirement() : LevelRequirement
      {
         return _levelRequirement;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get mechanicIdent() : String
      {
         return _mechanicIdent;
      }
      
      public function get specialCurrency() : InventoryItemDescription
      {
         return _specialCurrency;
      }
      
      public function get vipLevelPermanent() : int
      {
         return _vipLevelPermanent;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_SHOP_NAME_" + id);
      }
   }
}
