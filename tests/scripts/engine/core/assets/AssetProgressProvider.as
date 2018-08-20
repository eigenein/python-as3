package engine.core.assets
{
   import engine.core.utils.thread.Thread;
   import idv.cjcat.signals.Signal;
   
   public class AssetProgressProvider
   {
      
      private static var _NOT_IN_PROGRESS:AssetProgressProvider;
       
      
      private var threads:Vector.<Thread>;
      
      private var _progressTotal:Number;
      
      private var _progressCurrent:Number;
      
      public const signal_onProgress:Signal = new Signal(AssetProgressProvider);
      
      public function AssetProgressProvider(param1:Vector.<Thread>)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function get NOT_IN_PROGRESS() : AssetProgressProvider
      {
         if(_NOT_IN_PROGRESS)
         {
            §§push(_NOT_IN_PROGRESS);
         }
         else
         {
            _NOT_IN_PROGRESS = new AssetProgressProvider(new Vector.<Thread>());
            §§push(new AssetProgressProvider(new Vector.<Thread>()));
         }
         return §§pop();
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get completed() : Boolean
      {
         return _progressCurrent == _progressTotal;
      }
      
      public function get progressCurrent() : Number
      {
         return _progressCurrent;
      }
      
      public function get progressTotal() : Number
      {
         return _progressTotal;
      }
      
      private function onProgressHandler(param1:Thread) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
