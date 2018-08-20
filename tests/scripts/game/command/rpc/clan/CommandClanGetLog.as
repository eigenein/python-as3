package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanGetLog extends RPCCommandBase
   {
       
      
      public function CommandClanGetLog()
      {
         super();
         rpcRequest = new RpcRequest("clanGetLog");
      }
   }
}
