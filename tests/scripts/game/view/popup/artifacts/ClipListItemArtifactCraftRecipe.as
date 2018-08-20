package game.view.popup.artifacts
{
   import com.progrestar.framework.ares.core.Node;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.hero.slot.ClipListItemCraftRecipe;
   import starling.events.Event;
   
   public class ClipListItemArtifactCraftRecipe extends ClipListItemCraftRecipe implements ITooltipSource
   {
       
      
      private var _tooltipVO:TooltipVO;
      
      public function ClipListItemArtifactCraftRecipe()
      {
         _tooltipVO = new TooltipVO(TooltipTextView,null);
         super();
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         var _loc2_:InventoryItemValueObject = param1 as InventoryItemValueObject;
         if(_loc2_)
         {
            _tooltipVO.hintData = _loc2_.item.name;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
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
