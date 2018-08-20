package org.osflash.signals.natives
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import org.osflash.signals.IPrioritySignal;
   
   public interface INativeDispatcher extends IPrioritySignal
   {
       
      
      function get eventType() : String;
      
      function get eventClass() : Class;
      
      function get target() : IEventDispatcher;
      
      function set target(param1:IEventDispatcher) : void;
      
      function dispatchEvent(param1:Event) : Boolean;
   }
}
