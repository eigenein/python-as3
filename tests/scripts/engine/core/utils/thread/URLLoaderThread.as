package engine.core.utils.thread
{
   import com.progrestar.common.Logger;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class URLLoaderThread extends Thread
   {
      
      private static const logger:Logger = Logger.getLogger(URLLoaderThread);
       
      
      protected const _urlLoader:URLLoader = new URLLoader();
      
      private var _completed:Boolean;
      
      protected var _urlRequest:URLRequest;
      
      public function URLLoaderThread(param1:String = null, param2:URLRequest = null)
      {
         super();
         if(param2)
         {
            _urlRequest = param2;
         }
         else if(param1)
         {
            this.url = param1;
         }
         urlLoader.addEventListener("complete",loader_onComplete);
         urlLoader.addEventListener("ioError",loader_onError);
         urlLoader.addEventListener("securityError",loader_onError);
      }
      
      public function get urlLoader() : URLLoader
      {
         return _urlLoader;
      }
      
      override public function get progressCurrent() : uint
      {
         return !!_completed?1:0;
      }
      
      override public function get progressTotal() : uint
      {
         return 1;
      }
      
      override public function run() : void
      {
         if(urlRequest)
         {
            urlLoader.load(urlRequest);
         }
         else
         {
            new URLRequest(url);
         }
         super.run();
         eventProgress.dispatch(this);
      }
      
      protected function loader_onComplete(param1:Event) : void
      {
         eventProgress.dispatch(this);
         eventComplete.dispatch(this);
         dispose();
      }
      
      protected function loader_onError(param1:Event) : void
      {
         logger.fatal(param1);
         eventError.dispatch(this);
         dispose();
      }
      
      public function get urlRequest() : URLRequest
      {
         return _urlRequest;
      }
      
      public function set urlRequest(param1:URLRequest) : void
      {
         _urlRequest = param1;
      }
      
      public function get url() : String
      {
         return !!urlRequest?urlRequest.url:null;
      }
      
      public function set url(param1:String) : void
      {
         _urlRequest = new URLRequest(param1);
      }
   }
}
