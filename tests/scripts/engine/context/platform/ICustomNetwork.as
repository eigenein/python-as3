package engine.context.platform
{
   import com.progrestar.common.new_rpc.IRpcClient;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   
   public interface ICustomNetwork
   {
       
      
      function get isAvailable() : Boolean;
      
      function sendEntry(param1:RpcEntryBase, param2:Object) : void;
      
      function setClient(param1:IRpcClient) : void;
   }
}
