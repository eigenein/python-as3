package engine.loader.thread
{
   import com.progrestar.common.util.assert;
   import engine.core.assets.file.AssetFile;
   import engine.core.utils.thread.AssetLoaderThread;
   import engine.core.utils.thread.Thread;
   import engine.core.utils.thread.ThreadQueue;
   import idv.cjcat.signals.Signal;
   
   public class AssetLoaderThreadQueue extends ThreadQueue
   {
       
      
      private var running:Boolean;
      
      public const onFileLoaded:Signal = new Signal(AssetFile);
      
      public function AssetLoaderThreadQueue(param1:int = 1)
      {
         super(param1);
      }
      
      public function loadFiles(param1:Vector.<AssetFile>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            assert(param1[_loc4_]);
            _loc3_ = new AssetLoaderThread(param1[_loc4_]);
            addThread(_loc3_);
            _loc4_++;
         }
         if(running)
         {
            super.run();
         }
      }
      
      public function loadAsset(param1:AssetFile) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getAssetThread(param1:AssetFile) : AssetLoaderThread
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function threadComplete(param1:Thread) : void
      {
         var _loc2_:AssetLoaderThread = param1 as AssetLoaderThread;
         super.threadComplete(param1);
         onFileLoaded.dispatch(_loc2_.file);
      }
      
      override public function run() : void
      {
         if(_progress.length > 0)
         {
            super.run();
         }
         else
         {
            running = true;
         }
      }
   }
}
