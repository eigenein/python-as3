package game.command.rpc.merge
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandUserMergeGetMergeData extends RPCCommandBase
   {
       
      
      public function CommandUserMergeGetMergeData()
      {
         super();
         rpcRequest = new RpcRequest("userMergeGetMergeData");
      }
   }
}
