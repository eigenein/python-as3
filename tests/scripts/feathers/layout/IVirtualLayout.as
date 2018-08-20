package feathers.layout
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public interface IVirtualLayout extends ILayout
   {
       
      
      function get useVirtualLayout() : Boolean;
      
      function set useVirtualLayout(param1:Boolean) : void;
      
      function get typicalItem() : DisplayObject;
      
      function set typicalItem(param1:DisplayObject) : void;
      
      function measureViewPort(param1:int, param2:ViewPortBounds = null, param3:Point = null) : Point;
      
      function getVisibleIndicesAtScrollPosition(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int> = null) : Vector.<int>;
   }
}
