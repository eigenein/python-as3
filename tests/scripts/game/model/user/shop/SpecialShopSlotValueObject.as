package game.model.user.shop
{
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   
   public class SpecialShopSlotValueObject extends ShopSlotValueObject
   {
       
      
      private var _discount:int = 50;
      
      private var _heroSlotId:int;
      
      public function SpecialShopSlotValueObject(param1:Object)
      {
         super(param1);
         _discount = param1["discount"];
         _heroSlotId = param1["heroSlotId"];
      }
      
      public function get discount() : int
      {
         return _discount;
      }
      
      public function get heroSlotId() : int
      {
         return _heroSlotId;
      }
      
      public function canBuy() : Boolean
      {
         return true;
      }
   }
}
