package engine.core.utils.property
{
   public class StringPropertyWriteable extends StringProperty
   {
       
      
      public function StringPropertyWriteable(param1:String = null)
      {
         super(param1);
      }
      
      override public function set value(param1:String) : void
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
