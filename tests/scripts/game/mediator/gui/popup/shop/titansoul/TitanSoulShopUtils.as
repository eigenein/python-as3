package game.mediator.gui.popup.shop.titansoul
{
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryItem;
   
   public class TitanSoulShopUtils
   {
      
      private static var _minStarRequired:int = -1;
       
      
      public function TitanSoulShopUtils()
      {
         super();
      }
      
      public static function get shopIdent() : String
      {
         return ShopDescriptionStorage.IDENT_TITAN_SOUL_SHOP;
      }
      
      public static function get shopCoin() : CoinDescription
      {
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(shopIdent);
         return _loc1_.specialCurrency as CoinDescription;
      }
      
      public static function getMinTitanStarRequired() : int
      {
         var _loc1_:int = 0;
         if(_minStarRequired == -1)
         {
            _loc1_ = 0;
            while(DataStorage.enum.getById_titanEvolutionStar(_loc1_ + 1) != null)
            {
               _loc1_++;
            }
            _minStarRequired = _loc1_;
         }
         return _minStarRequired;
      }
      
      public static function hasTitansOnMaxStars(param1:Player) : Boolean
      {
         var _loc2_:Vector.<PlayerTitanEntry> = param1.titans.getFilteredList(filter_maxPossibleStar);
         return _loc2_.length > 0;
      }
      
      public static function hasFragmentsToSell(param1:Player) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc6_:Vector.<PlayerTitanEntry> = param1.titans.getFilteredList(filter_maxPossibleStar);
         var _loc2_:InventoryCollection = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.TITAN);
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc6_[_loc5_].titan;
            if(_loc2_.hasEnough(_loc3_,1))
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public static function getFragmentsToSell(param1:Player) : Vector.<InventoryItem>
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc7_:Vector.<PlayerTitanEntry> = param1.titans.getFilteredList(filter_maxPossibleStar);
         var _loc3_:InventoryCollection = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.TITAN);
         var _loc2_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         var _loc5_:int = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc7_[_loc6_].titan;
            if(_loc3_.hasEnough(_loc4_,1))
            {
               _loc2_.push(_loc3_.getItem(_loc4_));
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      private static function filter_maxPossibleStar(param1:PlayerTitanEntry) : Boolean
      {
         return param1.star.star.id >= getMinTitanStarRequired();
      }
   }
}
