package starling.events
{
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   
   public class TouchProcessor
   {
      
      private static var sUpdatedTouches:Vector.<Touch> = new Vector.<Touch>(0);
      
      private static var sHoveringTouchData:Vector.<Object> = new Vector.<Object>(0);
      
      private static var sHelperPoint:Point = new Point();
       
      
      private var mStage:Stage;
      
      private var mRoot:DisplayObject;
      
      private var mElapsedTime:Number;
      
      private var mTouchMarker:TouchMarker;
      
      private var mLastTaps:Vector.<Touch>;
      
      private var mShiftDown:Boolean = false;
      
      private var mCtrlDown:Boolean = false;
      
      private var mMultitapTime:Number = 0.3;
      
      private var mMultitapDistance:Number = 25;
      
      protected var mQueue:Vector.<Array>;
      
      protected var mCurrentTouches:Vector.<Touch>;
      
      public function TouchProcessor(param1:Stage)
      {
         super();
         mStage = param1;
         mRoot = param1;
         mElapsedTime = 0;
         mCurrentTouches = new Vector.<Touch>(0);
         mQueue = new Vector.<Array>(0);
         mLastTaps = new Vector.<Touch>(0);
         mStage.addEventListener("keyDown",onKey);
         mStage.addEventListener("keyUp",onKey);
         monitorInterruptions(true);
      }
      
      public function dispose() : void
      {
         monitorInterruptions(false);
         mStage.removeEventListener("keyDown",onKey);
         mStage.removeEventListener("keyUp",onKey);
         if(mTouchMarker)
         {
            mTouchMarker.dispose();
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         mElapsedTime = mElapsedTime + param1;
         sUpdatedTouches.length = 0;
         if(mLastTaps.length > 0)
         {
            _loc2_ = mLastTaps.length - 1;
            while(_loc2_ >= 0)
            {
               if(mElapsedTime - mLastTaps[_loc2_].timestamp > mMultitapTime)
               {
                  mLastTaps.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
         while(mQueue.length > 0)
         {
            var _loc6_:int = 0;
            var _loc5_:* = mCurrentTouches;
            for each(_loc3_ in mCurrentTouches)
            {
               if(_loc3_.phase == "began" || _loc3_.phase == "moved")
               {
                  _loc3_.phase = "stationary";
               }
            }
            while(mQueue.length > 0 && !containsTouchWithID(sUpdatedTouches,mQueue[mQueue.length - 1][0]))
            {
               _loc4_ = mQueue.pop();
               _loc3_ = createOrUpdateTouch(_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3],_loc4_[4],_loc4_[5],_loc4_[6]);
               sUpdatedTouches[sUpdatedTouches.length] = _loc3_;
            }
            processTouches(sUpdatedTouches,mShiftDown,mCtrlDown);
            _loc2_ = mCurrentTouches.length - 1;
            while(_loc2_ >= 0)
            {
               if(mCurrentTouches[_loc2_].phase == "ended")
               {
                  mCurrentTouches.splice(_loc2_,1);
               }
               _loc2_--;
            }
            sUpdatedTouches.length = 0;
         }
      }
      
      protected function processTouches(param1:Vector.<Touch>, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:* = null;
         sHoveringTouchData.length = 0;
         var _loc5_:TouchEvent = new TouchEvent("touch",mCurrentTouches,param2,param3);
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc4_ in param1)
         {
            if(_loc4_.phase == "hover" && _loc4_.target)
            {
               sHoveringTouchData[sHoveringTouchData.length] = {
                  "touch":_loc4_,
                  "target":_loc4_.target,
                  "bubbleChain":_loc4_.bubbleChain
               };
            }
            if(_loc4_.phase == "hover" || _loc4_.phase == "began")
            {
               sHelperPoint.setTo(_loc4_.globalX,_loc4_.globalY);
               _loc4_.target = mRoot.hitTest(sHelperPoint,true);
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = sHoveringTouchData;
         for each(var _loc6_ in sHoveringTouchData)
         {
            if(_loc6_.touch.target != _loc6_.target)
            {
               _loc5_.dispatch(_loc6_.bubbleChain);
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = param1;
         for each(_loc4_ in param1)
         {
            _loc4_.dispatchEvent(_loc5_);
         }
      }
      
      public function enqueue(param1:int, param2:String, param3:Number, param4:Number, param5:Number = 1.0, param6:Number = 1.0, param7:Number = 1.0) : void
      {
         mQueue.unshift([param1,param2,param3,param4,param5,param6,param7]);
         if(mCtrlDown && simulateMultitouch && param1 == 0)
         {
            mTouchMarker.moveMarker(param3,param4,mShiftDown);
            mQueue.unshift([1,param2,mTouchMarker.mockX,mTouchMarker.mockY]);
         }
      }
      
      public function enqueueMouseLeftStage() : void
      {
         var _loc1_:Touch = getCurrentTouch(0);
         if(_loc1_ == null || _loc1_.phase != "hover")
         {
            return;
         }
         var _loc2_:int = 1;
         var _loc8_:Number = _loc1_.globalX;
         var _loc6_:Number = _loc1_.globalY;
         var _loc4_:Number = _loc1_.globalX;
         var _loc7_:Number = mStage.stageWidth - _loc4_;
         var _loc3_:Number = _loc1_.globalY;
         var _loc9_:Number = mStage.stageHeight - _loc3_;
         var _loc5_:Number = Math.min(_loc4_,_loc7_,_loc3_,_loc9_);
         if(_loc5_ == _loc4_)
         {
            _loc8_ = -_loc2_;
         }
         else if(_loc5_ == _loc7_)
         {
            _loc8_ = mStage.stageWidth + _loc2_;
         }
         else if(_loc5_ == _loc3_)
         {
            _loc6_ = -_loc2_;
         }
         else
         {
            _loc6_ = mStage.stageHeight + _loc2_;
         }
         enqueue(0,"hover",_loc8_,_loc6_);
      }
      
      private function createOrUpdateTouch(param1:int, param2:String, param3:Number, param4:Number, param5:Number = 1.0, param6:Number = 1.0, param7:Number = 1.0) : Touch
      {
         var _loc8_:Touch = getCurrentTouch(param1);
         if(_loc8_ == null)
         {
            _loc8_ = new Touch(param1);
            addCurrentTouch(_loc8_);
         }
         _loc8_.globalX = param3;
         _loc8_.globalY = param4;
         _loc8_.phase = param2;
         _loc8_.timestamp = mElapsedTime;
         _loc8_.pressure = param5;
         _loc8_.width = param6;
         _loc8_.height = param7;
         if(param2 == "began")
         {
            updateTapCount(_loc8_);
         }
         return _loc8_;
      }
      
      private function updateTapCount(param1:Touch) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc2_:Number = mMultitapDistance * mMultitapDistance;
         var _loc7_:int = 0;
         var _loc6_:* = mLastTaps;
         for each(var _loc3_ in mLastTaps)
         {
            _loc4_ = Math.pow(_loc3_.globalX - param1.globalX,2) + Math.pow(_loc3_.globalY - param1.globalY,2);
            if(_loc4_ <= _loc2_)
            {
               _loc5_ = _loc3_;
               break;
            }
         }
         if(_loc5_)
         {
            param1.tapCount = _loc5_.tapCount + 1;
            mLastTaps.splice(mLastTaps.indexOf(_loc5_),1);
         }
         else
         {
            param1.tapCount = 1;
         }
         mLastTaps.push(param1.clone());
      }
      
      private function addCurrentTouch(param1:Touch) : void
      {
         var _loc2_:int = 0;
         _loc2_ = mCurrentTouches.length - 1;
         while(_loc2_ >= 0)
         {
            if(mCurrentTouches[_loc2_].id == param1.id)
            {
               mCurrentTouches.splice(_loc2_,1);
            }
            _loc2_--;
         }
         mCurrentTouches.push(param1);
      }
      
      private function getCurrentTouch(param1:int) : Touch
      {
         var _loc4_:int = 0;
         var _loc3_:* = mCurrentTouches;
         for each(var _loc2_ in mCurrentTouches)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function containsTouchWithID(param1:Vector.<Touch>, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.id == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return mTouchMarker != null;
      }
      
      public function set simulateMultitouch(param1:Boolean) : void
      {
         if(simulateMultitouch == param1)
         {
            return;
         }
         if(param1)
         {
            mTouchMarker = new TouchMarker();
            mTouchMarker.visible = false;
            mStage.addChild(mTouchMarker);
         }
         else
         {
            mTouchMarker.removeFromParent(true);
            mTouchMarker = null;
         }
      }
      
      public function get multitapTime() : Number
      {
         return mMultitapTime;
      }
      
      public function set multitapTime(param1:Number) : void
      {
         mMultitapTime = param1;
      }
      
      public function get multitapDistance() : Number
      {
         return mMultitapDistance;
      }
      
      public function set multitapDistance(param1:Number) : void
      {
         mMultitapDistance = param1;
      }
      
      public function get root() : DisplayObject
      {
         return mRoot;
      }
      
      public function set root(param1:DisplayObject) : void
      {
         mRoot = param1;
      }
      
      public function get stage() : Stage
      {
         return mStage;
      }
      
      public function get numCurrentTouches() : int
      {
         return mCurrentTouches.length;
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.keyCode == 17 || param1.keyCode == 15)
         {
            _loc2_ = mCtrlDown;
            mCtrlDown = param1.type == "keyDown";
            if(simulateMultitouch && _loc2_ != mCtrlDown)
            {
               mTouchMarker.visible = mCtrlDown;
               mTouchMarker.moveCenter(mStage.stageWidth / 2,mStage.stageHeight / 2);
               _loc4_ = getCurrentTouch(0);
               _loc3_ = getCurrentTouch(1);
               if(_loc4_)
               {
                  mTouchMarker.moveMarker(_loc4_.globalX,_loc4_.globalY);
               }
               if(_loc2_ && _loc3_ && _loc3_.phase != "ended")
               {
                  mQueue.unshift([1,"ended",_loc3_.globalX,_loc3_.globalY]);
               }
               else if(mCtrlDown && _loc4_)
               {
                  if(_loc4_.phase == "hover" || _loc4_.phase == "ended")
                  {
                     mQueue.unshift([1,"hover",mTouchMarker.mockX,mTouchMarker.mockY]);
                  }
                  else
                  {
                     mQueue.unshift([1,"began",mTouchMarker.mockX,mTouchMarker.mockY]);
                  }
               }
            }
         }
         else if(param1.keyCode == 16)
         {
            mShiftDown = param1.type == "keyDown";
         }
      }
      
      private function monitorInterruptions(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         try
         {
            _loc3_ = getDefinitionByName("flash.desktop::NativeApplication");
            _loc2_ = _loc3_["nativeApplication"];
            if(param1)
            {
               _loc2_.addEventListener("deactivate",onInterruption,false,0,true);
            }
            else
            {
               _loc2_.removeEventListener("deactivate",onInterruption);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function onInterruption(param1:Object) : void
      {
         if(mCurrentTouches.length > 0)
         {
            var _loc4_:int = 0;
            var _loc3_:* = mCurrentTouches;
            for each(var _loc2_ in mCurrentTouches)
            {
               if(_loc2_.phase == "began" || _loc2_.phase == "moved" || _loc2_.phase == "stationary")
               {
                  _loc2_.phase = "ended";
               }
            }
            processTouches(mCurrentTouches,mShiftDown,mCtrlDown);
         }
         mCurrentTouches.length = 0;
         mQueue.length = 0;
      }
   }
}
