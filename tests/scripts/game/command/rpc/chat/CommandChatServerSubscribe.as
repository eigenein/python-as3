package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatServerSubscribe extends RPCCommandBase
   {
       
      
      public function CommandChatServerSubscribe()
      {
         super();
         isImmediate = false;
         rpcRequest = new RpcRequest("chatServerSubscribe");
      }
   }
}
