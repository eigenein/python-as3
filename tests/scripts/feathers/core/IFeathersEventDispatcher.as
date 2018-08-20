package feathers.core
{
   import starling.events.Event;
   
   public interface IFeathersEventDispatcher
   {
       
      
      function addEventListener(param1:String, param2:Function) : void;
      
      function removeEventListener(param1:String, param2:Function) : void;
      
      function removeEventListeners(param1:String = null) : void;
      
      function dispatchEvent(param1:Event) : void;
      
      function dispatchEventWith(param1:String, param2:Boolean = false, param3:Object = null) : void;
      
      function hasEventListener(param1:String) : Boolean;
   }
}
