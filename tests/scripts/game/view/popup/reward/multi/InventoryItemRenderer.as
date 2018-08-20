package game.view.popup.reward.multi
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.INeedNestedParsing;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.InventoryItemCounterClip;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import starling.events.Event;
   
   public class InventoryItemRenderer extends ClipListItem implements INeedNestedParsing, ITooltipSource
   {
       
      
      private var defaultCounterY:int;
      
      private var _tooltipVO:TooltipVO;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var item_counter:InventoryItemCounterClip;
      
      public function InventoryItemRenderer()
      {
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         item_counter = new InventoryItemCounterClip();
         super();
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         var _loc2_:InventoryItem = param1 as InventoryItem;
         if(_loc2_)
         {
            if(_loc2_.item is TitanDescription)
            {
               item_counter.graphics.y = 43;
            }
            else
            {
               item_counter.graphics.y = defaultCounterY;
            }
            item_counter.text = _loc2_.amount.toString();
            item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(_loc2_);
            item_image.image.texture = AssetStorageUtil.getItemTexture(_loc2_);
            item_counter.maxWidth = item_image.image.width;
            _tooltipVO.hintData = _loc2_;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         defaultCounterY = item_counter.graphics.y;
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
