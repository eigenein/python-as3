package org.osflash.signals
{
   public interface ISignal extends IOnceSignal
   {
       
      
      function add(param1:Function) : ISlot;
   }
}
