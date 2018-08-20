package engine.core.clipgui
{
   import idv.cjcat.signals.Signal;
   
   public class GuiPlayback
   {
       
      
      private var _currentTime:Number = 0;
      
      private var _signal_completed:Signal;
      
      private var _loopStopTime:int = -1;
      
      private var _animation:ITimelineAnimation;
      
      public var playbackSpeed:Number = 1;
      
      public var isPlaying:Boolean = true;
      
      public var isLooping:Boolean = true;
      
      public var hideWhenCompleted:Boolean = false;
      
      public function GuiPlayback(param1:ITimelineAnimation)
      {
         super();
         this._animation = param1;
      }
      
      public function set animation(param1:ITimelineAnimation) : void
      {
         _animation = param1;
      }
      
      public function get currentFrame() : int
      {
         return _currentTime;
      }
      
      public function set currentFrame(param1:int) : void
      {
         _currentTime = param1 % _animation.length;
      }
      
      public function get lastFrame() : int
      {
         return _animation.length - 1;
      }
      
      public function get signal_completed() : Signal
      {
         if(!_signal_completed)
         {
            _signal_completed = new Signal();
         }
         return _signal_completed;
      }
      
      public function stop() : void
      {
         isPlaying = false;
         _animation.setFrame(_currentTime);
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
         _animation.setFrame(_currentTime);
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         _currentTime = param1;
         isPlaying = true;
         _animation.setFrame(_currentTime);
      }
      
      public function stopOnFrame(param1:int) : void
      {
         _loopStopTime = param1;
         isPlaying = true;
         isLooping = true;
         hideWhenCompleted = false;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(isPlaying)
         {
            _loc4_ = _animation.length;
            _loc5_ = Math.floor(_currentTime / _loc4_) * _loc4_;
            if(_loopStopTime != -1)
            {
               _loc3_ = Math.floor((_currentTime - _loopStopTime) / _loc4_);
            }
            _currentTime = _currentTime + playbackSpeed * param1 * 60;
            if(_loopStopTime != -1)
            {
               _loc2_ = Math.floor((_currentTime - _loopStopTime) / _loc4_);
            }
            if(playbackSpeed > 0)
            {
               if(_currentTime >= _loc5_ + _loc4_ && !isLooping)
               {
                  handleAnimationEnd(_loc4_ - 1);
               }
               if(_loopStopTime != -1 && _loc3_ != _loc2_)
               {
                  _currentTime = _loopStopTime;
                  handleLoopStop();
               }
               _animation.advanceTimeTo(_currentTime);
            }
            else
            {
               if(_currentTime < _loc5_)
               {
                  if(!isLooping)
                  {
                     handleAnimationEnd(0);
                  }
               }
               if(_loopStopTime != -1 && _loc3_ != _loc2_)
               {
                  _currentTime = _loopStopTime;
                  handleLoopStop();
               }
               _animation.setFrame(_currentTime);
            }
         }
      }
      
      protected function handleAnimationEnd(param1:int) : void
      {
         _currentTime = param1;
         isPlaying = false;
         if(_signal_completed)
         {
            _signal_completed.dispatch();
         }
      }
      
      protected function handleLoopStop() : void
      {
         isPlaying = false;
      }
   }
}
