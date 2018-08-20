package game.view.popup.inventory
{
   import engine.core.clipgui.GuiClipFactory;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class PlayerInventoryPopupItemRenderer extends ListItemRenderer implements ITooltipSource
   {
       
      
      private var tileClip:PlayerInventoryItemTile;
      
      private var selectionClip:GuiClipScale9Image;
      
      protected var _tooltipVO:TooltipVO;
      
      public function PlayerInventoryPopupItemRenderer()
      {
         super();
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
         _tooltipVO = new TooltipVO(TooltipTextView,null);
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
            tileClip.item_counter.text = _loc1_.amount.toString();
            tileClip.item_counter.maxWidth = tileClip.item_image.image.width;
            tileClip.data = _loc1_;
            _tooltipVO.hintData = _loc1_.name;
            tileClip.marker_new.graphics.visible = _loc1_.notification;
         }
      }
      
      protected function commitSelectedState() : void
      {
         selectionClip.graphics.visible = isSelected;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         tileClip = new PlayerInventoryItemTile();
         var _loc1_:GuiClipFactory = AssetStorage.rsx.popup_theme.factory;
         _loc1_.create(tileClip,AssetStorage.rsx.popup_theme.data.getClipByName("inventory_tile2"));
         tileClip.marker_new.graphics.visible = false;
         width = tileClip.graphics.width;
         height = tileClip.graphics.height;
         selectionClip = AssetStorage.rsx.popup_theme.create(GuiClipScale9Image,"button_glow_23_23_2_2") as GuiClipScale9Image;
         var _loc2_:int = 88;
         selectionClip.graphics.height = _loc2_;
         selectionClip.graphics.width = _loc2_;
         _loc2_ = -2;
         selectionClip.graphics.y = _loc2_;
         selectionClip.graphics.x = _loc2_;
         addChild(selectionClip.graphics);
         addChild(tileClip.graphics);
         tileClip.signal_click.add(infoButtonClick);
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
         tileClip.item_counter.text = param1.amount.toString();
         tileClip.item_counter.maxWidth = tileClip.item_image.image.width;
      }
      
      private function infoButtonClick() : void
      {
         if(!isSelected)
         {
            isSelected = true;
         }
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
