package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatSendChallenge extends RPCCommandBase
   {
       
      
      public function CommandChatSendChallenge(param1:String, param2:Array, param3:String, param4:Boolean = false)
      {
         super();
         rpcRequest = new RpcRequest("chatSendChallenge");
         rpcRequest.writeParam("chatType",param1);
         rpcRequest.writeParam("heroes",param2);
         rpcRequest.writeParam("text",param3);
         rpcRequest.writeParam("type",!!param4?"titan":"hero");
      }
   }
}
