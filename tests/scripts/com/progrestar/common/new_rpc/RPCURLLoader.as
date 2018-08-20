package com.progrestar.common.new_rpc
{
   import com.rokannon.core.destroyable.Destroyable;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import org.osflash.signals.natives.NativeSignal;
   
   public class RPCURLLoader extends Destroyable
   {
       
      
      private var _urlLoader:URLLoader;
      
      private var _completed:NativeSignal;
      
      private var _ioErrorThrown:NativeSignal;
      
      private var _securityErrorThrown:NativeSignal;
      
      private var _statusEvent:NativeSignal;
      
      public function RPCURLLoader()
      {
         super();
         _urlLoader = new URLLoader();
         _completed = new NativeSignal(_urlLoader,"complete",Event);
         _ioErrorThrown = new NativeSignal(_urlLoader,"ioError",IOErrorEvent);
         _securityErrorThrown = new NativeSignal(_urlLoader,"securityError",SecurityErrorEvent);
         _statusEvent = new NativeSignal(_urlLoader,"httpResponseStatus",HTTPStatusEvent);
      }
      
      public function get completed() : NativeSignal
      {
         return _completed;
      }
      
      public function get ioErrorThrown() : NativeSignal
      {
         return _ioErrorThrown;
      }
      
      public function get securityErrorThrown() : NativeSignal
      {
         return _securityErrorThrown;
      }
      
      public function get statusEvent() : NativeSignal
      {
         return _statusEvent;
      }
      
      function get urlLoader() : URLLoader
      {
         return _urlLoader;
      }
      
      public function load(param1:URLRequest) : void
      {
         _urlLoader.load(param1);
      }
      
      override protected function _destroy() : void
      {
         _completed.removeAll();
         _completed = null;
         _ioErrorThrown.removeAll();
         _ioErrorThrown = null;
         _securityErrorThrown.removeAll();
         _securityErrorThrown = null;
         _urlLoader = null;
         super._destroy();
      }
   }
}
