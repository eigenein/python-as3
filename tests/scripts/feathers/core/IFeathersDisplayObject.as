package feathers.core
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Stage;
   import starling.filters.FragmentFilter;
   
   public interface IFeathersDisplayObject extends IFeathersEventDispatcher
   {
       
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function get width() : Number;
      
      function set width(param1:Number) : void;
      
      function get height() : Number;
      
      function set height(param1:Number) : void;
      
      function get pivotX() : Number;
      
      function set pivotX(param1:Number) : void;
      
      function get pivotY() : Number;
      
      function set pivotY(param1:Number) : void;
      
      function get scaleX() : Number;
      
      function set scaleX(param1:Number) : void;
      
      function get scaleY() : Number;
      
      function set scaleY(param1:Number) : void;
      
      function get skewX() : Number;
      
      function set skewX(param1:Number) : void;
      
      function get skewY() : Number;
      
      function set skewY(param1:Number) : void;
      
      function get blendMode() : String;
      
      function set blendMode(param1:String) : void;
      
      function get name() : String;
      
      function set name(param1:String) : void;
      
      function get touchable() : Boolean;
      
      function set touchable(param1:Boolean) : void;
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get alpha() : Number;
      
      function set alpha(param1:Number) : void;
      
      function get rotation() : Number;
      
      function set rotation(param1:Number) : void;
      
      function get parent() : DisplayObjectContainer;
      
      function get base() : DisplayObject;
      
      function get root() : DisplayObject;
      
      function get stage() : Stage;
      
      function get hasVisibleArea() : Boolean;
      
      function get transformationMatrix() : Matrix;
      
      function get useHandCursor() : Boolean;
      
      function set useHandCursor(param1:Boolean) : void;
      
      function get bounds() : Rectangle;
      
      function get filter() : FragmentFilter;
      
      function set filter(param1:FragmentFilter) : void;
      
      function removeFromParent(param1:Boolean = false) : void;
      
      function hitTest(param1:Point, param2:Boolean = false) : DisplayObject;
      
      function localToGlobal(param1:Point, param2:Point = null) : Point;
      
      function globalToLocal(param1:Point, param2:Point = null) : Point;
      
      function getTransformationMatrix(param1:DisplayObject, param2:Matrix = null) : Matrix;
      
      function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle;
      
      function render(param1:RenderSupport, param2:Number) : void;
      
      function dispose() : void;
   }
}
