package engine.core.utils.property
{
   import idv.cjcat.signals.Signal;
   
   public class IntProperty
   {
       
      
      protected var _value:int;
      
      protected var _signal:Signal;
      
      public function IntProperty(param1:int = 0)
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
            _signal = new Signal(int);
            §§push(new Signal(int));
         }
         return §§pop();
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function set value(param1:int) : void
      {
         throw "access restricted for write only " + this;
      }
      
      public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
      }
      
      public function setValueSilently(param1:int) : void
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
