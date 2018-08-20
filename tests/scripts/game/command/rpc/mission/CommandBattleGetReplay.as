package game.command.rpc.mission
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandBattleGetReplay extends RPCCommandBase
   {
       
      
      private var _playerId:String;
      
      public function CommandBattleGetReplay(param1:String, param2:String)
      {
         super();
         this._playerId = param2;
         rpcRequest = new RpcRequest("battleGetReplay");
         rpcRequest.writeParam("id",param1);
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
   }
}
