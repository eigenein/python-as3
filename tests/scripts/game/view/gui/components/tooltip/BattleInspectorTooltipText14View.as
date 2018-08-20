package game.view.gui.components.tooltip
{
   import engine.core.utils.property.StringProperty;
   import feathers.controls.Label;
   import feathers.controls.LayoutGroup;
   import feathers.display.Scale9Image;
   import feathers.layout.VerticalLayout;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.ITooltipView;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.view.gui.components.GameLabel;
   import starling.display.DisplayObjectContainer;
   
   public class BattleInspectorTooltipText14View extends LayoutGroup implements ITooltipView
   {
       
      
      protected var _stringSource:StringProperty;
      
      protected var _label:Label;
      
      public function BattleInspectorTooltipText14View()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createLayout();
         createBackgroundSkin();
         createElements();
      }
      
      public function hide() : void
      {
         if(parent && this)
         {
            parent.removeChild(this);
         }
         if(_stringSource)
         {
            _stringSource.unsubscribe(handler_hintData);
            _stringSource = null;
         }
      }
      
      public function placeHint(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Function = !!param1.tooltipVO?param1.tooltipVO.placeFn:null;
         if(_loc3_ != null)
         {
            _loc3_.apply(this,[param1,param2]);
         }
         else
         {
            placeSelf(param1,param2);
         }
      }
      
      public function placeSelf(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Point = TooltipLayerMediator.calcPositionInScreen(this,param2);
         x = _loc3_.x;
         y = _loc3_.y;
      }
      
      public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         if(_stringSource)
         {
            _stringSource.unsubscribe(handler_hintData);
            _stringSource = null;
         }
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            if(param1.tooltipVO.hintData is StringProperty)
            {
               _stringSource = param1.tooltipVO.hintData as StringProperty;
               _stringSource.onValue(handler_hintData);
            }
            else
            {
               _label.text = String(param1.tooltipVO.hintData);
               draw();
            }
         }
      }
      
      protected function createElements() : void
      {
         _label = GameLabel.special14();
         _label.wordWrap = true;
         _label.maxWidth = 450;
         addChild(_label);
      }
      
      protected function createBackgroundSkin() : void
      {
         var _loc1_:Rectangle = new Rectangle(16,16,16,16);
         backgroundSkin = new Scale9Image(AssetStorage.rsx.popup_theme.getScale9Textures("tooltipBG_16_16_16_16",_loc1_));
      }
      
      protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         layout = _loc1_;
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.padding = 15;
      }
      
      private function handler_hintData(param1:String) : void
      {
         _label.text = param1;
         draw();
         var _loc2_:Point = TooltipLayerMediator.calcPosition(this,parent);
         x = _loc2_.x;
         y = _loc2_.y;
      }
   }
}
