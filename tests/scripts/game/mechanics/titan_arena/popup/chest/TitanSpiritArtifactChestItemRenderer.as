package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.framework.ares.core.Node;
   import game.assets.storage.AssetStorage;
   import game.view.popup.artifactstore.TitanArtifactFragmentItemRenderer;
   
   public class TitanSpiritArtifactChestItemRenderer extends TitanArtifactFragmentItemRenderer
   {
       
      
      public function TitanSpiritArtifactChestItemRenderer()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         this.container.useHandCursor = false;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
      }
      
      override protected function update() : void
      {
         if(artifact)
         {
            item_border_image.image.texture = AssetStorage.rsx.popup_theme.getTexture("artifact_big_white");
            item_image.image.texture = AssetStorage.rsx.titan_artifact_icons_large.getTexture(artifact.assetTexture);
         }
      }
   }
}
