package engine.core.utils.property
{
   import engine.core.utils.VectorUtil;
   
   public class VectorPropertyWriteable extends VectorProperty
   {
       
      
      public function VectorPropertyWriteable(param1:Vector.<*> = null)
      {
         super(param1);
      }
      
      override public function set value(param1:Vector.<*>) : void
      {
         if(_value != param1)
         {
            _value = param1;
            if(_signal)
            {
               _signal.dispatch(param1);
            }
         }
      }
      
      public function setValueSilently(param1:Vector.<*>) : void
      {
         _value = param1;
      }
      
      public function push(param1:*) : void
      {
         _value.push(param1);
         if(_signal)
         {
            _signal.dispatch(_value);
         }
      }
      
      public function pop() : *
      {
         var _loc1_:* = _value.pop();
         if(_signal)
         {
            _signal.dispatch(_value);
         }
         return _loc1_;
      }
      
      public function shift() : *
      {
         var _loc1_:* = _value.shift();
         if(_signal)
         {
            _signal.dispatch(_value);
         }
         return _loc1_;
      }
      
      public function unshift(param1:*) : void
      {
         _value.unshift(param1);
         if(_signal)
         {
            _signal.dispatch(_value);
         }
      }
      
      public function remove(param1:*) : Boolean
      {
         var _loc2_:int = _value.indexOf(param1);
         if(_loc2_ != -1)
         {
            VectorUtil.removeAt(_value,_loc2_);
            if(_signal)
            {
               _signal.dispatch(_value);
            }
            return true;
         }
         return false;
      }
   }
}
