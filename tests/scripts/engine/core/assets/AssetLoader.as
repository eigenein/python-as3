package engine.core.assets
{
   import com.progrestar.common.util.assert;
   import engine.core.assets.file.AssetFile;
   import engine.core.utils.thread.AssetLoaderThread;
   import engine.core.utils.thread.Thread;
   import engine.loader.thread.GlobalAssetLoaderThreadQueue;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   
   public class AssetLoader implements AssetProvider
   {
      
      private static const requestPool:Vector.<AssetRequest> = new Vector.<AssetRequest>();
      
      private static var callbacksPool:CallbackListNode;
      
      public static const highLoadTasks:AssetLoaderPausableTaskQueue = new AssetLoaderPausableTaskQueue();
       
      
      private const filesLoader:GlobalAssetLoaderThreadQueue = new GlobalAssetLoaderThreadQueue(5);
      
      private const requests:Dictionary = new Dictionary();
      
      private var requestedAssetsCallbacks:Dictionary;
      
      private var assetsCompleted:int;
      
      private var assetsRequested:int;
      
      public const eventComplete:Signal = new Signal(AssetLoader);
      
      public function AssetLoader()
      {
         requestedAssetsCallbacks = new Dictionary();
         super();
         assetsRequested = 0;
         assetsCompleted = 0;
         filesLoader.onFileLoaded.add(onFileLoaded);
         filesLoader.run();
      }
      
      public function tryComplete(param1:Function = null) : Boolean
      {
         if(assetsCompleted == assetsRequested)
         {
            completeAll();
            param1 && param1(this);
            return true;
         }
         param1 && eventComplete.addOnce(param1);
         return false;
      }
      
      public function run() : void
      {
         if(assetsCompleted == assetsRequested)
         {
            eventComplete.dispatch(this);
         }
      }
      
      public function requestAsset(param1:RequestableAsset) : void
      {
         if(!param1.completed && !requests[param1])
         {
            requestIncompleteAsset(param1);
         }
      }
      
      public function requestAssetWithCallback(param1:RequestableAsset, param2:Function) : void
      {
         if(!param1)
         {
            return;
         }
         assert(param2);
         if(param1.completed)
         {
            param2(param1);
         }
         else if(!requests[param1] && requestIncompleteAsset(param1))
         {
            param2(param1);
         }
         else
         {
            registerCallback(param1,param2);
         }
      }
      
      public function cancelCallback(param1:Function) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = requestedAssetsCallbacks;
         for(var _loc4_ in requestedAssetsCallbacks)
         {
            _loc3_ = requestedAssetsCallbacks[_loc4_];
            if(_loc3_.method == param1)
            {
               if(_loc3_.next)
               {
                  requestedAssetsCallbacks[_loc4_] = _loc3_.next;
               }
               else
               {
                  delete requestedAssetsCallbacks[_loc4_];
               }
               _loc2_ = _loc3_;
            }
            else
            {
               while(_loc3_.next)
               {
                  if(_loc3_.next.method == param1)
                  {
                     _loc2_ = _loc3_.next;
                     _loc3_.next = _loc3_.next.next;
                     if(!_loc3_.next)
                     {
                        break;
                     }
                  }
                  _loc3_ = _loc3_.next;
               }
            }
            if(_loc2_ && _loc2_ != callbacksPool)
            {
               _loc2_.next = callbacksPool;
               callbacksPool = _loc2_;
            }
         }
      }
      
      public function getAssetProgress(param1:RequestableAsset) : AssetProgressProvider
      {
         if(param1.completed)
         {
            return AssetProgressProvider.NOT_IN_PROGRESS;
         }
         if(!requests[param1])
         {
            return AssetProgressProvider.NOT_IN_PROGRESS;
         }
         var _loc2_:Vector.<Thread> = new Vector.<Thread>();
         getFileThreads(_loc2_,param1);
         return new AssetProgressProvider(_loc2_ as Vector.<Thread>);
      }
      
      public function getRequestedAssets(param1:RequestableAsset) : Vector.<AssetRequest>
      {
         if(requests[param1])
         {
            return requests[param1].concat();
         }
         return null;
      }
      
      public function request(param1:RequestableAsset, ... rest) : void
      {
         var _loc5_:* = null;
         assert(param1 != null);
         assert(rest && rest.length);
         if(rest[0] is Array && rest.length == 1)
         {
            rest = rest[0];
         }
         var _loc3_:AssetRequest = !!requestPool.length?requestPool.pop():new AssetRequest();
         _loc3_.assetsToBeLoaded = 0;
         var _loc7_:int = 0;
         var _loc6_:* = rest;
         for each(var _loc4_ in rest)
         {
            _loc5_ = _loc4_ as RequestableAsset;
            if(_loc5_ && !_loc5_.completed)
            {
               if(!requests[_loc5_])
               {
                  if(requestIncompleteAsset(_loc5_))
                  {
                     continue;
                  }
               }
               _loc3_.assetsToBeLoaded = Number(_loc3_.assetsToBeLoaded) + 1;
               requests[_loc5_].push(_loc3_);
            }
         }
         if(_loc3_.assetsToBeLoaded)
         {
            _loc3_.requestor = param1;
         }
         else
         {
            onAssetReady(param1);
            requestPool[requestPool.length] = _loc3_;
         }
      }
      
      public function requestOnDemand(param1:Vector.<AssetFile>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(requests[param1[_loc3_]])
            {
               _loc3_--;
               _loc2_--;
               param1[_loc3_] = param1[_loc2_];
            }
            _loc3_++;
         }
         param1.length = _loc2_;
         filesLoader.loadFiles(param1);
      }
      
      protected function completeAll() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = requestedAssetsCallbacks;
         for(var _loc1_ in requestedAssetsCallbacks)
         {
            processCallbacks(requestedAssetsCallbacks[_loc1_],_loc1_);
            throw "Some asset was not completed in time";
         }
         requestedAssetsCallbacks = new Dictionary();
         eventComplete.dispatch(this);
      }
      
      private function onFileLoaded(param1:AssetFile) : void
      {
         onAssetReady(param1);
      }
      
      private function onAssetReady(param1:RequestableAsset) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function requestIncompleteAsset(param1:RequestableAsset) : Boolean
      {
         if(param1 is AssetFile)
         {
            filesLoader.loadAsset(param1 as AssetFile);
         }
         else
         {
            param1.prepare(this);
            if(param1.completed)
            {
               return true;
            }
         }
         assert(requests[param1] == null);
         requests[param1] = new Vector.<AssetRequest>();
         assetsRequested = Number(assetsRequested) + 1;
         return false;
      }
      
      private function getFileThreads(param1:Vector.<Thread>, param2:RequestableAsset) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = undefined;
         if(param2 is AssetFile)
         {
            _loc5_ = filesLoader.getAssetThread(param2 as AssetFile);
            if(_loc5_)
            {
               assert(_loc5_);
               param1.push(_loc5_);
            }
         }
         else
         {
            var _loc10_:int = 0;
            var _loc9_:* = requests;
            for(var _loc4_ in requests)
            {
               _loc6_ = requests[_loc4_];
               var _loc8_:int = 0;
               var _loc7_:* = _loc6_;
               for each(var _loc3_ in _loc6_)
               {
                  if(_loc3_.requestor == param2)
                  {
                     getFileThreads(param1,_loc4_);
                     break;
                  }
               }
            }
         }
      }
      
      private function registerCallback(param1:RequestableAsset, param2:Function) : void
      {
         var _loc3_:* = null;
         if(callbacksPool)
         {
            _loc3_ = callbacksPool;
            callbacksPool = callbacksPool.next;
            _loc3_.next = requestedAssetsCallbacks[param1];
            _loc3_.method = param2;
            requestedAssetsCallbacks[param1] = _loc3_;
         }
         else
         {
            requestedAssetsCallbacks[param1] = new CallbackListNode(param2,requestedAssetsCallbacks[param1]);
         }
      }
      
      private function processCallbacks(param1:CallbackListNode, param2:RequestableAsset) : void
      {
         var _loc3_:* = null;
         assert(param1);
         _loc3_ = param1;
         while(_loc3_.next)
         {
            _loc3_.method(param2);
            _loc3_.method = null;
            _loc3_ = _loc3_.next;
         }
         _loc3_.method(param2);
         _loc3_.method = null;
         _loc3_.next = callbacksPool;
         callbacksPool = param1;
      }
   }
}

class CallbackListNode
{
    
   
   public var method:Function;
   
   private var _next:CallbackListNode;
   
   function CallbackListNode(param1:Function, param2:CallbackListNode)
   {
      super();
      this.method = param1;
      this.next = param2;
   }
   
   public function set next(param1:CallbackListNode) : void
   {
      _next = param1;
      if(param1 == this)
      {
         trace("here");
      }
   }
   
   public function get next() : CallbackListNode
   {
      return _next;
   }
}
