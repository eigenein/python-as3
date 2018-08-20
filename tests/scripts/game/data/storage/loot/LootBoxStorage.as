package game.data.storage.loot
{
   import game.data.storage.DescriptionStorage;
   
   public class LootBoxStorage extends DescriptionStorage
   {
       
      
      public function LootBoxStorage()
      {
         super();
      }
      
      public function getByIdent(param1:String) : LootBoxDescription
      {
         return _items[param1];
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:LootBoxDescription = new LootBoxDescription(param1);
         _items[_loc2_.ident] = _loc2_;
      }
   }
}
