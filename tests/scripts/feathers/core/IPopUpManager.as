package feathers.core
{
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public interface IPopUpManager
   {
       
      
      function get overlayFactory() : Function;
      
      function set overlayFactory(param1:Function) : void;
      
      function get root() : DisplayObjectContainer;
      
      function set root(param1:DisplayObjectContainer) : void;
      
      function addPopUp(param1:DisplayObject, param2:Boolean = true, param3:Boolean = true, param4:Function = null) : DisplayObject;
      
      function removePopUp(param1:DisplayObject, param2:Boolean = false) : DisplayObject;
      
      function isPopUp(param1:DisplayObject) : Boolean;
      
      function isTopLevelPopUp(param1:DisplayObject) : Boolean;
      
      function centerPopUp(param1:DisplayObject) : void;
   }
}
