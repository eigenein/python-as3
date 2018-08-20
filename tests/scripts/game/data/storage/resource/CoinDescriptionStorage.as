package game.data.storage.resource
{
   import game.data.storage.DescriptionStorage;
   
   public class CoinDescriptionStorage extends DescriptionStorage
   {
       
      
      public function CoinDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:CoinDescription = new CoinDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      public function getByIdent(param1:String) : CoinDescription
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc3_ = _loc2_ as CoinDescription;
            if(_loc3_ && _loc3_.ident == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getCoinById(param1:int) : CoinDescription
      {
         return _items[param1];
      }
   }
}
