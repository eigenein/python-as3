package loader.web.util
{
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseWheelLinuxFix
   {
       
      
      private var customEventCounter:int = 5;
      
      private var stage:Stage;
      
      public function MouseWheelLinuxFix(param1:Stage)
      {
         super();
         this.stage = param1;
         if(ExternalInterfaceProxy.available)
         {
            ExternalInterfaceProxy.addCallback("handleWheel",onJSMouseWheel);
            param1.addEventListener("mouseWheel",onNativeMouseWheel);
         }
      }
      
      public static function apply(param1:Stage) : void
      {
         if(ExternalInterfaceProxy.available)
         {
            new MouseWheelLinuxFix(param1);
         }
      }
      
      private function onJSMouseWheel(param1:*) : void
      {
         var _loc2_:int = param1.delta;
         if(_loc2_ > 40 || _loc2_ < -40)
         {
            _loc2_ = _loc2_ / 40;
         }
         stage.dispatchEvent(new CustomMouseWheelEvent(_loc2_,stage,param1));
      }
      
      private function empty(param1:*) : void
      {
      }
      
      private function onNativeMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:EventDispatcher = param1.target as EventDispatcher;
         if(param1 is CustomMouseWheelEvent)
         {
            customEventCounter = customEventCounter - 1;
            if(customEventCounter - 1 == 0)
            {
               _loc2_.removeEventListener("mouseWheel",onNativeMouseWheel);
            }
         }
         else
         {
            ExternalInterfaceProxy.addCallback("handleWheel",empty);
            _loc2_.removeEventListener("mouseWheel",onNativeMouseWheel);
         }
      }
      
      private function onJSMouseWheelNativeDisplayObjects(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = stage.getObjectsUnderPoint(new Point(stage.mouseX,stage.mouseY));
         var _loc5_:InteractiveObject = null;
         _loc4_ = _loc2_.length - 1;
         while(_loc4_ >= 0)
         {
            if(_loc2_[_loc4_] is InteractiveObject)
            {
               _loc5_ = _loc2_[_loc4_] as InteractiveObject;
               break;
            }
            if(_loc2_[_loc4_] is Shape && _loc2_[_loc4_].parent)
            {
               _loc5_ = _loc2_[_loc4_].parent;
               break;
            }
            _loc4_--;
         }
         if(_loc5_)
         {
            _loc3_ = int(param1.delta) == 0?1:int(param1.delta);
            _loc5_.dispatchEvent(new CustomMouseWheelEvent(_loc3_,_loc5_,param1));
         }
      }
   }
}

import flash.display.InteractiveObject;
import flash.events.MouseEvent;

class CustomMouseWheelEvent extends MouseEvent
{
    
   
   function CustomMouseWheelEvent(param1:int, param2:InteractiveObject, param3:*)
   {
      super("mouseWheel",true,false,param2.mouseX,param2.mouseY,param2,param3.ctrlKey,param3.altKey,param3.shiftKey,false,param1);
   }
}
