package engine.core.assets.file
{
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import engine.core.assets.loading.AssetLoaderItem;
   import engine.core.assets.loading.ByteArrayAssetLoader;
   import engine.core.assets.loading.RsxAssetLoader;
   
   public class RsxFile extends AssetFile
   {
       
      
      public var data:ClipAsset;
      
      public function RsxFile(param1:String, param2:String, param3:AssetPath, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(data != null)
         {
            data.dispose();
            ClipImageCache.dropUnusedTexture(data);
            data = null;
         }
      }
      
      override public function get completed() : Boolean
      {
         return data;
      }
      
      override public function completeAsync(param1:AssetLoaderItem) : void
      {
         if(param1 is RsxAssetLoader)
         {
            data = (param1 as RsxAssetLoader).asset;
         }
      }
      
      override public function getLoader() : AssetLoaderItem
      {
         return new RsxAssetLoader(new ByteArrayAssetLoader(this));
      }
   }
}
