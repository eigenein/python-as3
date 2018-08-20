package game.data.storage.shop
{
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   
   public class StaticSlotsShopDescription extends ShopDescription
   {
       
      
      private var rawSlots:Object;
      
      private var _slots:Vector.<ShopSlotValueObject>;
      
      public function StaticSlotsShopDescription(param1:Object)
      {
         var _loc2_:* = null;
         _slots = new Vector.<ShopSlotValueObject>();
         super(param1);
         rawSlots = param1.slots;
         var _loc5_:int = 0;
         var _loc4_:* = param1.slots;
         for(var _loc3_ in param1.slots)
         {
            _loc2_ = param1.slots[_loc3_];
            if(_loc2_ && _loc2_.length > 0)
            {
               _slots.push(new StaticShopSlotValueObject(_loc3_,_loc2_[0]));
            }
         }
      }
      
      public function get slots() : Vector.<ShopSlotValueObject>
      {
         return _slots;
      }
   }
}
