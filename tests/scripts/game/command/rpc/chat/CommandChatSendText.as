package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatSendText extends RPCCommandBase
   {
       
      
      private var text:String;
      
      private var chatType:String;
      
      public function CommandChatSendText(param1:String, param2:String)
      {
         super();
         this.chatType = param2;
         this.text = param1;
         rpcRequest = new RpcRequest("chatSendText");
         rpcRequest.writeParam("chatType",param2);
         rpcRequest.writeParam("text",param1);
      }
   }
}
