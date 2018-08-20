package game.view.gui.tutorial
{
   import game.view.gui.tutorial.dialogs.TutorialMessageEntry;
   import game.view.gui.tutorial.dialogs.TutorialMessageLayer;
   import starling.display.DisplayObjectContainer;
   
   public class TutorialOverlay
   {
       
      
      private var container:DisplayObjectContainer;
      
      private var locker:TutorialLockOverlay;
      
      private var messages:TutorialMessageLayer;
      
      private var _deferredMessage:TutorialMessageEntry;
      
      private var messagesList:Vector.<TutorialMessageEntry>;
      
      public function TutorialOverlay()
      {
         messagesList = new Vector.<TutorialMessageEntry>();
         super();
      }
      
      public function get inputIsBlocked() : Boolean
      {
         return locker.inputIsBlocked;
      }
      
      public function initialize(param1:DisplayObjectContainer) : void
      {
         this.container = param1;
         locker = new TutorialLockOverlay(param1);
         messages = new TutorialMessageLayer(locker);
         messages.width = param1.stage.stageWidth;
         messages.height = param1.stage.stageHeight;
         if(_deferredMessage)
         {
            _showMessageFromTask(_deferredMessage);
            _deferredMessage = null;
         }
      }
      
      public function setActiveButtons(param1:Vector.<ITutorialButton>) : void
      {
         locker.setTargets(param1);
      }
      
      public function lockAll() : void
      {
         locker.lockAll();
      }
      
      public function unlockAll() : void
      {
         locker.unlockAll();
      }
      
      public function showMessageFromTask(param1:TutorialTask) : void
      {
         param1.signal_onHideMessage.add(onTaskHideMessage);
         if(messages)
         {
            _showMessageFromTask(param1.message);
         }
         else
         {
            _deferredMessage = param1.message;
         }
      }
      
      protected function _showMessageFromTask(param1:TutorialMessageEntry) : void
      {
         container.addChild(messages);
         messages.applyMessage(param1);
         if(param1.needButton)
         {
            locker.lockAll();
         }
         else
         {
            locker.unlockAll();
         }
      }
      
      protected function hideMessage(param1:TutorialMessageEntry) : void
      {
         var _loc2_:* = null;
         var _loc5_:Boolean = false;
         var _loc3_:int = messagesList.length;
         var _loc4_:int = messagesList.indexOf(param1);
         if(_loc4_ != -1)
         {
            messagesList.splice(_loc4_,1);
         }
         if(locker)
         {
            if(messagesList.length)
            {
               _loc2_ = messagesList[messagesList.length - 1];
               messages.applyMessage(_loc2_);
               if(_loc2_.needButton)
               {
                  locker.lockAll();
               }
               else
               {
                  locker.unlockAll();
               }
            }
            else
            {
               locker.unlockAll();
            }
         }
         if(messages && messagesList.length == 0 && messages.parent)
         {
            messages.hide();
         }
      }
      
      protected function onTaskHideMessage(param1:TutorialTask) : void
      {
         if(_deferredMessage == param1.message)
         {
            _deferredMessage = null;
         }
         hideMessage(param1.message);
      }
   }
}
