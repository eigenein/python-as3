package engine.core.assets.file
{
   import engine.core.assets.loading.AssetLoaderItem;
   import engine.core.assets.loading.ByteArrayAssetLoader;
   import engine.core.assets.loading.SWFAssetLoader;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class SwfFile extends AssetFile
   {
       
      
      private var data:SWFAssetLoader;
      
      public function SwfFile(param1:String, param2:String, param3:AssetPath, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         data = null;
      }
      
      public function get applicationDomain() : ApplicationDomain
      {
         return !!data?data.applicationDomain:null;
      }
      
      public function get bytes() : ByteArray
      {
         return data.bytes;
      }
      
      override public function get completed() : Boolean
      {
         return data;
      }
      
      override public function completeAsync(param1:AssetLoaderItem) : void
      {
         if(param1 is SWFAssetLoader)
         {
            data = param1 as SWFAssetLoader;
         }
      }
      
      override public function getLoader() : AssetLoaderItem
      {
         return new SWFAssetLoader(new ByteArrayAssetLoader(this));
      }
   }
}
