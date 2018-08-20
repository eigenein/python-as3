package engine.context.platform
{
   import com.progrestar.common.new_rpc.IRpcClient;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   
   public class CustomNetworkDefault implements ICustomNetwork
   {
      
      public static var instance:ICustomNetwork = new CustomNetworkDefault();
       
      
      public function CustomNetworkDefault()
      {
         super();
      }
      
      public function get isAvailable() : Boolean
      {
         return false;
      }
      
      public function sendEntry(param1:RpcEntryBase, param2:Object) : void
      {
      }
      
      public function setClient(param1:IRpcClient) : void
      {
      }
   }
}
