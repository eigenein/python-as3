package game.data.storage.clan
{
   import game.data.storage.DescriptionStorage;
   
   public class ClanSummoningCircleStorage extends DescriptionStorage
   {
       
      
      private var _defaultCircle:ClanSummoningCircleDescription;
      
      public function ClanSummoningCircleStorage()
      {
         super();
      }
      
      public function get defaultCircle() : ClanSummoningCircleDescription
      {
         return _defaultCircle;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ClanSummoningCircleDescription = new ClanSummoningCircleDescription(param1);
         _items[_loc2_.id] = _loc2_;
         _defaultCircle = _loc2_;
      }
   }
}
