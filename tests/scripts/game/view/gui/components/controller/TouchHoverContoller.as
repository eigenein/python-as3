package game.view.gui.components.controller
{
   import flash.geom.Point;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class TouchHoverContoller
   {
      
      private static const HELPER_POINT:Point = new Point();
       
      
      private var hitZone:DisplayObjectContainer;
      
      private var _hover:Boolean;
      
      private var _isEnabled:Boolean = true;
      
      private var touchPointID:int = -1;
      
      public const signal_hoverChanger:Signal = new Signal();
      
      public function TouchHoverContoller(param1:DisplayObjectContainer)
      {
         super();
         this.hitZone = param1;
         param1.useHandCursor = true;
         param1.addEventListener("touch",handler_touch);
         param1.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function dispose() : void
      {
         hitZone.removeEventListener("touch",handler_touch);
         hitZone.removeEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get hover() : Boolean
      {
         return _hover;
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         if(this._isEnabled == param1)
         {
            return;
         }
         _isEnabled = param1;
         if(!this._isEnabled)
         {
            hitZone.touchable = false;
            if(_hover)
            {
               _hover = false;
               signal_hoverChanger.dispatch();
            }
            this.touchPointID = -1;
         }
         else
         {
            hitZone.touchable = true;
         }
      }
      
      protected function handler_touch(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(!this._isEnabled)
         {
            this.touchPointID = -1;
            return;
         }
         _loc2_ = param1.getTouch(hitZone,"began");
         if(_loc2_)
         {
            this.touchPointID = _loc2_.id;
            return;
         }
         _loc2_ = param1.getTouch(hitZone,"hover");
         if(_loc2_)
         {
            if(!_hover)
            {
               _hover = true;
               signal_hoverChanger.dispatch();
            }
            return;
         }
         if(_hover)
         {
            _hover = false;
            signal_hoverChanger.dispatch();
         }
      }
      
      protected function handler_removedFromStage(param1:Event) : void
      {
         this.touchPointID = -1;
         if(_hover)
         {
            _hover = false;
            signal_hoverChanger.dispatch();
         }
      }
   }
}
