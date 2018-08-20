package game.view.popup.common
{
   import game.mediator.gui.component.SelectableInventoryItemValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import starling.events.Event;
   
   public class ClipListItemSelectableInventoryItemWithTooltip extends ClipListItemSelectableInventoryItem implements ITooltipSource
   {
       
      
      protected var _tooltipVO:TooltipVO;
      
      public function ClipListItemSelectableInventoryItemWithTooltip()
      {
         super();
         createTooltip();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         graphics.removeEventListener("addedToStage",handler_addedToStage);
         graphics.removeEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setData(param1:*) : void
      {
         if(param1 is SelectableInventoryItemValueObject)
         {
            _tooltipVO.hintData = (param1 as SelectableInventoryItemValueObject).inventoryItem;
         }
         super.setData(param1);
      }
      
      protected function createTooltip() : void
      {
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         graphics.dispatchEventWith("TooltipEventType.SOURCE_ADDED",true,this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         graphics.dispatchEventWith("TooltipEventType.SOURCE_REMOVED",true,this);
      }
   }
}
