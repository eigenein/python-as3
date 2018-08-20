package engine.core.utils.thread
{
   import com.progrestar.common.Logger;
   import engine.core.utils.VectorUtil;
   
   public class ThreadQueue extends Thread
   {
      
      private static const logger:Logger = Logger.getLogger(ThreadQueue);
       
      
      protected var parallelCount:int = 1;
      
      protected const _queue:Vector.<Thread> = new Vector.<Thread>();
      
      protected const _activeQueue:Vector.<Thread> = new Vector.<Thread>();
      
      protected const _progress:Vector.<Thread> = new Vector.<Thread>();
      
      public function ThreadQueue(param1:int = 1)
      {
         this.parallelCount = param1;
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function addThread(param1:Thread) : void
      {
         _progress.push(param1);
         _queue.push(param1);
      }
      
      override public function run() : void
      {
         if(_queue.length == 0 && _activeQueue.length == 0)
         {
            eventComplete.dispatch(this);
            dispose();
         }
         else
         {
            addThreads();
         }
      }
      
      protected function addThreads() : void
      {
         var _loc1_:* = null;
         while(_activeQueue.length < parallelCount && _queue.length)
         {
            _loc1_ = _queue.shift();
            _activeQueue.push(_loc1_);
            _loc1_.eventComplete.add(threadComplete);
            _loc1_.eventProgress.add(threadProgress);
            _loc1_.eventError.add(threadError);
            _loc1_.run();
         }
      }
      
      protected function threadError(param1:Thread) : void
      {
         logger.fatal("thread error",param1);
      }
      
      protected function threadProgress(param1:Thread) : void
      {
         logger.debug("progress",this,progressCurrent,progressTotal);
         eventProgress.dispatch(this);
      }
      
      protected function threadComplete(param1:Thread) : void
      {
         logger.debug("thread complete",param1);
         VectorUtil.remove(_activeQueue,param1);
         run();
      }
      
      override public function get progressCurrent() : uint
      {
         var _loc2_:uint = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _progress;
         for each(var _loc1_ in _progress)
         {
            _loc2_ = _loc2_ + _loc1_.progressCurrent;
         }
         return _loc2_;
      }
      
      override public function get progressTotal() : uint
      {
         var _loc2_:uint = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _progress;
         for each(var _loc1_ in _progress)
         {
            _loc2_ = _loc2_ + _loc1_.progressTotal;
         }
         return _loc2_;
      }
   }
}
