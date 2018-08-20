package game.view.popup.shop.special
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.events.Event;
   
   public class SpecialShopInventoryItemRenderer extends GuiClipNestedContainer implements ITooltipSource
   {
       
      
      private const ALPHA:Number = 0.6;
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public var item_glow:GuiAnimation;
      
      public var image_plus:GuiAnimation;
      
      public var tf_discount:ClipLabel;
      
      public var discount_icon:ClipSprite;
      
      private var _data:HeroInventorySlotValueObject;
      
      protected var _tooltipVO:TooltipVO;
      
      public function SpecialShopInventoryItemRenderer()
      {
         image_frame = new GuiClipImage();
         image_item = new GuiClipImage();
         item_glow = new GuiAnimation();
         image_plus = new GuiAnimation();
         tf_discount = new ClipLabel();
         discount_icon = new ClipSprite();
         super();
         _tooltipVO = new TooltipVO(TooltipTextView,null);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         item_glow.graphics.visible = false;
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data)
         {
            _data.signal_updateSlotState.remove(onDataUpdate);
         }
         _data = param1 as HeroInventorySlotValueObject;
         if(_data)
         {
            _data.signal_updateSlotState.add(onDataUpdate);
         }
         commitData();
      }
      
      public function setSelected() : void
      {
         var _loc1_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc1_.slotState != 2)
         {
            item_glow.graphics.visible = true;
            image_plus.graphics.visible = true;
            var _loc2_:Boolean = false;
            discount_icon.graphics.visible = _loc2_;
            tf_discount.visible = _loc2_;
         }
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      protected function commitData() : void
      {
         var _loc1_:* = false;
         var _loc2_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc2_)
         {
            image_frame.image.texture = _loc2_.qualityFrame;
            image_item.image.texture = _loc2_.icon;
            _loc1_ = _loc2_.slotState == 2;
            if(_loc1_)
            {
               if(image_item.image.filter)
               {
                  image_item.image.filter.dispose();
                  image_item.image.filter = null;
               }
               item_glow.graphics.visible = false;
               image_plus.graphics.visible = false;
               var _loc3_:Boolean = false;
               discount_icon.graphics.visible = _loc3_;
               tf_discount.visible = _loc3_;
               image_item.image.alpha = 0.6;
               image_frame.image.alpha = 0.6;
            }
            else
            {
               image_item.image.filter = AssetStorage.rsx.popup_theme.filter_disabled;
               image_item.image.alpha = 1;
               image_frame.image.alpha = 1;
            }
            _tooltipVO.hintData = _loc2_.name;
         }
      }
      
      private function onDataUpdate() : void
      {
         commitData();
         var _loc1_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc1_ && _loc1_.slotState == 2)
         {
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
