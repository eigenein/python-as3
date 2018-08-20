package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanWarGetStatus extends RPCCommandBase
   {
       
      
      public function CommandClanWarGetStatus()
      {
         super();
         rpcRequest = new RpcRequest("clanWarGetDefence");
         rpcRequest.writeRequest(new RpcRequest("clanWarGetInfo"));
      }
   }
}
