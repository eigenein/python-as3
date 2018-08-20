package feathers.core
{
   import starling.display.DisplayObject;
   
   public interface IFocusExtras
   {
       
      
      function get focusExtrasBefore() : Vector.<DisplayObject>;
      
      function get focusExtrasAfter() : Vector.<DisplayObject>;
   }
}
