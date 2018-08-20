package game.command.rpc.chat
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.UserInfo;
   
   public class CommandChatAcceptChallenge extends RPCCommandBase
   {
       
      
      private var _isTitanBattle:Boolean;
      
      private var _attacker:UserInfo;
      
      private var _defender:UserInfo;
      
      public function CommandChatAcceptChallenge(param1:int, param2:Array, param3:Boolean, param4:UserInfo, param5:UserInfo)
      {
         super();
         _isTitanBattle = param3;
         _attacker = param4;
         _defender = param5;
         rpcRequest = new RpcRequest("chatAcceptChallenge");
         rpcRequest.writeParam("messageId",param1);
         rpcRequest.writeParam("heroes",param2);
      }
      
      public function get isTitanBattle() : Boolean
      {
         return _isTitanBattle;
      }
      
      public function get attacker() : UserInfo
      {
         return _attacker;
      }
      
      public function get defender() : UserInfo
      {
         return _defender;
      }
   }
}
