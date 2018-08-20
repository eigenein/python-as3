package game.data.storage.world
{
   import game.data.storage.DescriptionStorage;
   
   public class WorldMapStorage extends DescriptionStorage
   {
       
      
      public function WorldMapStorage()
      {
         super();
      }
      
      public function getList() : Vector.<WorldMapDescription>
      {
         var _loc1_:Vector.<WorldMapDescription> = new Vector.<WorldMapDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(_sortWorlds);
         return _loc1_;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:WorldMapDescription = new WorldMapDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      private function _sortWorlds(param1:WorldMapDescription, param2:WorldMapDescription) : int
      {
         return param1.id - param2.id;
      }
   }
}
