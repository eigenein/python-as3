package engine.core.utils.property
{
   import org.osflash.signals.Signal;
   
   public class BooleanProperty
   {
       
      
      protected var _value:Boolean;
      
      protected var _signal:Signal;
      
      public function BooleanProperty(param1:Boolean = false)
      {
         super();
         _value = param1;
      }
      
      public function get signal_update() : Signal
      {
         if(_signal)
         {
            §§push(_signal);
         }
         else
         {
            _signal = new Signal(Boolean);
            §§push(new Signal(Boolean));
         }
         return §§pop();
      }
      
      public function get value() : Boolean
      {
         return _value;
      }
      
      public function set value(param1:Boolean) : void
      {
         throw "access restricted for write only " + this;
      }
      
      public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
      }
      
      public function setValueSilently(param1:Boolean) : void
      {
         _value = param1;
      }
      
      public function unsubscribe(param1:Function) : void
      {
         if(_signal)
         {
            _signal.remove(param1);
         }
      }
   }
}
