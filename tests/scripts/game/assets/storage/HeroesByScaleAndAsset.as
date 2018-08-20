package game.assets.storage
{
   import flash.utils.Dictionary;
   import game.assets.HeroRsxAsset;
   import game.assets.HeroRsxAssetDisposable;
   
   public class HeroesByScaleAndAsset
   {
       
      
      private const byScaleAndAsset:Dictionary = new Dictionary();
      
      public function HeroesByScaleAndAsset()
      {
         super();
      }
      
      public function disposeUnused() : void
      {
         var _loc1_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = byScaleAndAsset;
         for each(var _loc3_ in byScaleAndAsset)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for(var _loc2_ in _loc3_)
            {
               _loc1_ = _loc3_[_loc2_];
               if(_loc1_.usages == 0)
               {
                  _loc1_.dispose();
                  delete _loc3_[_loc2_];
               }
            }
         }
      }
      
      public function has(param1:HeroRsxAsset, param2:Number) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:Dictionary = byScaleAndAsset[param2];
         if(_loc4_)
         {
            _loc3_ = _loc4_[param1];
            if(_loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getAsset(param1:int, param2:HeroRsxAsset, param3:Number) : HeroRsxAssetDisposable
      {
         var _loc4_:* = null;
         var _loc5_:Dictionary = byScaleAndAsset[param3];
         if(_loc5_)
         {
            _loc4_ = _loc5_[param2];
            if(_loc4_)
            {
               return _loc4_;
            }
         }
         else
         {
            _loc5_ = new Dictionary();
            byScaleAndAsset[param3] = _loc5_;
         }
         _loc4_ = new HeroRsxAssetDisposable(param1,param2,param3);
         _loc5_[param2] = _loc4_;
         return _loc4_;
      }
   }
}
