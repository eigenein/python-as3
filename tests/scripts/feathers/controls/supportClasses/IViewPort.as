package feathers.controls.supportClasses
{
   import feathers.core.IFeathersControl;
   
   [ExcludeClass]
   public interface IViewPort extends IFeathersControl
   {
       
      
      function get visibleWidth() : Number;
      
      function set visibleWidth(param1:Number) : void;
      
      function get minVisibleWidth() : Number;
      
      function set minVisibleWidth(param1:Number) : void;
      
      function get maxVisibleWidth() : Number;
      
      function set maxVisibleWidth(param1:Number) : void;
      
      function get visibleHeight() : Number;
      
      function set visibleHeight(param1:Number) : void;
      
      function get minVisibleHeight() : Number;
      
      function set minVisibleHeight(param1:Number) : void;
      
      function get maxVisibleHeight() : Number;
      
      function set maxVisibleHeight(param1:Number) : void;
      
      function get contentX() : Number;
      
      function get contentY() : Number;
      
      function get horizontalScrollPosition() : Number;
      
      function set horizontalScrollPosition(param1:Number) : void;
      
      function get verticalScrollPosition() : Number;
      
      function set verticalScrollPosition(param1:Number) : void;
      
      function get horizontalScrollStep() : Number;
      
      function get verticalScrollStep() : Number;
   }
}
