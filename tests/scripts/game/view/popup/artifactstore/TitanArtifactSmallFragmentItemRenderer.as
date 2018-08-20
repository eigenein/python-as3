package game.view.popup.artifactstore
{
   import game.assets.storage.AssetStorageUtil;
   import starling.textures.Texture;
   
   public class TitanArtifactSmallFragmentItemRenderer extends TitanArtifactFragmentItemRenderer
   {
       
      
      public function TitanArtifactSmallFragmentItemRenderer()
      {
         super();
      }
      
      override protected function getTitanArtifactFragmentTexture() : Texture
      {
         return AssetStorageUtil.getTitanArtifactSmallFragmentTexture();
      }
   }
}
