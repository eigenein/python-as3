package engine.core.utils.property
{
   import avmplus.getQualifiedClassName;
   import flash.utils.getDefinitionByName;
   import idv.cjcat.signals.Signal;
   
   public class VectorProperty
   {
       
      
      protected var _value:Vector.<*>;
      
      protected var _signal:Signal;
      
      public function VectorProperty(param1:Vector.<*> = null)
      {
         super();
         _value = param1;
      }
      
      public static function fromOneElemement(param1:Object) : VectorProperty
      {
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(param1)) as Class;
         return new VectorProperty(new <_loc2_>[param1 as _loc2_] as Vector.<*>);
      }
      
      public function get signal_update() : Signal
      {
         if(_signal)
         {
            §§push(_signal);
         }
         else
         {
            _signal = new Signal(Vector.<*>);
            §§push(new Signal(Vector.<*>));
         }
         return §§pop();
      }
      
      public function get value() : Vector.<*>
      {
         return _value;
      }
      
      public function set value(param1:Vector.<*>) : void
      {
         throw "access restricted for write only " + this;
      }
      
      public function onValue(param1:Function) : void
      {
         signal_update.add(param1);
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
