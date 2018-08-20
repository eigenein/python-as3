package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandChatBlackListRemove extends RPCCommandBase
   {
       
      
      private var player:Player;
      
      private var userId:String;
      
      public function CommandChatBlackListRemove(param1:Player, param2:String)
      {
         super();
         this.player = param1;
         this.userId = param2;
         rpcRequest = new RpcRequest("chatBlackListRemove");
         rpcRequest.writeParam("ids",[param2]);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         delete param1.chat.blackList[userId];
         param1.chat.signal_blackListUpdate.dispatch();
      }
   }
}
