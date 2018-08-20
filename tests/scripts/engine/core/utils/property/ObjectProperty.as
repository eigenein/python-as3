package engine.core.utils.property
{
   import avmplus.getQualifiedClassName;
   import org.osflash.signals.Signal;
   
   public class ObjectProperty
   {
       
      
      protected var _type:Class;
      
      protected var _value:Object;
      
      protected var _signal:Signal;
      
      public function ObjectProperty(param1:Class, param2:Object = null)
      {
         super();
         _type = param1;
         if(param2 != null && !(param2 is _type))
         {
            throw new ArgumentError("Invalid type, should be " + getQualifiedClassName(_type) + " but " + param2 + " received");
         }
         _value = param2;
      }
      
      public function get signal_update() : Signal
      {
         if(_signal)
         {
            §§push(_signal);
         }
         else
         {
            _signal = new Signal(_type);
            §§push(new Signal(_type));
         }
         return §§pop();
      }
      
      public function get value() : Object
      {
         return _value;
      }
      
      public function set value(param1:Object) : void
      {
         throw "access restricted for write only " + this;
      }
      
      public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
      }
      
      public function setValueSilently(param1:Object) : void
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
