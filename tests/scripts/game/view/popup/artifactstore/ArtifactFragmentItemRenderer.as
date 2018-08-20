package game.view.popup.artifactstore
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.artifact.ArtifactDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.tooltip.ArtifactFragmentTooltip;
   import starling.events.Event;
   
   public class ArtifactFragmentItemRenderer extends ClipButton implements ITooltipSource
   {
       
      
      private var artifact:ArtifactDescription;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      private var _tooltipVO:TooltipVO;
      
      public function ArtifactFragmentItemRenderer()
      {
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         _tooltipVO = new TooltipVO(ArtifactFragmentTooltip,null);
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
         artifact = param1 as ArtifactDescription;
         _tooltipVO.hintData = artifact;
         update();
      }
      
      private function update() : void
      {
         if(artifact)
         {
            item_border_image.image.texture = AssetStorageUtil.getArtifactFragmentTexture();
            item_image.image.texture = AssetStorage.rsx.artifact_icons.getTexture(artifact.assetTexture);
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
