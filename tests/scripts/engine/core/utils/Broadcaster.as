package engine.core.utils
{
   public final class Broadcaster
   {
       
      
      private var _context;
      
      private var _listeners:Vector.<Function>;
      
      public function Broadcaster(param1:* = null)
      {
         super();
         _context = param1;
         _listeners = new Vector.<Function>();
      }
      
      public function addListener(param1:Function) : void
      {
         if(_listeners.length)
         {
            _listeners[_listeners.length] = _listeners[0];
         }
         _listeners[0] = param1;
      }
      
      public function removeListener(param1:Function) : void
      {
         var _loc2_:int = _listeners.indexOf(param1);
         if(_loc2_ != -1)
         {
            _listeners[_loc2_] = _listeners[_listeners.length - 1];
            _listeners.length--;
         }
      }
      
      public function dispatch() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function purge() : void
      {
         _listeners.length = 0;
      }
   }
}
