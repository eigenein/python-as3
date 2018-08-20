package org.osflash.signals
{
   public class Signal extends OnceSignal implements ISignal
   {
       
      
      public function Signal(... rest)
      {
         rest = rest.length == 1 && rest[0] is Array?rest[0]:rest;
         super(rest);
      }
      
      public function setName(param1:String) : Signal
      {
         SignalWatcher.rename(this,param1);
         return this;
      }
      
      public function add(param1:Function) : ISlot
      {
         var _loc2_:ISlot = registerListener(param1);
         if(_loc2_)
         {
            SignalWatcher.add(this,param1);
         }
         return _loc2_;
      }
      
      override public function addOnce(param1:Function) : ISlot
      {
         var _loc2_:ISlot = super.addOnce(param1);
         if(_loc2_)
         {
            SignalWatcher.add(this,param1);
         }
         return _loc2_;
      }
      
      override public function remove(param1:Function) : ISlot
      {
         var _loc2_:ISlot = super.remove(param1);
         if(_loc2_)
         {
            SignalWatcher.remove(this,param1);
         }
         return _loc2_;
      }
      
      override public function removeAll() : void
      {
         super.removeAll();
         SignalWatcher.removeAll(this);
      }
   }
}
