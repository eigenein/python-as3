package org.osflash.signals
{
   public interface IOnceSignal
   {
       
      
      function get valueClasses() : Array;
      
      function set valueClasses(param1:Array) : void;
      
      function get numListeners() : uint;
      
      function addOnce(param1:Function) : ISlot;
      
      function dispatch(... rest) : void;
      
      function remove(param1:Function) : ISlot;
      
      function removeAll() : void;
   }
}
