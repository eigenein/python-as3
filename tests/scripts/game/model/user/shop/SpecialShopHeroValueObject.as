package game.model.user.shop
{
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   
   public class SpecialShopHeroValueObject
   {
       
      
      private var _heroId:int;
      
      private var _slots:Dictionary;
      
      public function SpecialShopHeroValueObject(param1:Object)
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         _slots = new Dictionary();
         super();
         _heroId = param1["heroId"];
         var _loc2_:Array = param1["slots"];
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = new SpecialShopSlotValueObject(_loc2_[_loc3_]);
               _slots[_loc4_.heroSlotId] = _loc4_;
               _loc3_++;
            }
         }
      }
      
      public function get heroId() : int
      {
         return _heroId;
      }
      
      public function get slots() : Dictionary
      {
         return _slots;
      }
      
      public function get hasSlots() : Boolean
      {
         if(_slots == null)
         {
            return false;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _slots;
         for each(var _loc1_ in _slots)
         {
            return true;
         }
         return false;
      }
      
      public function getSlotByHeroSlotId(param1:int) : SpecialShopSlotValueObject
      {
         return _slots[param1];
      }
      
      public function getTotalCost() : CostData
      {
         var _loc1_:CostData = new CostData();
         var _loc4_:int = 0;
         var _loc3_:* = _slots;
         for each(var _loc2_ in _slots)
         {
            if(_loc2_.canBuy())
            {
               _loc1_.add(_loc2_.cost);
            }
         }
         return _loc1_;
      }
      
      public function get discountAmount() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _slots;
         for each(var _loc2_ in _slots)
         {
            if(_loc2_.canBuy())
            {
               _loc1_ = _loc2_.discount;
            }
         }
         return _loc1_;
      }
   }
}
