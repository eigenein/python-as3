package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mechanics.clan_war.popup.leagues.ClanWarLeagueInfoValueObject;
   
   public class CommandClanWarLeagueInfo extends RPCCommandBase
   {
       
      
      private var _info:ClanWarLeagueInfoValueObject;
      
      public function CommandClanWarLeagueInfo()
      {
         super();
         rpcRequest = new RpcRequest("clanWarGetLeagueInfo");
      }
      
      public function get info() : ClanWarLeagueInfoValueObject
      {
         return _info;
      }
      
      override protected function successHandler() : void
      {
         _info = new ClanWarLeagueInfoValueObject();
         _info.deserialize(result.body);
         super.successHandler();
      }
   }
}
