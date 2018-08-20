package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipImageBase;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class ClipProgressBar extends GuiClipNestedContainer
   {
       
      
      protected var minWidth:int;
      
      protected var maxWidth:int;
      
      public var fill:GuiClipImageBase;
      
      public var bg:GuiClipImageBase;
      
      private var _value:Number;
      
      private var _maxValue:int = 1;
      
      private var _minValue:int;
      
      public function ClipProgressBar()
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
            fill.graphics.width = Math.round(maxWidth * Math.min(1,(_value - _minValue) / (_maxValue - _minValue)));
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         maxWidth = Math.round(fill.graphics.width);
      }
      
      protected function createFill() : void
      {
         bg = new GuiClipScale3Image(6,2);
         fill = new GuiClipImage();
         minWidth = 4;
      }
   }
}
