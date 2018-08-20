package game.data.storage.clan
{
   import game.data.storage.DescriptionStorage;
   
   public class ClanActivityRewardStorage extends DescriptionStorage
   {
       
      
      public function ClanActivityRewardStorage()
      {
         super();
      }
      
      public function getList() : Vector.<ClanActivityRewardDescription>
      {
         var _loc1_:Vector.<ClanActivityRewardDescription> = new Vector.<ClanActivityRewardDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(_sort);
         return _loc1_;
      }
      
      public function getMaxPoints() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_ = Math.max(_loc2_,_loc1_.activityPoints);
         }
         return _loc2_;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ClanActivityRewardDescription = new ClanActivityRewardDescription(param1);
         _items[_loc2_.activityPoints] = _loc2_;
      }
      
      private function _sort(param1:ClanActivityRewardDescription, param2:ClanActivityRewardDescription) : int
      {
         return param1.activityPoints - param2.activityPoints;
      }
   }
}
