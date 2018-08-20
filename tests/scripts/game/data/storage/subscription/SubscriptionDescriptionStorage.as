package game.data.storage.subscription
{
   import game.data.storage.DescriptionStorage;
   
   public class SubscriptionDescriptionStorage extends DescriptionStorage
   {
       
      
      public function SubscriptionDescriptionStorage()
      {
         super();
      }
      
      public function get theSubscription() : SubscriptionDescription
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function getSubscriptionById(param1:uint) : SubscriptionDescription
      {
         return _items[param1];
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:SubscriptionDescription = new SubscriptionDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
