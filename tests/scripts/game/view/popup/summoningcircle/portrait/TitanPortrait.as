package game.view.popup.summoningcircle.portrait
{
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class TitanPortrait extends HeroPortrait implements ITooltipSource
   {
       
      
      private var _tooltipVO:TooltipVO;
      
      public function TitanPortrait()
      {
         super();
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         _tooltipVO.hintData = new InventoryItem((data as TitanEntryValueObject).titan,1);
         updateStars();
      }
      
      override public function updateStars() : void
      {
         starDisplay.setValue((data as TitanEntryValueObject).titan.startingStar.star.id);
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
