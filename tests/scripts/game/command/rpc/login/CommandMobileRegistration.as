package game.command.rpc.login
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandMobileRegistration extends RPCCommandBase
   {
       
      
      public function CommandMobileRegistration()
      {
         super();
         rpcRequest = new RpcRequest("registration");
         rpcRequest.writeRequest(new RpcRequest("getLibVersion"));
      }
   }
}
