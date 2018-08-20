package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandChatGetAll extends RPCCommandBase
   {
       
      
      private var _chatType:String;
      
      public function CommandChatGetAll(param1:String)
      {
         super();
         this._chatType = param1;
         rpcRequest = new RpcRequest("chatGetAll");
         rpcRequest.writeParam("chatType",param1);
      }
      
      public function get chatType() : String
      {
         return _chatType;
      }
   }
}
