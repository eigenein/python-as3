package game.view.popup.hero
{
   import avmplus.getQualifiedClassName;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import idv.cjcat.signals.Signal;
   
   public class TimerQueueDispenser
   {
       
      
      private var elementType:Class;
      
      private var queue:Vector.<*>;
      
      private var timer:Timer;
      
      protected var _signal_onElement:Signal;
      
      public function TimerQueueDispenser(param1:Class, param2:Number)
      {
         super();
         this.elementType = param1;
         _signal_onElement = new Signal(param1);
         queue = new Vector.<param1>();
         timer = new Timer(param2);
         timer.addEventListener("timer",handler_onTimer);
      }
      
      public function dispose() : void
      {
         if(timer.running)
         {
            timer.stop();
         }
         _signal_onElement.clear();
         timer.removeEventListener("timer",handler_onTimer);
      }
      
      public function get signal_onElement() : Signal
      {
         return _signal_onElement;
      }
      
      public function get isEmpty() : Boolean
      {
         return queue.length == 0;
      }
      
      public function add(param1:*) : void
      {
         var _loc4_:int = 0;
         if(!(param1 is Vector.<elementType>))
         {
            throw "Wrong element type. Expected " + getQualifiedClassName(elementType);
         }
         var _loc3_:Vector.<*> = param1 as Vector.<*>;
         var _loc5_:int = queue.length;
         var _loc2_:int = _loc3_.length;
         queue.length = _loc5_ + _loc2_;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            queue[_loc5_ + _loc4_] = _loc3_[_loc4_];
            _loc4_++;
         }
         if(_loc2_ > 0)
         {
            if(!_loc5_)
            {
               dispatchOnElement(queue.shift());
            }
            if(!timer.running && _loc5_ + _loc2_ > 0)
            {
               timer.start();
            }
         }
      }
      
      public function reset() : void
      {
         timer.stop();
         queue = new Vector.<elementType>();
      }
      
      protected function dispatchOnElement(param1:*) : void
      {
         _signal_onElement.dispatch(param1);
      }
      
      private function handler_onTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = queue.length;
         if(_loc2_ > 0)
         {
            dispatchOnElement(queue.shift());
         }
         if(_loc2_ <= 1)
         {
            timer.stop();
         }
      }
   }
}
