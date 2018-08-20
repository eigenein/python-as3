package feathers.layout
{
   import feathers.core.IFeathersEventDispatcher;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   [Event(name="change",type="starling.events.Event")]
   public interface ILayout extends IFeathersEventDispatcher
   {
       
      
      function get requiresLayoutOnScroll() : Boolean;
      
      function layout(param1:Vector.<DisplayObject>, param2:ViewPortBounds = null, param3:LayoutBoundsResult = null) : LayoutBoundsResult;
      
      function getScrollPositionForIndex(param1:int, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number, param7:Point = null) : Point;
   }
}
