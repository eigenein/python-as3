package engine.core.utils.property
{
   import idv.cjcat.signals.Signal;
   
   public class NumberProperty
   {
       
      
      protected var _value:Number;
      
      protected var _signal:Signal;
      
      public function NumberProperty(param1:Number = NaN)
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
            _signal = new Signal(Number);
            §§push(new Signal(Number));
         }
         return §§pop();
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         throw "access restricted for write only " + this;
      }
      
      public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
      }
      
      public function setValueSilently(param1:Number) : void
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
