package game.mediator.gui.popup.shop.soul
{
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryItem;
   
   public class SoulShopUtils
   {
      
      private static var _minHeroStarRequired:int = -1;
       
      
      public function SoulShopUtils()
      {
         super();
      }
      
      public static function get shopIdent() : String
      {
         return ShopDescriptionStorage.IDENT_SOUL_SHOP;
      }
      
      public static function get shopCoin() : CoinDescription
      {
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(shopIdent);
         return _loc1_.specialCurrency as CoinDescription;
      }
      
      public static function getMinHeroStarRequired() : int
      {
         var _loc1_:int = 0;
         if(_minHeroStarRequired == -1)
         {
            _loc1_ = 0;
            while(DataStorage.enum.getById_EvolutionStar(_loc1_ + 1) != null)
            {
               _loc1_++;
            }
            _minHeroStarRequired = _loc1_;
         }
         return _minHeroStarRequired;
      }
      
      public static function hasHeroesOnMaxStars(param1:Player) : Boolean
      {
         var _loc2_:Vector.<PlayerHeroEntry> = param1.heroes.getFilteredList(filter_maxPossibleStar);
         return _loc2_.length > 0;
      }
      
      public static function hasFragmentsToSell(param1:Player) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:Vector.<PlayerHeroEntry> = param1.heroes.getFilteredList(filter_maxPossibleStar);
         var _loc6_:InventoryCollection = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.HERO);
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_].hero;
            if(_loc6_.hasEnough(_loc5_,1))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function getFragmentsToSell(param1:Player) : Vector.<InventoryItem>
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Vector.<PlayerHeroEntry> = param1.heroes.getFilteredList(filter_maxPossibleStar);
         var _loc7_:InventoryCollection = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.HERO);
         var _loc2_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_].hero;
            if(_loc7_.hasEnough(_loc6_,1))
            {
               _loc2_.push(_loc7_.getItem(_loc6_));
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private static function filter_maxPossibleStar(param1:PlayerHeroEntry) : Boolean
      {
         return param1.star.star.id >= getMinHeroStarRequired();
      }
   }
}
