package com.progrestar.common.new_rpc
{
   import flash.events.Event;
   
   public class RpcClientErrorEvent extends Event
   {
      
      public static const IO_ERROR:String = "ioError";
      
      public static const SECURITY_ERROR:String = "securityError";
       
      
      private var _rpcEntryBase:RpcEntryBase;
      
      public function RpcClientErrorEvent(param1:String, param2:RpcEntryBase)
      {
         super(param1);
         _rpcEntryBase = param2;
      }
      
      public function get rpcEntryBase() : RpcEntryBase
      {
         return _rpcEntryBase;
      }
   }
}
