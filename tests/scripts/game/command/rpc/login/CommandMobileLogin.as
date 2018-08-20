package game.command.rpc.login
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandMobileLogin extends RPCCommandBase
   {
       
      
      public function CommandMobileLogin()
      {
         super();
         rpcRequest = new RpcRequest("mobileLogin");
         new LoginRPCRequest(rpcRequest);
         rpcRequest.writeRequest(new RpcRequest("getPushdCredentials"));
      }
   }
}
