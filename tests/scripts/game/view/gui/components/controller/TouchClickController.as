package game.view.gui.components.controller
{
   import flash.geom.Point;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class TouchClickController
   {
      
      private static const HELPER_POINT:Point = new Point();
       
      
      public const onClick:Signal = new Signal();
      
      private var touchPointID:int;
      
      private var object:DisplayObject;
      
      public function TouchClickController(param1:DisplayObject)
      {
         super();
         this.object = param1;
         param1.addEventListener("touch",param1 is DisplayObjectContainer?handler_container_touch:handler_touch);
         param1.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function dispose() : void
      {
         onClick.clear();
         object.removeEventListener("touch",object is DisplayObjectContainer?handler_container_touch:handler_touch);
         object.removeEventListener("removedFromStage",handler_removedFromStage);
      }
      
      protected function handler_touch(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(this.touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(object,"ended",this.touchPointID);
            if(_loc2_)
            {
               _loc2_.getLocation(object.stage,HELPER_POINT);
               if(object == object.stage.hitTest(HELPER_POINT,true))
               {
                  onClick.dispatch();
               }
            }
         }
         else
         {
            _loc2_ = param1.getTouch(object,"began");
            if(_loc2_)
            {
               this.touchPointID = _loc2_.id;
            }
         }
      }
      
      protected function handler_container_touch(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(this.touchPointID >= 0)
         {
            _loc2_ = param1.getTouch(object,"ended",this.touchPointID);
            if(_loc2_)
            {
               _loc2_.getLocation(object.stage,HELPER_POINT);
               if((object as DisplayObjectContainer).contains(object.stage.hitTest(HELPER_POINT,true)))
               {
                  onClick.dispatch();
               }
            }
         }
         else
         {
            _loc2_ = param1.getTouch(object,"began");
            if(_loc2_)
            {
               this.touchPointID = _loc2_.id;
            }
         }
      }
      
      protected function handler_removedFromStage(param1:Event) : void
      {
         this.touchPointID = -1;
      }
   }
}
