package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatBan extends RPCCommandBase
   {
       
      
      public function CommandChatBan(param1:String, param2:uint)
      {
         super();
         rpcRequest = new RpcRequest("chatBan");
         rpcRequest.writeParam("id",param1);
         rpcRequest.writeParam("banId",param2);
      }
   }
}
