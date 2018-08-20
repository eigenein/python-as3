package engine.core.assets
{
   import flash.utils.Dictionary;
   
   public class AssetLoaderPausableTaskQueue
   {
       
      
      private var callbacksQueue:Vector.<Function>;
      
      private var keyObjectsMap:Dictionary;
      
      private var keyCount:int = 0;
      
      public function AssetLoaderPausableTaskQueue()
      {
         callbacksQueue = new Vector.<Function>();
         keyObjectsMap = new Dictionary();
         super();
      }
      
      public function doWhenAppropriate(param1:Function) : void
      {
         if(keyCount == 0)
         {
            param1();
         }
         else
         {
            callbacksQueue.push(param1);
         }
      }
      
      public function pause(param1:Object) : void
      {
         keyObjectsMap[param1] = int(keyObjectsMap[param1]) + 1;
         keyCount = Number(keyCount) + 1;
      }
      
      public function unpause(param1:Object) : void
      {
         var _loc2_:int = keyObjectsMap[param1];
         if(_loc2_ > 0)
         {
            _loc2_--;
            keyCount = Number(keyCount) - 1;
            if(_loc2_ == 0)
            {
               delete keyObjectsMap[param1];
            }
            else
            {
               keyObjectsMap[param1] = _loc2_;
            }
            if(keyCount == 0)
            {
               callCallbacks();
            }
         }
      }
      
      public function free(param1:Object) : void
      {
         var _loc2_:int = keyObjectsMap[param1];
         if(_loc2_ > 0)
         {
            keyCount = keyCount - _loc2_;
            delete keyObjectsMap[param1];
            if(keyCount == 0)
            {
               callCallbacks();
            }
         }
      }
      
      protected function callCallbacks() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = callbacksQueue;
         for each(var _loc1_ in callbacksQueue)
         {
            _loc1_();
         }
         callbacksQueue.length = 0;
      }
   }
}
