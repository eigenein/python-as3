package game.data.storage.bundle
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionStorage;
   
   public class BundleDescriptionStorage extends DescriptionStorage
   {
       
      
      private var _bundleHeroReward:Dictionary;
      
      public function BundleDescriptionStorage()
      {
         _bundleHeroReward = new Dictionary();
         super();
      }
      
      public function initBundleReward(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            parseBundleRewardItem(_loc2_);
         }
      }
      
      public function getBundleHeroReward(param1:int) : BundleHeroReward
      {
         return _bundleHeroReward[param1];
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:BundleDescription = new BundleDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      private function parseBundleRewardItem(param1:Object) : void
      {
         _bundleHeroReward[param1.id] = new BundleHeroReward(param1);
      }
   }
}
