package game.view.popup.test
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class NativeMouseClickController
   {
       
      
      private var hitZone:DisplayObject;
      
      public const signal_click:Signal = new Signal();
      
      public function NativeMouseClickController(param1:DisplayObjectContainer)
      {
         super();
         this.hitZone = param1;
         if(param1.stage)
         {
            onAddedToStage(null);
         }
         else
         {
            onRemovedFromStage(null);
         }
         param1.useHandCursor = true;
      }
      
      public function dispose() : void
      {
         hitZone.removeEventListener("addedToStage",onAddedToStage);
         hitZone.removeEventListener("removedFromStage",onRemovedFromStage);
         Starling.current.nativeStage.removeEventListener("mouseUp",handler_mouseUp);
         signal_click.clear();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         hitZone.removeEventListener("addedToStage",onAddedToStage);
         hitZone.addEventListener("removedFromStage",onRemovedFromStage);
         Starling.current.nativeStage.addEventListener("mouseUp",handler_mouseUp);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         hitZone.removeEventListener("removedFromStage",onRemovedFromStage);
         hitZone.addEventListener("addedToStage",onAddedToStage);
         Starling.current.nativeStage.removeEventListener("mouseUp",handler_mouseUp);
      }
      
      private function handler_mouseUp(param1:MouseEvent) : void
      {
         var _loc3_:Point = new Point(Starling.current.nativeStage.mouseX,Starling.current.nativeStage.mouseY);
         var _loc2_:Point = hitZone.globalToLocal(_loc3_);
         if(hitZone.hitTest(_loc2_))
         {
            signal_click.dispatch();
         }
      }
   }
}
