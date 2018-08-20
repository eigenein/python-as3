package com.progrestar.common.new_rpc
{
   public interface IRpcClient
   {
       
      
      function setResponse(param1:RpcEntryBase, param2:String) : void;
      
      function setError(param1:RpcEntryBase, param2:String) : void;
   }
}
