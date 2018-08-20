package game.view.popup.common.resourcepanel
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.util.NumberUtils;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.SpecialClipLabel;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.events.Event;
   import starling.filters.ColorMatrixFilter;
   
   public class PopupResourcePanelBase extends ClipButton implements ITooltipSource
   {
       
      
      private var useTween:Boolean = false;
      
      private var useTween_numbers:Boolean = true;
      
      protected var numberTween:Tween;
      
      protected var lastDigitCount:int;
      
      private var _tooltipVO:TooltipVO;
      
      public var button_plus:ClipSprite;
      
      public var tf_value:SpecialClipLabel;
      
      public var icon_marker:GuiClipImage;
      
      public var scalePlate:GuiClipScale3Image;
      
      protected var _signal_resize:Signal;
      
      protected var _item:ResourcePanelValueObject;
      
      private var _animatedAmount:int;
      
      private var _animatedFilter:Number = 0;
      
      public function PopupResourcePanelBase()
      {
         button_plus = new ClipSprite();
         tf_value = new SpecialClipLabel(true);
         icon_marker = new GuiClipImage();
         _signal_resize = new Signal();
         super();
      }
      
      public function dispose() : void
      {
         if(numberTween)
         {
            Starling.juggler.remove(numberTween);
         }
         if(_item)
         {
            _item.signal_amountUpdate.remove(handler_itemUpdate);
         }
         signal_click.clear();
         signal_resize.clear();
         graphics.dispose();
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get signal_resize() : Signal
      {
         return _signal_resize;
      }
      
      public function get data() : ResourcePanelValueObject
      {
         return _item;
      }
      
      public function set data(param1:ResourcePanelValueObject) : void
      {
         _item = param1;
         useTween = param1.animateChanges;
         icon_marker.image.texture = AssetStorageUtil.getItemGUIIcon(param1.item);
         _item.signal_amountUpdate.add(handler_itemUpdate);
         if(!param1.canRefill)
         {
            if(button_plus.graphics.parent)
            {
               button_plus.graphics.parent.removeChild(button_plus.graphics);
            }
         }
         else
         {
            signal_click.add(handler_refill);
         }
         _animatedAmount = _item.amount;
         lastDigitCount = NumberUtils.numberToString(_animatedAmount).length;
         updateAmount(true);
         _signal_resize.dispatch();
         if(param1.tooltipData)
         {
            _tooltipVO = new TooltipVO(param1.tooltipData.rendererType,param1.tooltipData);
         }
      }
      
      public function get animatedAmount() : int
      {
         return _animatedAmount;
      }
      
      public function set animatedAmount(param1:int) : void
      {
         if(_animatedAmount == param1)
         {
            return;
         }
         _animatedAmount = param1;
         updateAmount();
      }
      
      public function get animatedFilter() : Number
      {
         return _animatedFilter;
      }
      
      public function set animatedFilter(param1:Number) : void
      {
         var _loc3_:* = null;
         if(_animatedFilter == param1)
         {
            return;
         }
         _animatedFilter = param1;
         var _loc2_:Number = 0.3 * Math.abs(Math.sin(param1));
         if(_loc2_)
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(_loc2_);
            icon_marker.graphics.filter = _loc3_;
         }
         else if(icon_marker.graphics.filter)
         {
            icon_marker.graphics.filter.dispose();
            icon_marker.graphics.filter = null;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_value.minWidth = 45;
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      protected function updateAmount(param1:Boolean = false) : void
      {
         var _loc3_:int = tf_value.width;
         var _loc2_:String = NumberUtils.numberToString(animatedAmount);
         if(data.useRedColor)
         {
            tf_value.text = ColorUtils.hexToRGBFormat(16742263) + _loc2_;
         }
         else
         {
            tf_value.text = _loc2_;
         }
         if(param1 || _loc2_.length != lastDigitCount)
         {
            tf_value.validate();
            formatTextWidth();
            lastDigitCount = _loc2_.length;
            if(tf_value.width != _loc3_)
            {
               _signal_resize.dispatch();
            }
         }
      }
      
      protected function formatTextWidth() : void
      {
         if(button_plus.graphics.visible)
         {
            button_plus.graphics.x = tf_value.x + tf_value.width + 4;
            scalePlate.graphics.width = tf_value.x + tf_value.width + 20 - scalePlate.graphics.x;
         }
         else
         {
            scalePlate.graphics.width = tf_value.x + tf_value.width + 10 - scalePlate.graphics.x;
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            button_plus.graphics.filter = _loc3_;
         }
         else if(button_plus.graphics.filter)
         {
            button_plus.graphics.filter.dispose();
            button_plus.graphics.filter = null;
         }
      }
      
      protected function handler_itemUpdate(param1:ResourcePanelValueObject) : void
      {
         if(useTween)
         {
            if(numberTween)
            {
               Starling.juggler.remove(numberTween);
            }
            if(useTween_numbers)
            {
               numberTween = new Tween(this,2);
               numberTween.animate("animatedAmount",param1.amount);
               Starling.juggler.add(numberTween);
            }
            else
            {
               numberTween = new Tween(this,0.5);
               _animatedFilter = 0;
               numberTween.animate("animatedFilter",3.14159265358979 * 1);
               Starling.juggler.add(numberTween);
               _animatedAmount = param1.amount;
               updateAmount();
            }
         }
         else
         {
            _animatedAmount = param1.amount;
            updateAmount();
         }
      }
      
      protected function handler_refill() : void
      {
         _item.action_refill();
      }
      
      protected function handler_addedToStage(param1:Event) : void
      {
         if(_tooltipVO)
         {
            TooltipLayerMediator.instance.addSource(this);
         }
      }
      
      protected function handler_removedFromStage(param1:Event) : void
      {
         if(_tooltipVO)
         {
            TooltipLayerMediator.instance.removeSource(this);
         }
      }
   }
}
