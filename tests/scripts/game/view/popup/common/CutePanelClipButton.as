package game.view.popup.common
{
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.display.Scale9Image;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButton;
   import idv.cjcat.signals.Signal;
   
   public class CutePanelClipButton extends ClipButton
   {
       
      
      private var holdTimerTicks:int = 0;
      
      private var holdTimerDefaultTime:int = 400;
      
      private var holdTimerMinTime:int = 100;
      
      private var holdTimerStep:Number = 1.25;
      
      private var rectangle:Rectangle;
      
      private var holdTimer:Timer;
      
      private var _signal_hold:Signal;
      
      public var bg:GuiClipScale9Image;
      
      public function CutePanelClipButton()
      {
         _signal_hold = new Signal();
         super();
         rectangle = new Rectangle(12,12,12,12);
         bg = new GuiClipScale9Image(rectangle);
         holdTimer = new Timer(holdTimerDefaultTime);
         holdTimer.addEventListener("timer",handler_timer);
      }
      
      public function dispose() : void
      {
         stopTimer();
      }
      
      public function get signal_hold() : Signal
      {
         return _signal_hold;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "down")
         {
            restartTimer();
         }
         else if(holdTimer.running)
         {
            stopTimer();
         }
         if(param1 == "hover")
         {
            (bg.graphics as Scale9Image).textures = AssetStorage.rsx.popup_theme.getScale9Textures("cutePanelActive_BG_12_12_12_12",rectangle);
         }
         else
         {
            (bg.graphics as Scale9Image).textures = AssetStorage.rsx.popup_theme.getScale9Textures("cutePanel_BG_12_12_12_12",rectangle);
         }
      }
      
      private function restartTimer() : void
      {
         holdTimer.delay = holdTimerDefaultTime;
         holdTimer.start();
         holdTimerTicks = 0;
      }
      
      private function dispatchTimer() : void
      {
         holdTimerTicks = holdTimerTicks + holdTimer.delay;
         if(holdTimerTicks > 1000)
         {
            holdTimer.delay = holdTimer.delay / holdTimerStep;
         }
         _signal_hold.dispatch();
      }
      
      private function stopTimer() : void
      {
         holdTimer.stop();
      }
      
      protected function handler_timer(param1:TimerEvent) : void
      {
         dispatchTimer();
      }
   }
}
