package feathers.layout
{
   import starling.display.DisplayObject;
   
   public interface IVariableVirtualLayout extends IVirtualLayout
   {
       
      
      function get hasVariableItemDimensions() : Boolean;
      
      function set hasVariableItemDimensions(param1:Boolean) : void;
      
      function resetVariableVirtualCache() : void;
      
      function resetVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void;
      
      function addToVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void;
      
      function removeFromVariableVirtualCacheAtIndex(param1:int) : void;
   }
}
