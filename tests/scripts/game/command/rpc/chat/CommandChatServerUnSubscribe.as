package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatServerUnSubscribe extends RPCCommandBase
   {
       
      
      public function CommandChatServerUnSubscribe()
      {
         super();
         rpcRequest = new RpcRequest("chatServerUnsubscribe");
      }
   }
}
