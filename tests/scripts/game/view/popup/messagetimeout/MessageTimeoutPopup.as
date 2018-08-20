package game.view.popup.messagetimeout
{
   import com.progrestar.common.lang.Translate;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.view.popup.MessagePopup;
   
   public class MessageTimeoutPopup extends MessagePopup
   {
       
      
      private var messageIdent:String;
      
      private var timer:Timer;
      
      public function MessageTimeoutPopup(param1:String, param2:uint, param3:Boolean = false)
      {
         super(Translate.translateArgs(param1,param2),"",param3);
         this.messageIdent = param1;
         timer = new Timer(1000,param2);
         timer.addEventListener("timer",onTimer);
         timer.addEventListener("timerComplete",onTimerComplete);
      }
      
      public function timerStart() : void
      {
         if(timer)
         {
            timer.start();
         }
      }
      
      override public function forceClose() : void
      {
         clearTimer();
         super.forceClose();
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         updateText();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         updateText();
         clearTimer();
      }
      
      private function clearTimer() : void
      {
         if(timer)
         {
            timer.removeEventListener("timer",onTimer);
            timer.removeEventListener("timerComplete",onTimerComplete);
            timer.reset();
            timer = null;
         }
      }
      
      private function updateText() : void
      {
         if(clip && timer)
         {
            clip.tf_message.text = Translate.translateArgs(messageIdent,timer.repeatCount - timer.currentCount);
         }
      }
   }
}
