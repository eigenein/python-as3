package org.osflash.signals
{
   public class Slot implements ISlot
   {
       
      
      protected var _signal:IOnceSignal;
      
      protected var _enabled:Boolean = true;
      
      protected var _listener:Function;
      
      protected var _once:Boolean = false;
      
      protected var _priority:int = 0;
      
      protected var _params:Array;
      
      public function Slot(param1:Function, param2:IOnceSignal, param3:Boolean = false, param4:int = 0)
      {
         super();
         _listener = param1;
         _once = param3;
         _signal = param2;
         _priority = param4;
         verifyListener(param1);
      }
      
      public function execute0() : void
      {
         if(!_enabled)
         {
            return;
         }
         if(_once)
         {
            remove();
         }
         if(_params && _params.length)
         {
            _listener.apply(null,_params);
            return;
         }
         return;
         §§push(_listener());
      }
      
      public function execute1(param1:Object) : void
      {
         if(!_enabled)
         {
            return;
         }
         if(_once)
         {
            remove();
         }
         if(_params && _params.length)
         {
            _listener.apply(null,[param1].concat(_params));
            return;
         }
         return;
         §§push(_listener(param1));
      }
      
      public function execute(param1:Array) : void
      {
         if(!_enabled)
         {
            return;
         }
         if(_once)
         {
            remove();
         }
         if(_params && _params.length)
         {
            param1 = param1.concat(_params);
         }
         var _loc2_:int = param1.length;
         if(_loc2_ == 0)
         {
            _listener();
         }
         else if(_loc2_ == 1)
         {
            _listener(param1[0]);
         }
         else if(_loc2_ == 2)
         {
            _listener(param1[0],param1[1]);
         }
         else if(_loc2_ == 3)
         {
            _listener(param1[0],param1[1],param1[2]);
         }
         else
         {
            _listener.apply(null,param1);
         }
      }
      
      public function get listener() : Function
      {
         return _listener;
      }
      
      public function set listener(param1:Function) : void
      {
         if(null == param1)
         {
            throw new ArgumentError("Given listener is null.\nDid you want to set enabled to false instead?");
         }
         verifyListener(param1);
         _listener = param1;
      }
      
      public function get once() : Boolean
      {
         return _once;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function toString() : String
      {
         return "[Slot listener: " + _listener + ", once: " + _once + ", priority: " + _priority + ", enabled: " + _enabled + "]";
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
      }
      
      public function get params() : Array
      {
         return _params;
      }
      
      public function set params(param1:Array) : void
      {
         _params = param1;
      }
      
      public function remove() : void
      {
         _signal.remove(_listener);
      }
      
      protected function verifyListener(param1:Function) : void
      {
         if(null == param1)
         {
            throw new ArgumentError("Given listener is null.");
         }
         if(null == _signal)
         {
            throw new Error("Internal signal reference has not been set yet.");
         }
      }
   }
}
