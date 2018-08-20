package feathers.core
{
   import starling.display.DisplayObjectContainer;
   
   public interface IFocusManager
   {
       
      
      function get isEnabled() : Boolean;
      
      function set isEnabled(param1:Boolean) : void;
      
      function get focus() : IFocusDisplayObject;
      
      function set focus(param1:IFocusDisplayObject) : void;
      
      function get root() : DisplayObjectContainer;
   }
}
