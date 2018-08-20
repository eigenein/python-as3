package engine.core.assets
{
   public class MandatoryAssetInitializer implements AssetProvider
   {
       
      
      public function MandatoryAssetInitializer()
      {
         super();
      }
      
      public function requestAsset(param1:RequestableAsset) : void
      {
         if(!param1.completed)
         {
            param1.prepare(this);
         }
      }
      
      public function request(param1:RequestableAsset, ... rest) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc3_ in rest)
         {
            _loc4_ = _loc3_ as RequestableAsset;
            if(_loc4_ && !_loc4_.completed)
            {
               return;
            }
         }
         param1.complete();
      }
   }
}
