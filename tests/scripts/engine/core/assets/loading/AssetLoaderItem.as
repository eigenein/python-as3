package engine.core.assets.loading
{
   import engine.core.assets.file.AssetFile;
   import engine.core.utils.Broadcaster;
   import engine.core.utils.MathUtil;
   
   public class AssetLoaderItem
   {
       
      
      protected var _completeEvent:Broadcaster;
      
      protected var _progressEvent:Broadcaster;
      
      private var _isCompleted:Boolean;
      
      private var _isSuccess:Boolean;
      
      private var _isProcessing:Boolean;
      
      private var _file:AssetFile;
      
      public function AssetLoaderItem(param1:AssetFile)
      {
         _completeEvent = new Broadcaster(this);
         _progressEvent = new Broadcaster(this);
         super();
         _file = param1;
      }
      
      public function get progressEvent() : Broadcaster
      {
         return _progressEvent;
      }
      
      public function get file() : AssetFile
      {
         return _file;
      }
      
      public final function process() : void
      {
         if(_isProcessing == false)
         {
            _isProcessing = true;
            load();
         }
      }
      
      public final function dispose() : void
      {
         if(isCompleted)
         {
            _isCompleted = false;
            _isSuccess = false;
            _isProcessing = false;
            unload();
         }
         else if(_isProcessing)
         {
            throw "Can\'t dispose asset while processing";
         }
      }
      
      public final function get progress() : Number
      {
         if(isCompleted)
         {
            return 1;
         }
         if(!_isProcessing)
         {
            return 0;
         }
         return MathUtil.clamp(getProgress(),0,1);
      }
      
      public final function subscribe(param1:Function) : void
      {
         if(isCompleted)
         {
            param1(this);
         }
         else
         {
            _completeEvent.addListener(param1);
            process();
         }
      }
      
      public final function unsubscribe(param1:Function) : void
      {
         _completeEvent.removeListener(param1);
      }
      
      protected function load() : void
      {
         throw "Not implement";
      }
      
      protected function unload() : void
      {
         throw "Not implement";
      }
      
      protected function getProgress() : Number
      {
         return 0;
      }
      
      protected final function complete(param1:Boolean) : void
      {
         if(!isCompleted)
         {
            _file.completeAsync(this);
            _isSuccess = param1;
            _isCompleted = true;
            _progressEvent.dispatch();
            _completeEvent.dispatch();
            _completeEvent.purge();
         }
      }
      
      public final function get isCompleted() : Boolean
      {
         return _isCompleted;
      }
      
      public final function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
   }
}
