package game.assets.storage
{
   import flash.utils.Dictionary;
   
   public class AssetDisposingWatcher
   {
      
      private static var disposedAssets:Dictionary = new Dictionary(true);
      
      public static var DEBUG_ASSET_DISPOSING:Boolean = false;
       
      
      public function AssetDisposingWatcher()
      {
         super();
      }
      
      public static function getGcFailedAssets() : String
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = disposedAssets;
         for(var _loc2_ in disposedAssets)
         {
            _loc1_.push(disposedAssets[_loc2_]);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function watch(param1:*, param2:String) : void
      {
         disposedAssets[param1] = param2;
      }
   }
}
