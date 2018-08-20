package game.data.storage.shop
{
   import game.data.storage.DescriptionStorage;
   
   public class ShopDescriptionStorage extends DescriptionStorage
   {
      
      public static var IDENT_SOUL_SHOP:String = "soulshop";
      
      public static var IDENT_TITAN_SOUL_SHOP:String = "titanSoulShop";
      
      public static var IDENT_GUILDWAR_SHOP:String = "clanWar";
      
      public static var IDENT_TITAN_ARTIFACT_SHOP:String = "titanArtifactShop";
      
      public static var IDENT_TITAN_TOKEN_SHOP:String = "titanTokenShop";
       
      
      public function ShopDescriptionStorage()
      {
         super();
      }
      
      public function getByIdent(param1:String) : ShopDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.ident == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getList() : Vector.<ShopDescription>
      {
         var _loc2_:Vector.<ShopDescription> = new Vector.<ShopDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getList_titanArtifactMerchant() : Vector.<ShopDescription>
      {
         var _loc2_:Vector.<ShopDescription> = new Vector.<ShopDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getByVipLevelPermanent(param1:int) : Vector.<ShopDescription>
      {
         var _loc3_:Vector.<ShopDescription> = new Vector.<ShopDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.vipLevelPermanent == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getShopById(param1:uint) : ShopDescription
      {
         return _items[param1] as ShopDescription;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = param1.staticSlots;
         if(_loc3_)
         {
            _loc2_ = new StaticSlotsShopDescription(param1);
         }
         else
         {
            _loc2_ = new ShopDescription(param1);
         }
         _items[_loc2_.id] = _loc2_;
      }
   }
}
