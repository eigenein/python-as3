package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanWarTestStart extends RPCCommandBase
   {
       
      
      public function CommandClanWarTestStart()
      {
         super();
         rpcRequest = new RpcRequest("testClanWarMakeWar");
         rpcRequest.writeParam("attackers",1005);
         rpcRequest.writeParam("defenders",1671);
      }
   }
}
