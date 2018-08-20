package game.data.storage.skin
{
   import game.data.storage.DescriptionStorage;
   
   public class SkinDescriptionStorage extends DescriptionStorage
   {
       
      
      public function SkinDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:SkinDescription = new SkinDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      public function getSkinById(param1:int) : SkinDescription
      {
         return _items[param1];
      }
      
      public function getSkinsByHeroId(param1:int) : Vector.<SkinDescription>
      {
         var _loc2_:Vector.<SkinDescription> = new Vector.<SkinDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.heroId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}
