package engine.core.assets.file
{
   import com.progrestar.common.util.assert;
   import engine.core.assets.loading.AssetLoaderItem;
   import engine.core.assets.loading.ByteArrayAssetLoader;
   import flash.utils.ByteArray;
   
   public class RawDataFile extends AssetFile
   {
       
      
      public var bytes:ByteArray;
      
      public function RawDataFile(param1:String, param2:String, param3:AssetPath, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         bytes = null;
      }
      
      override public function get completed() : Boolean
      {
         return bytes;
      }
      
      override public function completeAsync(param1:AssetLoaderItem) : void
      {
         assert(param1 is ByteArrayAssetLoader);
         bytes = (param1 as ByteArrayAssetLoader).bytes;
      }
      
      override public function getLoader() : AssetLoaderItem
      {
         return new ByteArrayAssetLoader(this);
      }
   }
}
