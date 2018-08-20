package engine.core.assets
{
   public class FileDependentAsset implements RequestableAsset
   {
       
      
      public function FileDependentAsset()
      {
         super();
      }
      
      public function get completed() : Boolean
      {
         throw new Error("abstract method usage");
      }
      
      public function complete() : void
      {
         throw new Error("abstract method usage");
      }
      
      public function prepare(param1:AssetProvider) : void
      {
         throw new Error("abstract method usage");
      }
   }
}
