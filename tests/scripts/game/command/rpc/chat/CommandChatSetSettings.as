package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandChatSetSettings extends RPCCommandBase
   {
       
      
      public function CommandChatSetSettings(param1:Player)
      {
         super();
         rpcRequest = new RpcRequest("chatSetSettings");
         var _loc4_:int = 0;
         var _loc3_:* = param1.chat.settings;
         for(var _loc2_ in param1.chat.settings)
         {
            rpcRequest.writeParam(_loc2_,param1.chat.settings[_loc2_]);
         }
         isImmediate = false;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.chat.settingsChange = false;
      }
   }
}
