package game.command.rpc.merge
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandUserMergeGetStatus extends RPCCommandBase
   {
       
      
      public function CommandUserMergeGetStatus()
      {
         super();
         rpcRequest = new RpcRequest("userMergeGetStatus");
         rpcRequest.writeRequest(new RpcRequest("getTime"));
      }
   }
}
