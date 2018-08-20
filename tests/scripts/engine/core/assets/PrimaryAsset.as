package engine.core.assets
{
   import engine.core.assets.loading.AssetLoaderItem;
   
   public interface PrimaryAsset extends RequestableAsset
   {
       
      
      function getLoader() : AssetLoaderItem;
      
      function completeAsync(param1:AssetLoaderItem) : void;
   }
}
