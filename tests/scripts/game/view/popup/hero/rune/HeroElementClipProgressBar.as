package game.view.popup.hero.rune
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImageBase;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   
   public class HeroElementClipProgressBar extends GuiClipNestedContainer
   {
       
      
      protected var minWidth:int;
      
      protected var maxWidth:int;
      
      public var fill:ClipSprite;
      
      public var bg:GuiClipImageBase;
      
      public var glow_left:ClipSprite;
      
      public var glow_right:ClipSprite;
      
      private var _value:Number;
      
      private var _maxValue:int = 1;
      
      private var _minValue:int;
      
      public function HeroElementClipProgressBar()
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
         var _loc1_:Rectangle = new Rectangle(0,0,Math.min(1,(_value - _minValue) / (_maxValue - _minValue)) * maxWidth,fill.graphics.height);
         (fill.graphics as Sprite).clipRect = _loc1_;
         fill.graphics.visible = _value != 0;
         glow_left.graphics.width = Math.min(58,_loc1_.width);
         glow_left.graphics.x = int(fill.graphics.x + _loc1_.width - glow_left.graphics.width);
         glow_left.graphics.visible = _loc1_.width >= 0 && _loc1_.width < maxWidth;
         glow_right.graphics.x = glow_left.graphics.x + glow_left.graphics.width - 1;
         glow_right.graphics.visible = _loc1_.width > 0 && _loc1_.width < maxWidth;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         maxWidth = Math.round(fill.graphics.width);
      }
      
      protected function createFill() : void
      {
         bg = new GuiClipScale3Image(6,2);
         glow_left = new ClipSprite();
         glow_right = new ClipSprite();
         fill = new ClipSprite();
         minWidth = 4;
      }
   }
}
