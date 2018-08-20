package game.data.storage.clan
{
   import game.data.storage.DescriptionStorage;
   import game.model.user.inventory.InventoryItem;
   
   public class ClanDungeonActivityRewardStorage extends DescriptionStorage
   {
       
      
      public function ClanDungeonActivityRewardStorage()
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
      
      public function getPointsForNextKey(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<ClanActivityRewardDescription> = getList();
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].activityPoints > param1)
            {
               return _loc3_[_loc2_].activityPoints;
            }
            _loc2_++;
         }
         return getMaxPoints();
      }
      
      public function getNextRewardItem(param1:int) : InventoryItem
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<ClanActivityRewardDescription> = getList();
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].activityPoints > param1)
            {
               return _loc3_[_loc2_].reward.outputDisplay[0];
            }
            _loc2_++;
         }
         return null;
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
