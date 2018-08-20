package engine.core.utils.property
{
   public class NumberPropertyWriteable extends NumberProperty
   {
       
      
      public function NumberPropertyWriteable(param1:Number = NaN)
      {
         super(param1);
      }
      
      override public function set value(param1:Number) : void
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
   }
}
