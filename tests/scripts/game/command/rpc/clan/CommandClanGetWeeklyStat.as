package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanGetWeeklyStat extends RPCCommandBase
   {
       
      
      public function CommandClanGetWeeklyStat()
      {
         super();
         rpcRequest = new RpcRequest("clanGetWeeklyStat");
      }
   }
}
