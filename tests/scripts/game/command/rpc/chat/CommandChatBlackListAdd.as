package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandChatBlackListAdd extends RPCCommandBase
   {
       
      
      private var player:Player;
      
      private var userId:String;
      
      public function CommandChatBlackListAdd(param1:Player, param2:String)
      {
         super();
         this.player = param1;
         this.userId = param2;
         rpcRequest = new RpcRequest("chatBlackListAdd");
         rpcRequest.writeParam("ids",[param2]);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.chat.blackList[userId] = true;
         param1.chat.signal_blackListUpdate.dispatch();
      }
   }
}
