package engine.loader.thread
{
   import engine.core.utils.VectorUtil;
   import engine.core.utils.thread.Thread;
   
   public class GlobalAssetLoaderThreadQueue extends AssetLoaderThreadQueue
   {
       
      
      public function GlobalAssetLoaderThreadQueue(param1:int = 1)
      {
         super(param1);
      }
      
      override protected function threadComplete(param1:Thread) : void
      {
         super.threadComplete(param1);
         VectorUtil.remove(_progress,param1);
      }
   }
}
