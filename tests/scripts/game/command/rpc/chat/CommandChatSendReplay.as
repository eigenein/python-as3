package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatSendReplay extends RPCCommandBase
   {
       
      
      public function CommandChatSendReplay(param1:String, param2:String, param3:String)
      {
         super();
         rpcRequest = new RpcRequest("chatSendReplay");
         rpcRequest.writeParam("chatType",param1);
         rpcRequest.writeParam("replayId",param2);
         rpcRequest.writeParam("text",param3);
      }
   }
}
