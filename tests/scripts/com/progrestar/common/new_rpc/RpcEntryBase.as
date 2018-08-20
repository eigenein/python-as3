package com.progrestar.common.new_rpc
{
   public class RpcEntryBase
   {
       
      
      public var request:IrpcRequest;
      
      public var response:RpcResponseBase;
      
      public var timestamp:int;
      
      public var responseCallback:Function;
      
      public var infoHandler:Function;
      
      public var errorHandler:Function;
      
      public var headers:Object;
      
      public function RpcEntryBase()
      {
         super();
      }
   }
}
