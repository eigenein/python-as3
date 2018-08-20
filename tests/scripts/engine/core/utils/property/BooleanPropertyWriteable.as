package engine.core.utils.property
{
   public class BooleanPropertyWriteable extends BooleanProperty
   {
       
      
      public function BooleanPropertyWriteable(param1:Boolean = false)
      {
         super(param1);
      }
      
      override public function set value(param1:Boolean) : void
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
      
      public function toggle() : void
      {
         _value = !value;
         if(_signal)
         {
            _signal.dispatch(value);
         }
      }
   }
}
