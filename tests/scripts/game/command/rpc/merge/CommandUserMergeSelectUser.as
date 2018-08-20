package game.command.rpc.merge
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandUserMergeSelectUser extends RPCCommandBase
   {
       
      
      public function CommandUserMergeSelectUser(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("userMergeSelectUser");
         rpcRequest.writeParam("id",param1);
      }
   }
}
