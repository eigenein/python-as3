package game.data.storage.titan
{
   import game.data.storage.DescriptionStorage;
   
   public class TitanGiftDescriptionStorage extends DescriptionStorage
   {
       
      
      private var _maxGiftLevel:int;
      
      public function TitanGiftDescriptionStorage()
      {
         super();
      }
      
      public function get maxGiftLevel() : int
      {
         return _maxGiftLevel;
      }
      
      public function getTitanGiftByLevel(param1:uint) : TitanGiftDescription
      {
         if(!_items[param1])
         {
            trace("unknown titan gift level ",param1);
            return _items[1];
         }
         return _items[param1];
      }
      
      public function getTitanGiftWithMaxLevel() : TitanGiftDescription
      {
         return getTitanGiftByLevel(_maxGiftLevel);
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:TitanGiftDescription = new TitanGiftDescription(param1);
         _items[_loc2_.level] = _loc2_;
         _maxGiftLevel = Math.max(_maxGiftLevel,_loc2_.level);
      }
   }
}
