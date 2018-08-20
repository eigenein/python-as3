package engine.core.utils.property
{
   import idv.cjcat.signals.Signal;
   
   public class StringProperty
   {
       
      
      protected var _value:String;
      
      protected var _signal:Signal;
      
      public function StringProperty(param1:String = null)
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
            _signal = new Signal(String);
            §§push(new Signal(String));
         }
         return §§pop();
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function set value(param1:String) : void
      {
         throw "access restricted for write only " + this;
      }
      
      public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
      }
      
      public function setValueSilently(param1:String) : void
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
