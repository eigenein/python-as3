package game.view.gui.components
{
   import feathers.layout.AnchorLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.events.Event;
   
   public class InventoryItemDescriptionRenderer extends ListItemRenderer implements ITooltipSource
   {
       
      
      protected var _desc:InventoryItemDescription;
      
      protected var itemImage:Image;
      
      protected var itemFrame:Image;
      
      protected var _tooltipVO:TooltipVO;
      
      public function InventoryItemDescriptionRenderer()
      {
         super();
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get desc() : InventoryItemDescription
      {
         return _desc;
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
         commitDataDesc(data as InventoryItemDescription);
      }
      
      protected function updateItemFrame() : void
      {
         itemFrame.texture = _desc.color.frameAsset;
      }
      
      protected function updateItemImage() : void
      {
         if(_desc is UnitDescription)
         {
            itemImage.texture = AssetStorage.inventory.getUnitSquareTexture(_desc as UnitDescription);
         }
         else
         {
            itemImage.texture = AssetStorage.inventory.getItemTexture(_desc);
         }
      }
      
      protected function updateTooltip() : void
      {
         _tooltipVO.hintData = _desc;
      }
      
      protected function commitDataDesc(param1:InventoryItemDescription) : void
      {
         _desc = param1;
         updateItemImage();
         updateItemFrame();
         updateTooltip();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layout = new AnchorLayout();
         itemImage = new Image(AssetStorage.rsx.popup_theme.missing_texture);
         addChild(itemImage);
         var _loc1_:int = 72;
         itemImage.height = _loc1_;
         itemImage.width = _loc1_;
         itemImage.x = 8;
         itemImage.y = 6;
         itemFrame = new Image(AssetStorage.rsx.popup_theme.getTexture("border_item_white"));
         addChild(itemFrame);
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_ADDED",true);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_REMOVED",true);
      }
   }
}
