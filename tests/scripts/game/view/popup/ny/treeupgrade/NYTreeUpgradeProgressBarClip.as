package game.view.popup.ny.treeupgrade
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImageBase;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   
   public class NYTreeUpgradeProgressBarClip extends GuiClipNestedContainer
   {
       
      
      protected var minHeight:int;
      
      protected var maxHeight:int;
      
      protected var fillOffsetY:Number;
      
      public var fill:GuiClipImageBase;
      
      public var bg:GuiClipImageBase;
      
      private var _value:Number;
      
      private var _maxValue:int = 1;
      
      private var _minValue:int;
      
      public function NYTreeUpgradeProgressBarClip()
      {
         super();
         createFill();
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         if(_value == param1)
         {
            return;
         }
         _value = param1;
         updateFillWidth();
      }
      
      public function get maxValue() : int
      {
         return _maxValue;
      }
      
      public function set maxValue(param1:int) : void
      {
         if(_maxValue == param1)
         {
            return;
         }
         _maxValue = param1;
         updateFillWidth();
      }
      
      public function get minValue() : int
      {
         return _minValue;
      }
      
      public function set minValue(param1:int) : void
      {
         if(_minValue == param1)
         {
            return;
         }
         _minValue = param1;
         updateFillWidth();
      }
      
      protected function updateFillWidth() : void
      {
         if(fill)
         {
            fill.graphics.visible = _value != 0;
            fill.graphics.height = Math.round(maxHeight * Math.min(1,(_value - _minValue) / (_maxValue - _minValue)));
            fill.graphics.y = bg.graphics.y + bg.graphics.height - fillOffsetY - fill.graphics.height;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         maxHeight = Math.round(fill.graphics.height);
         fillOffsetY = fill.graphics.y - bg.graphics.y;
      }
      
      protected function createFill() : void
      {
         bg = new GuiClipScale9Image(new Rectangle(0,9,27,6));
         fill = new GuiClipScale9Image(new Rectangle(0,6,21,5));
         minHeight = 4;
      }
   }
}
