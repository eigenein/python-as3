package game.mediator.gui.popup.queue
{
   import feathers.core.PopUpManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.mediator.gui.popup.GamePopupManager;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   
   public class PopupQueueManager
   {
       
      
      private var _delayedPopupQueue:Vector.<PopupQueueEntry>;
      
      private var _delayedPopupQueueTimer:Timer;
      
      public function PopupQueueManager()
      {
         _delayedPopupQueue = new Vector.<PopupQueueEntry>();
         _delayedPopupQueueTimer = new Timer(1500,1);
         super();
         GamePopupManager.signal_popupAdded.add(handler_popupAdded);
         GamePopupManager.signal_popupRemoved.add(handler_popupRemoved);
         _delayedPopupQueueTimer.addEventListener("timer",handler_delayedPopupQueueTimer);
      }
      
      private function get popupCount() : int
      {
         if(GamePopupManager.instance)
         {
            return GamePopupManager.instance.popupCount;
         }
         return 0;
      }
      
      public function queuePopup(param1:PopupBase, param2:int) : void
      {
         var _loc3_:PopupQueueEntry = new PopupQueueEntry();
         _loc3_.popup = param1;
         _loc3_.delay = param2;
         _delayedPopupQueue.unshift(_loc3_);
         if(!popupCount)
         {
            delayedQueueStartTimer();
         }
      }
      
      public function unqueuePopup(param1:PopupBase) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _delayedPopupQueue.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_delayedPopupQueue[_loc3_].popup == param1)
            {
               _delayedPopupQueue.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function delayedQueueStopTimer() : void
      {
         _delayedPopupQueueTimer.stop();
      }
      
      public function delayedQueueStartTimer() : void
      {
         if(_delayedPopupQueue.length)
         {
            if(_delayedPopupQueue[0].delay == 0)
            {
               PopUpManager.addPopUp(_delayedPopupQueue.pop().popup);
               return;
            }
            _delayedPopupQueueTimer.delay = _delayedPopupQueue[0].delay;
            _delayedPopupQueueTimer.start();
         }
      }
      
      protected function handler_delayedPopupQueueTimer(param1:TimerEvent) : void
      {
         if(_delayedPopupQueue.length && popupCount == 0 && !Tutorial.inputIsBlocked && !Game.instance.screen.isOnBattle)
         {
            PopUpManager.addPopUp(_delayedPopupQueue.pop().popup);
         }
      }
      
      private function handler_popupRemoved() : void
      {
         delayedQueueStartTimer();
      }
      
      private function handler_popupAdded() : void
      {
         delayedQueueStopTimer();
      }
   }
}
