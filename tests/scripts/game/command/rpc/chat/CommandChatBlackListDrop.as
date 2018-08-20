package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandChatBlackListDrop extends RPCCommandBase
   {
       
      
      private var player:Player;
      
      public function CommandChatBlackListDrop(param1:Player)
      {
         super();
         this.player = param1;
         rpcRequest = new RpcRequest("chatBlackListDrop");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.chat.blackList;
         for(var _loc2_ in param1.chat.blackList)
         {
            delete param1.chat.blackList[_loc2_];
         }
         param1.chat.signal_blackListUpdate.dispatch();
      }
   }
}
