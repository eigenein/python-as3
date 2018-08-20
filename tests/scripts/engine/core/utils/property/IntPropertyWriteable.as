package engine.core.utils.property
{
   public class IntPropertyWriteable extends IntProperty
   {
       
      
      public function IntPropertyWriteable(param1:int = 0)
      {
         super(param1);
      }
      
      override public function set value(param1:int) : void
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
