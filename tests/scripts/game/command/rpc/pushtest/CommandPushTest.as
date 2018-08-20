package game.command.rpc.pushtest
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandPushTest extends RPCCommandBase
   {
       
      
      public function CommandPushTest()
      {
         super();
         rpcRequest = new RpcRequest("pushSend");
      }
   }
}
