package game.data.storage.loot
{
   import game.data.storage.DescriptionStorage;
   
   public class LootBoxRewardGroupStorage extends DescriptionStorage
   {
       
      
      public function LootBoxRewardGroupStorage()
      {
         super();
      }
      
      public function getByIdent(param1:String) : LootBoxRewardGroupDescription
      {
         return _items[param1] as LootBoxRewardGroupDescription;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:LootBoxRewardGroupDescription = new LootBoxRewardGroupDescription(param1);
         _items[_loc2_.ident] = _loc2_;
      }
   }
}
