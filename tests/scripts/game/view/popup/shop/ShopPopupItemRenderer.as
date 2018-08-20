package game.view.popup.shop
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class ShopPopupItemRenderer extends ListItemRenderer implements ITooltipSource
   {
       
      
      private var clip:ShopTileClip;
      
      private var _tooltipVO:TooltipVO;
      
      private var _signal_buySlot:Signal;
      
      private var _signal_showInfo:Signal;
      
      public function ShopPopupItemRenderer()
      {
         super();
         _signal_buySlot = new Signal(ShopSlotValueObject);
         _signal_showInfo = new Signal(ShopSlotValueObject);
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get signal_buySlot() : Signal
      {
         return _signal_buySlot;
      }
      
      public function get signal_showInfo() : Signal
      {
         return _signal_showInfo;
      }
      
      override protected function commitData() : void
      {
         var _loc1_:ShopSlotValueObject = data as ShopSlotValueObject;
         if(_loc1_)
         {
            _tooltipVO.hintData = _loc1_.item;
            clip.tf_item_name.text = _loc1_.name;
            clip.item_renderer.data = _loc1_.item;
            clip.item_renderer.isEnabled = !_loc1_.bought;
            AssetStorage.rsx.popup_theme.setDisabledFilter(clip.item_renderer.graphics,_loc1_.bought);
            clip.item_renderer.graphics.touchable = _loc1_.hasExtendedInfo;
            clip.button_buy.graphics.visible = !_loc1_.bought;
            clip.cost_panel.graphics.visible = !_loc1_.bought;
            clip.tf_bought.visible = _loc1_.bought;
            clip.cost_panel.costData = _loc1_.cost.outputDisplayFirst;
            clip.cost_panel.graphics.x = clip.button_buy.graphics.x + (clip.button_buy.graphics.width - clip.cost_panel.graphics.width) / 2;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ShopSlotValueObject = data as ShopSlotValueObject;
         if(_loc2_)
         {
            _loc2_.updateSignal.remove(onDataUpdate);
         }
         .super.data = param1;
         _loc2_ = data as ShopSlotValueObject;
         if(_loc2_)
         {
            _loc2_.updateSignal.add(onDataUpdate);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_renderer_shop();
         addChild(clip.graphics);
         clip.button_buy.signal_click.add(handler_click_buy);
         clip.tf_bought.text = Translate.translate("UI_SHOP_SLOT_BOUGHT");
         clip.button_buy.label = Translate.translate("UI_SHOP_BUY");
         clip.item_renderer.signal_click.add(handler_click_info);
      }
      
      private function onDataUpdate() : void
      {
         invalidate("data");
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_ADDED",true);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_REMOVED",true);
      }
      
      private function handler_click_info() : void
      {
         var _loc1_:ShopSlotValueObject = data as ShopSlotValueObject;
         if(_loc1_)
         {
            _signal_showInfo.dispatch(_loc1_);
         }
      }
      
      private function handler_click_buy() : void
      {
         var _loc1_:ShopSlotValueObject = data as ShopSlotValueObject;
         if(_loc1_)
         {
            _signal_buySlot.dispatch(_loc1_);
         }
      }
   }
}
