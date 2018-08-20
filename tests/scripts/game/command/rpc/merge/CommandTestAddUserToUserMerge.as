package game.command.rpc.merge
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandTestAddUserToUserMerge extends RPCCommandBase
   {
       
      
      public function CommandTestAddUserToUserMerge()
      {
         super();
         rpcRequest = new RpcRequest("testAddUserToUserMerge");
      }
   }
}
