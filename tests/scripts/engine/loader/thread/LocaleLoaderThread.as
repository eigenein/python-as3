package engine.loader.thread
{
   import engine.core.utils.thread.GZIPLoaderThread;
   import flash.net.URLRequest;
   
   public class LocaleLoaderThread extends GZIPLoaderThread
   {
       
      
      public function LocaleLoaderThread(param1:String = null, param2:URLRequest = null)
      {
         super(param1,param2);
      }
   }
}
