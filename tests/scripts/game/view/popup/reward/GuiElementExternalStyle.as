package game.view.popup.reward
{
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class GuiElementExternalStyle
   {
       
      
      private var _target:DisplayObject;
      
      private var _back:DisplayObject;
      
      private var _nextAbove:DisplayObject;
      
      private var _overlay:DisplayObject;
      
      private var _backAlignment:RelativeAlignment;
      
      private var _nextAboveAlignment:RelativeAlignment;
      
      private var _overlayAlignment:RelativeAlignment;
      
      private var _backContainer:DisplayObjectContainer;
      
      private var _overlayContainer:DisplayObjectContainer;
      
      public const signal_dispose:Signal = new Signal();
      
      public function GuiElementExternalStyle()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(_back)
         {
            if(_back.parent)
            {
               _back.parent.removeChild(_back);
            }
            _back.dispose();
            _back = null;
         }
         if(_nextAbove)
         {
            if(_nextAbove.parent)
            {
               _nextAbove.parent.removeChild(_nextAbove);
            }
            _nextAbove.dispose();
            _nextAbove = null;
         }
         if(_overlay)
         {
            if(_overlay.parent)
            {
               _overlay.parent.removeChild(_overlay);
            }
            _overlay.dispose();
            _overlay = null;
         }
         signal_dispose.dispatch();
         signal_dispose.clear();
         if(_target)
         {
            _target.removeEventListener("addedToStage",handler_addedToStage);
            _target.removeEventListener("removedFromStage",handler_removedFromStage);
         }
      }
      
      public function apply(param1:DisplayObject, param2:DisplayObjectContainer, param3:DisplayObjectContainer) : void
      {
         if(param1)
         {
            applyTarget(param1);
         }
         if(param2)
         {
            applyBackground(param2);
         }
         if(param3)
         {
            applyOverlay(param3);
         }
         if(param3)
         {
            applyNextAbove(param3);
         }
      }
      
      public function setBackground(param1:DisplayObject, param2:RelativeAlignment) : void
      {
         _back = param1;
         _backAlignment = param2;
      }
      
      public function setOverlay(param1:DisplayObject, param2:RelativeAlignment) : void
      {
         _overlay = param1;
         _overlayAlignment = param2;
      }
      
      public function setNextAbove(param1:DisplayObject, param2:RelativeAlignment) : void
      {
         _nextAbove = param1;
         _nextAboveAlignment = param2;
      }
      
      public function realign() : void
      {
         addToScreen();
         _realign();
      }
      
      public function _realign() : void
      {
         if(_back && _backContainer)
         {
            if(_backAlignment && _target)
            {
               _backAlignment.apply(_back,_target);
            }
         }
         if(_nextAbove && _overlayContainer)
         {
            if(_nextAboveAlignment && _target)
            {
               _nextAboveAlignment.apply(_nextAbove,_target);
            }
         }
         if(_overlay && _overlayContainer)
         {
            if(_overlayAlignment && _target)
            {
               _overlayAlignment.apply(_overlay,_target);
            }
         }
      }
      
      protected function addToScreen() : void
      {
         if(_back && _backContainer)
         {
            if(_target.parent == _backContainer)
            {
               _backContainer.addChildAt(_back,_backContainer.getChildIndex(_target));
            }
            else
            {
               _backContainer.addChildAt(_back,0);
            }
         }
         if(_nextAbove && _overlayContainer)
         {
            if(_target.parent == _overlayContainer)
            {
               _overlayContainer.addChildAt(_nextAbove,_overlayContainer.getChildIndex(_target) + 1);
            }
            else
            {
               _overlayContainer.addChild(_nextAbove);
            }
         }
         if(_overlay && _overlayContainer)
         {
            _overlayContainer.addChild(_overlay);
         }
      }
      
      protected function removeFromScreen() : void
      {
         if(_back && _back.parent)
         {
            _back.parent.removeChild(_back);
         }
         if(_nextAbove && _nextAbove.parent)
         {
            _nextAbove.parent.removeChild(_nextAbove);
         }
         if(_overlay && _overlay.parent)
         {
            _overlay.parent.removeChild(_overlay);
         }
      }
      
      protected function applyTarget(param1:DisplayObject) : void
      {
         _target = param1;
         _target.parent.addEventListener("creationComplete",handler_targetPlaced);
         _target.parent.addEventListener("disposed",handler_targetParentDisposed);
         handler_targetPlaced(null);
         if(_target.stage)
         {
            _target.addEventListener("removedFromStage",handler_removedFromStage);
         }
         else
         {
            _target.addEventListener("addedToStage",handler_addedToStage);
         }
      }
      
      protected function applyBackground(param1:DisplayObjectContainer) : void
      {
         _backContainer = param1;
         if(_back)
         {
            if(_target.parent == _backContainer)
            {
               _backContainer.addChildAt(_back,_backContainer.getChildIndex(_target));
            }
            else
            {
               _backContainer.addChildAt(_back,0);
            }
            if(_backAlignment && _target)
            {
               _backAlignment.apply(_back,_target);
            }
         }
      }
      
      protected function applyNextAbove(param1:DisplayObjectContainer) : void
      {
         _overlayContainer = param1;
         if(_nextAbove)
         {
            if(_target.parent == _overlayContainer)
            {
               _overlayContainer.addChildAt(_nextAbove,_overlayContainer.getChildIndex(_target) + 1);
            }
            else
            {
               _overlayContainer.addChild(_nextAbove);
            }
            if(_nextAboveAlignment && _target)
            {
               _nextAboveAlignment.apply(_nextAbove,_target);
            }
         }
      }
      
      protected function applyOverlay(param1:DisplayObjectContainer) : void
      {
         _overlayContainer = param1;
         if(_overlay)
         {
            _overlayContainer.addChild(_overlay);
            if(_overlayAlignment && _target)
            {
               _overlayAlignment.apply(_overlay,_target);
            }
         }
      }
      
      private function handler_targetParentDisposed(param1:Event) : void
      {
         handler_targetPlaced(param1);
      }
      
      private function handler_targetPlaced(param1:Event) : void
      {
         if(param1)
         {
            _target.parent.removeEventListener("creationComplete",handler_targetPlaced);
         }
         if(_back && _back.parent && _backAlignment && _target)
         {
            _backAlignment.apply(_back,_target);
         }
         if(_nextAbove && _nextAbove.parent && _nextAboveAlignment && _target)
         {
            _nextAboveAlignment.apply(_nextAbove,_target);
         }
         if(_overlay && _overlay.parent && _overlayAlignment && _overlay)
         {
            _overlayAlignment.apply(_overlay,_target);
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         _target.removeEventListener("addedToStage",handler_addedToStage);
         _target.addEventListener("removedFromStage",handler_removedFromStage);
         addToScreen();
         _realign();
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         _target.addEventListener("addedToStage",handler_addedToStage);
         _target.removeEventListener("removedFromStage",handler_removedFromStage);
         removeFromScreen();
      }
   }
}
