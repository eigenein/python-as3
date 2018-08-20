package game.view.popup.artifactchest
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.events.Event;
   
   public class ArtifactChestProgressBarClip extends ClipProgressBar implements ITooltipSource
   {
       
      
      public var tf_progress_value:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      private var _tooltipVO:TooltipVO;
      
      public function ArtifactChestProgressBarClip()
      {
         tf_progress_value = new ClipLabel();
         tf_level = new ClipLabel();
         super();
         _tooltipVO = new TooltipVO(TooltipTextView,null);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tooltipVO.hintData = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_LEVEL_TOOLTIP");
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      override protected function createFill() : void
      {
         bg = new GuiClipImage();
         fill = new GuiClipScale3Image();
         minWidth = 13;
      }
      
      override protected function updateFillWidth() : void
      {
         if(fill)
         {
            if(maxValue == 0)
            {
               fill.graphics.visible = true;
               fill.graphics.width = maxWidth;
               tf_progress_value.text = Math.round(value).toString();
            }
            else
            {
               fill.graphics.visible = value != 0;
               fill.graphics.width = Math.round(maxWidth * Math.min(1,(value - minValue) / (maxValue - minValue)));
               tf_progress_value.text = Math.round(value) + "/" + Math.round(maxValue);
            }
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
