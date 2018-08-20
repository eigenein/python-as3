package game.data.storage
{
   import flash.utils.Dictionary;
   import game.data.storage.enum.LibParseError;
   
   public class DescriptionStorage
   {
       
      
      protected const _items:Dictionary = new Dictionary();
      
      public function DescriptionStorage()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            parseItem(_loc2_);
         }
      }
      
      protected function parseItem(param1:Object) : void
      {
         throw LibParseError.ERROR_NOT_IMPLEMENTED;
      }
      
      public function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc1_.applyLocale();
         }
      }
      
      public function getById(param1:uint) : DescriptionBase
      {
         return _items[param1];
      }
   }
}
