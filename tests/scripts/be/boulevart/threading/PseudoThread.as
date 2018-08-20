package be.boulevart.threading
{
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   
   public class PseudoThread extends EventDispatcher
   {
       
      
      public var RENDER_DEDUCTION:int = 10;
      
      private var fn:Function;
      
      private var obj:Object;
      
      private var thread:Sprite;
      
      private var start:Number;
      
      private var due:Number;
      
      private var mouseEvent:Boolean;
      
      private var keyEvent:Boolean;
      
      public function PseudoThread(param1:Stage, param2:Function, param3:Object = null)
      {
         super();
         fn = param2;
         if(obj == null)
         {
            obj = param3;
         }
         else
         {
            obj = {};
         }
         param1.addEventListener("enterFrame",enterFrameHandler,false,100);
         param1.addEventListener("mouseMove",mouseMoveHandler);
         param1.addEventListener("keyDown",keyDownHandler);
         thread = new Sprite();
         param1.addChild(thread);
         thread.addEventListener("render",renderHandler);
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         start = getTimer();
         var _loc2_:Number = Math.floor(1000 / thread.stage.frameRate);
         due = start + _loc2_;
         thread.stage.invalidate();
         thread.graphics.clear();
         thread.graphics.moveTo(0,0);
         thread.graphics.lineTo(0,0);
      }
      
      private function renderHandler(param1:Event) : void
      {
         if(mouseEvent || keyEvent)
         {
            due = due - RENDER_DEDUCTION;
         }
         while(getTimer() < due)
         {
            if(obj == null)
            {
               if(!fn())
               {
                  if(!thread.parent)
                  {
                     return;
                  }
                  thread.stage.removeEventListener("enterFrame",enterFrameHandler);
                  thread.stage.removeEventListener("mouseMove",mouseMoveHandler);
                  thread.stage.removeEventListener("keyDown",keyDownHandler);
                  thread.parent.removeChild(thread);
                  thread.removeEventListener("render",renderHandler);
                  dispatchEvent(new Event("threadComplete"));
               }
            }
            else if(!fn(obj))
            {
               if(!thread.parent)
               {
                  return;
               }
               thread.stage.removeEventListener("enterFrame",enterFrameHandler);
               thread.stage.removeEventListener("mouseMove",mouseMoveHandler);
               thread.stage.removeEventListener("keyDown",keyDownHandler);
               thread.parent.removeChild(thread);
               thread.removeEventListener("render",renderHandler);
               dispatchEvent(new Event("threadComplete"));
            }
         }
         mouseEvent = false;
         keyEvent = false;
      }
      
      private function mouseMoveHandler(param1:Event) : void
      {
         mouseEvent = true;
      }
      
      private function keyDownHandler(param1:Event) : void
      {
         keyEvent = true;
      }
   }
}
