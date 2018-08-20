package game.command.rpc.player
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandUserGetInfoByIds extends RPCCommandBase
   {
       
      
      public function CommandUserGetInfoByIds(param1:Array)
      {
         super();
         rpcRequest = new RpcRequest("userGetInfoByIds");
         rpcRequest.writeParam("ids",param1);
      }
   }
}
