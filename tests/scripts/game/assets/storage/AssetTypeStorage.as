package game.assets.storage
{
   import engine.core.assets.MandatoryAssetInitializer;
   import engine.core.assets.RequestableAsset;
   import flash.utils.Dictionary;
   
   public class AssetTypeStorage
   {
       
      
      protected var dict:Dictionary;
      
      public function AssetTypeStorage(param1:* = null)
      {
         dict = new Dictionary();
         super();
         if(param1)
         {
            init(param1);
         }
      }
      
      public function init(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            createEntry(_loc2_,param1[_loc2_]);
         }
      }
      
      public function complete(param1:*) : void
      {
         var _loc3_:MandatoryAssetInitializer = new MandatoryAssetInitializer();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc2_ in param1)
         {
            if(param1[_loc2_].mandatory)
            {
               _loc3_.requestAsset(dict[_loc2_]);
            }
         }
      }
      
      protected function createEntry(param1:String, param2:*) : RequestableAsset
      {
         throw new Error("must be overridden");
      }
   }
}
