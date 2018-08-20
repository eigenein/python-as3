package game.view.gui.components.controller
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObjectContainer;
   
   public class TouchHoldController extends TouchButtonController implements IButtonView
   {
       
      
      private var minFrequency:int;
      
      private var frequencyIncrementPerSecond:int;
      
      private var currentFrequency:Number;
      
      private var lastTimestamp:int;
      
      private var timer:Timer;
      
      public const signal_hold:Signal = new Signal();
      
      public function TouchHoldController(param1:DisplayObjectContainer, param2:int = 2, param3:int = 5)
      {
         super(param1,this);
         this.minFrequency = param2;
         this.frequencyIncrementPerSecond = param3;
         timer = new Timer(1000 / param2);
         timer.addEventListener("timer",handler_onTimer);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(timer.running)
         {
            timer.stop();
         }
         signal_hold.clear();
         timer.removeEventListener("timer",handler_onTimer);
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "down")
         {
            lastTimestamp = getTimer();
            currentFrequency = minFrequency;
            timer.delay = 1000 / currentFrequency;
            timer.reset();
            timer.start();
            signal_hold.dispatch();
         }
         else if(timer.running)
         {
            timer.stop();
         }
      }
      
      public function click() : void
      {
      }
      
      private function handler_onTimer(param1:TimerEvent) : void
      {
         var _loc3_:int = getTimer();
         var _loc2_:Number = _loc3_ - lastTimestamp - 20;
         while(_loc2_ > 0)
         {
            signal_hold.dispatch();
            _loc2_ = _loc2_ - 1000 / currentFrequency;
         }
         currentFrequency = currentFrequency + (_loc3_ - lastTimestamp) / 1000 * frequencyIncrementPerSecond;
         lastTimestamp = _loc3_;
         timer.delay = 1000 / currentFrequency;
      }
   }
}
