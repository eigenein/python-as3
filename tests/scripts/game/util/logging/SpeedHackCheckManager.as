package game.util.logging
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import game.mediator.gui.popup.PopupList;
   
   public class SpeedHackCheckManager
   {
      
      private static var speedHackTimerTime:int;
      
      private static var speedHackDateTime:int;
      
      private static var timer:Timer;
      
      private static var time:int = 15;
      
      private static var detections:int;
      
      private static var maxDetections:int = 2;
       
      
      public function SpeedHackCheckManager()
      {
         super();
         timer = new Timer(time * 1000);
         timer.addEventListener("timer",tick);
         timer.start();
      }
      
      private static function tick(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(speedHackTimerTime && int(speedHackDateTime))
         {
            _loc2_ = new Date().time / 1000;
            _loc3_ = speedHackDateTime - _loc2_;
            _loc5_ = getTimer() / 1000;
            _loc4_ = speedHackTimerTime - _loc5_;
            speedHackTimerTime = _loc5_;
            speedHackDateTime = _loc2_;
            if(Math.abs(_loc4_ - _loc3_) > time / 4)
            {
               detections = Number(detections) + 1;
               if(detections >= maxDetections)
               {
                  PopupList.instance.error("Error","Speedhack detected",true);
                  timer.removeEventListener("timer",tick);
               }
            }
            else
            {
               detections = 0;
            }
         }
         else
         {
            speedHackTimerTime = getTimer() / 1000;
            speedHackDateTime = new Date().time / 1000;
         }
      }
   }
}
