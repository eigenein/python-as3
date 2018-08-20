package game.mediator.gui
{
   import org.osflash.signals.Signal;
   import org.osflash.signals.SignalWatcher;
   
   public class RedMarkerState
   {
       
      
      private var _signal_update:Signal;
      
      private var _value:Boolean;
      
      public function RedMarkerState(param1:String)
      {
         super();
         SignalWatcher.nameContext("redMarker " + param1);
         _signal_update = new Signal();
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get value() : Boolean
      {
         return _value;
      }
      
      public function set value(param1:Boolean) : void
      {
         if(_value == param1)
         {
            return;
         }
         _value = param1;
         _signal_update.dispatch();
      }
   }
}
