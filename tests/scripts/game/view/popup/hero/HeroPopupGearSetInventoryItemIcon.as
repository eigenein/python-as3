package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.gui.components.tooltip.TooltipTextView;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class HeroPopupGearSetInventoryItemIcon extends InventoryItemIcon implements ITooltipSource
   {
       
      
      private var desc:InventoryItemDescription;
      
      private var _tooltipVO:TooltipVO;
      
      private var _signal_clickData:Signal;
      
      public function HeroPopupGearSetInventoryItemIcon()
      {
         _signal_clickData = new Signal(InventoryItemDescription);
         super();
         _tooltipVO = new TooltipVO(TooltipTextView,null);
      }
      
      public function get signal_clickData() : Signal
      {
         return _signal_clickData;
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setItem(param1:InventoryItem) : void
      {
         super.setItem(param1);
         desc = param1.item;
         _tooltipVO.hintData = param1.name;
      }
      
      override public function setItemDescription(param1:InventoryItemDescription) : void
      {
         super.setItemDescription(param1);
         desc = param1;
         _tooltipVO.hintData = param1.name;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      override public function click() : void
      {
         super.click();
         _signal_clickData.dispatch(desc);
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
