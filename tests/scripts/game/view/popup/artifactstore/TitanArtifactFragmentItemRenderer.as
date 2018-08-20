package game.view.popup.artifactstore
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.tooltip.TitanArtifactFragmentTooltip;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class TitanArtifactFragmentItemRenderer extends ClipButton implements ITooltipSource
   {
       
      
      protected var artifact:TitanArtifactDescription;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      private var _tooltipVO:TooltipVO;
      
      public function TitanArtifactFragmentItemRenderer()
      {
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         _tooltipVO = new TooltipVO(TitanArtifactFragmentTooltip,null);
         super();
      }
      
      public function dispose() : void
      {
         setData(null);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
         container.useHandCursor = true;
      }
      
      public function setData(param1:*) : void
      {
         artifact = param1 as TitanArtifactDescription;
         _tooltipVO.hintData = artifact;
         update();
      }
      
      protected function getTitanArtifactFragmentTexture() : Texture
      {
         return AssetStorageUtil.getTitanArtifactFragmentTexture();
      }
      
      protected function update() : void
      {
         if(artifact)
         {
            item_border_image.image.texture = getTitanArtifactFragmentTexture();
            item_image.image.texture = AssetStorage.rsx.titan_artifact_icons.getTexture(artifact.assetTexture);
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.addSource(this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.removeSource(this);
      }
   }
}
