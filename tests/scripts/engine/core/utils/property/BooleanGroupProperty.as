package engine.core.utils.property
{
   import engine.core.utils.VectorUtil;
   
   public class BooleanGroupProperty implements IBooleanGroupProperty
   {
       
      
      private var properties:Vector.<BooleanProperty>;
      
      private var _value:Array;
      
      private var _callbacks:Vector.<Function>;
      
      private var _currentCallbacksInDispatch:Boolean = false;
      
      public function BooleanGroupProperty(param1:BooleanProperty, param2:BooleanProperty, ... rest)
      {
         properties = new Vector.<BooleanProperty>();
         _value = [];
         _callbacks = new Vector.<Function>();
         super();
         addProperty(param1);
         addProperty(param2);
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc4_ in rest)
         {
            addProperty(_loc4_);
         }
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get value() : Array
      {
         return _value;
      }
      
      public function onValue(param1:Function) : void
      {
         if(_currentCallbacksInDispatch)
         {
            _callbacks = _callbacks.concat();
            _currentCallbacksInDispatch = false;
         }
         _callbacks.push(param1);
         param1.apply(null,_value);
      }
      
      public function unsubscribe(param1:Function) : void
      {
         if(_currentCallbacksInDispatch)
         {
            _callbacks = _callbacks.concat();
            _currentCallbacksInDispatch = false;
         }
         VectorUtil.remove(_callbacks,param1);
      }
      
      protected function addProperty(param1:BooleanProperty) : void
      {
         properties.push(param1);
         _value.push(param1.value);
         param1.signal_update.add(handler_updateProperty);
      }
      
      private function handler_updateProperty(param1:Boolean) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
