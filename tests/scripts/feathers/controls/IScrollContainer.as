package feathers.controls
{
   import feathers.core.IFeathersControl;
   import starling.display.DisplayObject;
   
   public interface IScrollContainer extends IFeathersControl
   {
       
      
      function get numRawChildren() : int;
      
      function getRawChildByName(param1:String) : DisplayObject;
      
      function getRawChildIndex(param1:DisplayObject) : int;
      
      function setRawChildIndex(param1:DisplayObject, param2:int) : void;
      
      function addRawChild(param1:DisplayObject) : DisplayObject;
      
      function addRawChildAt(param1:DisplayObject, param2:int) : DisplayObject;
      
      function removeRawChild(param1:DisplayObject, param2:Boolean = false) : DisplayObject;
      
      function removeRawChildAt(param1:int, param2:Boolean = false) : DisplayObject;
      
      function swapRawChildren(param1:DisplayObject, param2:DisplayObject) : void;
      
      function swapRawChildrenAt(param1:int, param2:int) : void;
      
      function sortRawChildren(param1:Function) : void;
   }
}
