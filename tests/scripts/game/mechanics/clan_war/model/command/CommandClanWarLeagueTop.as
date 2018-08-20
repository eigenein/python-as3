package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mechanics.clan_war.model.ClanWarRaitingData;
   
   public class CommandClanWarLeagueTop extends RPCCommandBase
   {
       
      
      private var _raiting:ClanWarRaitingData;
      
      public function CommandClanWarLeagueTop(param1:int, param2:Boolean)
      {
         super();
         rpcRequest = new RpcRequest("clanWarGetLeagueTop");
         rpcRequest.writeParam("league",param1);
         rpcRequest.writeParam("current",param2);
      }
      
      public function get raiting() : ClanWarRaitingData
      {
         return _raiting;
      }
      
      public function set raiting(param1:ClanWarRaitingData) : void
      {
         _raiting = param1;
      }
      
      override protected function successHandler() : void
      {
         _raiting = new ClanWarRaitingData();
         _raiting.deserialize(result.body);
         super.successHandler();
      }
   }
}
