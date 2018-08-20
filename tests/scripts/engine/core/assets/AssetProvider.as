package engine.core.assets
{
   public interface AssetProvider
   {
       
      
      function requestAsset(param1:RequestableAsset) : void;
      
      function request(param1:RequestableAsset, ... rest) : void;
   }
}
