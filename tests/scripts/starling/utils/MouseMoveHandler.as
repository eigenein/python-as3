package starling.utils
{
   import flash.display.Stage;
   import flash.geom.Rectangle;
   import starling.events.TouchProcessor;
   
   public class MouseMoveHandler
   {
       
      
      private var touchProcessor:TouchProcessor;
      
      private var previousX:Number = 0;
      
      private var previousY:Number = 0;
      
      public var enabled:Boolean = true;
      
      public function MouseMoveHandler(param1:TouchProcessor)
      {
         super();
         this.touchProcessor = param1;
      }
      
      public function advanceTime(param1:flash.display.Stage, param2:starling.display.Stage, param3:Rectangle, param4:Boolean) : void
      {
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc5_:Number = param1.mouseX;
         var _loc10_:Number = param1.mouseY;
         if(_loc5_ != previousX || _loc10_ != previousY)
         {
            previousX = _loc5_;
            previousY = _loc10_;
            _loc8_ = param2.stageWidth * (_loc5_ - param3.x) / param3.width;
            _loc7_ = param2.stageHeight * (_loc10_ - param3.y) / param3.height;
            _loc9_ = 0;
            _loc6_ = !!param4?"moved":"hover";
            _loc11_ = 1;
            _loc12_ = 1;
            _loc13_ = 1;
            touchProcessor.enqueue(_loc9_,_loc6_,_loc8_,_loc7_,_loc11_,_loc12_,_loc13_);
         }
      }
   }
}
