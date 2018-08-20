package engine.core.utils.property
{
   import avmplus.getQualifiedClassName;
   
   public class ObjectPropertyWriteable extends ObjectProperty
   {
       
      
      public function ObjectPropertyWriteable(param1:Class, param2:Object = null)
      {
         super(param1,param2);
      }
      
      override public function set value(param1:Object) : void
      {
         if(_value != param1)
         {
            if(param1 != null && !(param1 is _type))
            {
               throw ArgumentError("Invalid type, should be " + getQualifiedClassName(_type) + " but " + param1 + " received");
            }
            _value = param1;
            if(_signal)
            {
               _signal.dispatch(param1);
            }
         }
      }
   }
}
