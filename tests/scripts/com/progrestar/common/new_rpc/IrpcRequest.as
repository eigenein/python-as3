package com.progrestar.common.new_rpc
{
   public interface IrpcRequest
   {
       
      
      function getFormattedData() : Object;
      
      function get body() : Object;
      
      function get name() : String;
   }
}
