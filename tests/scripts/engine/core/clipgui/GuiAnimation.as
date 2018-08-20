package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.animation.SkinnableAnimation;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class GuiAnimation implements IGuiClip
   {
       
      
      protected var animation:SkinnableAnimation;
      
      private var _currentTime:Number = 0;
      
      private var _loopStopTime:int = -1;
      
      private var _signal_completed:Signal;
      
      private var selfDisposeWithDisplayObject:Boolean;
      
      public var playbackSpeed:Number = 1;
      
      public var isPlaying:Boolean = true;
      
      public var isLooping:Boolean = true;
      
      public var hideWhenCompleted:Boolean = false;
      
      public var disposeWhenCompleted:Boolean = false;
      
      public function GuiAnimation(param1:Boolean = true)
      {
         super();
         this.selfDisposeWithDisplayObject = param1;
      }
      
      public function dispose() : void
      {
         if(selfDisposeWithDisplayObject)
         {
            animation.graphics.removeEventListener("disposed",onDisposed);
         }
         animation.graphics.removeEventListener("enterFrame",onEnterFrame);
         if(animation.graphics.parent)
         {
            animation.graphics.parent.removeChild(animation.graphics);
         }
         animation.dispose();
      }
      
      public function get isCreated() : Boolean
      {
         return animation != null;
      }
      
      public function get currentFrame() : int
      {
         return _currentTime;
      }
      
      public function set currentFrame(param1:int) : void
      {
         _currentTime = param1 % animation.length;
      }
      
      public function get lastFrame() : int
      {
         return animation.length - 1;
      }
      
      public function get signal_completed() : Signal
      {
         if(!_signal_completed)
         {
            _signal_completed = new Signal();
         }
         return _signal_completed;
      }
      
      public function get graphics() : DisplayObject
      {
         return animation.graphics;
      }
      
      public function get container() : DisplayObjectContainer
      {
         return animation.graphics;
      }
      
      public function setNode(param1:Node) : void
      {
         animation = new SkinnableAnimation(param1.clip);
         animation.state.copyFrom(param1.state);
         animation.advanceTime(0);
         animation.graphics.transformationMatrix = animation.graphics.transformationMatrix;
         animation.graphics.addEventListener("enterFrame",onEnterFrame);
         if(selfDisposeWithDisplayObject)
         {
            animation.graphics.addEventListener("disposed",onDisposed);
         }
      }
      
      public function setClip(param1:Clip) : void
      {
         animation.setClip(param1,animation.state.matrix);
      }
      
      public function show(param1:DisplayObjectContainer) : void
      {
         param1.addChild(animation.graphics);
      }
      
      public function hide() : void
      {
         if(animation.graphics.parent)
         {
            animation.graphics.parent.removeChild(animation.graphics);
         }
      }
      
      public function stop() : void
      {
         isPlaying = false;
         animation.setFrame(_currentTime);
      }
      
      public function play() : void
      {
         isPlaying = true;
      }
      
      public function playLoop() : void
      {
         _loopStopTime = -1;
         isPlaying = true;
         isLooping = true;
         hideWhenCompleted = false;
      }
      
      public function playOnce() : void
      {
         _loopStopTime = -1;
         _currentTime = 0;
         hideWhenCompleted = false;
         isPlaying = true;
         isLooping = false;
      }
      
      public function playOnceAndHide() : void
      {
         _loopStopTime = -1;
         _currentTime = 0;
         hideWhenCompleted = true;
         isPlaying = true;
         isLooping = false;
      }
      
      public function gotoAndStop(param1:int) : void
      {
         _currentTime = param1;
         isPlaying = false;
         animation.setFrame(_currentTime);
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         _currentTime = param1;
         isPlaying = true;
         animation.setFrame(_currentTime);
      }
      
      public function stopOnFrame(param1:int) : void
      {
         _loopStopTime = param1;
         isPlaying = true;
         isLooping = true;
         hideWhenCompleted = false;
      }
      
      public function setNativeSkinPart(param1:DisplayObject, param2:String) : void
      {
         animation.setNativeContentPart(param1,param2);
      }
      
      protected function handleAnimationEnd(param1:int) : void
      {
         _currentTime = param1;
         isPlaying = false;
         if(hideWhenCompleted)
         {
            hide();
         }
         if(disposeWhenCompleted)
         {
            dispose();
         }
         if(_signal_completed)
         {
            _signal_completed.dispatch();
         }
      }
      
      protected function handleLoopStop() : void
      {
         isPlaying = false;
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Number = param1.data;
         if(isPlaying)
         {
            _loc3_ = animation.length;
            _loc4_ = Math.floor(_currentTime / _loc3_) * _loc3_;
            _currentTime = _currentTime + playbackSpeed * _loc2_ * 60;
            if(playbackSpeed > 0)
            {
               if(_currentTime >= _loc4_ + _loc3_ && !isLooping)
               {
                  handleAnimationEnd(_loc3_ - 1);
               }
               if(_loopStopTime != -1)
               {
                  if(_currentTime >= _loc4_ + _loopStopTime)
                  {
                     _currentTime = _loopStopTime;
                     handleLoopStop();
                  }
               }
               animation.advanceTimeTo(_currentTime);
            }
            else
            {
               if(_currentTime < _loc4_)
               {
                  if(!isLooping)
                  {
                     handleAnimationEnd(0);
                  }
               }
               if(_loopStopTime != -1)
               {
                  if(_currentTime < _loc4_ + _loopStopTime)
                  {
                     _currentTime = _loopStopTime;
                     handleLoopStop();
                  }
               }
               animation.setFrame(_currentTime);
            }
         }
      }
      
      protected function onDisposed(param1:Event) : void
      {
         dispose();
      }
   }
}
