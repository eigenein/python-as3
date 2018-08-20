package game.view.popup.artifactchest.rewardpopup
{
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class ArtifactChestRewardPopupItemRendererWithMultiplier extends ListItemRenderer implements ITooltipSource
   {
       
      
      private var _tileClip:ArtifactChestRewardPopupItemTile;
      
      private var selectionClip:GuiClipScale9Image;
      
      protected var _tooltipVO:TooltipVO;
      
      public function ArtifactChestRewardPopupItemRendererWithMultiplier()
      {
         super();
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
      }
      
      override public function dispose() : void
      {
         var _loc1_:InventoryItem = data as InventoryItem;
         if(_loc1_)
         {
            _loc1_.signal_update.remove(countListener);
         }
         super.dispose();
      }
      
      public function get tileClip() : ArtifactChestRewardPopupItemTile
      {
         return _tileClip;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:InventoryItem = data as InventoryItem;
         if(_loc2_)
         {
            _loc2_.signal_update.remove(countListener);
         }
         .super.data = param1;
         _loc2_ = data as InventoryItem;
         if(_loc2_)
         {
            _loc2_.signal_update.add(countListener);
         }
      }
      
      override public function get isSelected() : Boolean
      {
         return super.isSelected;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         .super.isSelected = param1;
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
         var _loc1_:InventoryItem = data as InventoryItem;
         if(_loc1_)
         {
            _tileClip.item_counter.text = _loc1_.amount.toString();
            _tileClip.item_counter.maxWidth = _tileClip.item_image.image.width;
            _tileClip.data = _loc1_;
            _tileClip.marker_new.graphics.visible = _loc1_.notification;
            _tooltipVO.hintData = _loc1_;
         }
      }
      
      protected function commitSelectedState() : void
      {
         selectionClip.graphics.visible = isSelected;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _tileClip = new ArtifactChestRewardPopupItemTile();
         _tileClip.showMultiplier = true;
         AssetStorage.rsx.popup_theme.initGuiClip(_tileClip,"inventory_tile_with_multiplier");
         _tileClip.marker_new.graphics.visible = false;
         width = _tileClip.graphics.width;
         height = _tileClip.graphics.height;
         selectionClip = AssetStorage.rsx.popup_theme.create(GuiClipScale9Image,"button_glow_23_23_2_2") as GuiClipScale9Image;
         var _loc1_:int = 88;
         selectionClip.graphics.height = _loc1_;
         selectionClip.graphics.width = _loc1_;
         _loc1_ = -2;
         selectionClip.graphics.y = _loc1_;
         selectionClip.graphics.x = _loc1_;
         addChild(selectionClip.graphics);
         addChild(_tileClip.graphics);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("selected"))
         {
            commitSelectedState();
         }
      }
      
      private function countListener(param1:InventoryItem) : void
      {
         _tileClip.item_counter.text = param1.amount.toString();
         _tileClip.item_counter.maxWidth = _tileClip.item_image.image.width;
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
