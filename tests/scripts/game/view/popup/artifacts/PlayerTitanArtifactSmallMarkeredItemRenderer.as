package game.view.popup.artifacts
{
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorageUtil;
   import starling.textures.Texture;
   
   public class PlayerTitanArtifactSmallMarkeredItemRenderer extends PlayerTitanArtifactSmallItemRenderer
   {
       
      
      public var icon_red_dot:GuiClipImage;
      
      public function PlayerTitanArtifactSmallMarkeredItemRenderer()
      {
         icon_red_dot = new GuiClipImage();
         super();
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         updateRedDotState();
      }
      
      public function updateRedDotState() : void
      {
         icon_red_dot.graphics.visible = artifactVO.checkArtifactUpgradeAvaliable();
      }
      
      override protected function get frameTexture() : Texture
      {
         return AssetStorageUtil.getTitanArtifactSmallFrameTexture(artifactVO.artifact);
      }
   }
}
