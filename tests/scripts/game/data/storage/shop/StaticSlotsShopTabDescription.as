package game.data.storage.shop
{
   import com.progrestar.common.lang.Translate;
   
   public class StaticSlotsShopTabDescription
   {
       
      
      private var _shop:ShopDescription;
      
      private var _id:int;
      
      public function StaticSlotsShopTabDescription(param1:StaticSlotsShopDescription, param2:int)
      {
         super();
         this._shop = param1;
         this._id = param2;
      }
      
      public function get title() : String
      {
         return Translate.translate("UI_SHOP_TAB_" + _shop.mechanicIdent.toUpperCase() + "_" + _id);
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
