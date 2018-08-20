package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.popup.artifactstore.TitanArtifactSmallFragmentItemRenderer;
   
   public class TitanArtifactSmallFragmentChestItemRenderer extends TitanArtifactSmallFragmentItemRenderer
   {
       
      
      public function TitanArtifactSmallFragmentChestItemRenderer()
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
   }
}
