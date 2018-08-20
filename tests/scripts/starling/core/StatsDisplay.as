package starling.core
{
   import flash.system.System;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.text.TextField;
   
   public class StatsDisplay extends Sprite
   {
      
      private static const WIDTH:int = 50;
      
      private static const HEIGHT:int = 41;
      
      public static var customOutput:Object = {};
       
      
      private const UPDATE_INTERVAL:Number = 0.5;
      
      private var mBackground:Quad;
      
      private var mTextField:TextField;
      
      private var mFrameCount:int = 0;
      
      private var mTotalTime:Number = 0;
      
      private var mFps:Number = 0;
      
      private var mMemory:Number = 0;
      
      private var mDrawCount:int = 0;
      
      public function StatsDisplay()
      {
         super();
         mBackground = new Quad(50,41,0);
         mTextField = new TextField(50 - 2,41,"","mini",-1,16777215);
         mTextField.x = 2;
         mTextField.hAlign = "left";
         mTextField.vAlign = "top";
         addChild(mBackground);
         addChild(mTextField);
         blendMode = "none";
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onAddedToStage() : void
      {
         addEventListener("enterFrame",onEnterFrame);
         mFrameCount = 0;
         mTotalTime = 0;
         update();
      }
      
      private function onRemovedFromStage() : void
      {
         removeEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:EnterFrameEvent) : void
      {
         mTotalTime = mTotalTime + param1.passedTime;
         mFrameCount = Number(mFrameCount) + 1;
         if(mTotalTime > 0.5)
         {
            update();
            mTotalTime = 0;
            mFrameCount = 0;
         }
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         mFps = mTotalTime > 0?mFrameCount / mTotalTime:0;
         mMemory = System.totalMemory * 9.54e-7;
         _loc1_ = "FPS: " + mFps.toFixed(mFps < 100?1:0) + "\nMEM: " + mMemory.toFixed(mMemory < 100?1:0) + "\nDRW: " + (mTotalTime > 0?mDrawCount - 2:mDrawCount);
         var _loc4_:int = 0;
         var _loc3_:* = customOutput;
         for(var _loc2_ in customOutput)
         {
            _loc1_ = _loc1_ + ("\n" + _loc2_ + ":" + customOutput[_loc2_]);
         }
         mTextField.text = _loc1_;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         param1.finishQuadBatch();
         super.render(param1,param2);
      }
      
      public function get drawCount() : int
      {
         return mDrawCount;
      }
      
      public function set drawCount(param1:int) : void
      {
         mDrawCount = param1;
      }
      
      public function get fps() : Number
      {
         return mFps;
      }
      
      public function set fps(param1:Number) : void
      {
         mFps = param1;
      }
      
      public function get memory() : Number
      {
         return mMemory;
      }
      
      public function set memory(param1:Number) : void
      {
         mMemory = param1;
      }
   }
}
