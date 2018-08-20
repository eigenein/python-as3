package game.data.storage.nygifts
{
   import game.data.storage.DescriptionStorage;
   
   public class NYGiftsStorage extends DescriptionStorage
   {
       
      
      public function NYGiftsStorage()
      {
         super();
      }
      
      public function get giftsList() : Vector.<NYGiftDescription>
      {
         var _loc2_:Vector.<NYGiftDescription> = new Vector.<NYGiftDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getNYGifyById(param1:int) : NYGiftDescription
      {
         return _items[param1];
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:NYGiftDescription = new NYGiftDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
