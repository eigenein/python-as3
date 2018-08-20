package engine.core.assets
{
   public interface RequestableAsset
   {
       
      
      function prepare(param1:AssetProvider) : void;
      
      function get completed() : Boolean;
      
      function complete() : void;
   }
}
