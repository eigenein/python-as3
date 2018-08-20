package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mechanics.clan_war.mediator.log.ClanWarLogEntry;
   import game.mechanics.clan_war.popup.log.ClanWarLogSeasonEntry;
   
   public class CommandClanWarGetAvailableHistory extends RPCCommandBase
   {
       
      
      private var _logs:Vector.<ClanWarLogEntry>;
      
      private var _lastSeasonResult:ClanWarLogSeasonEntry;
      
      public function CommandClanWarGetAvailableHistory()
      {
         _logs = new Vector.<ClanWarLogEntry>();
         super();
         rpcRequest = new RpcRequest("clanWarGetAvailableHistory");
      }
      
      public function get logs() : Vector.<ClanWarLogEntry>
      {
         return _logs;
      }
      
      public function get lastSeasonResult() : ClanWarLogSeasonEntry
      {
         return _lastSeasonResult;
      }
      
      override protected function successHandler() : void
      {
         var _loc1_:Object = !!result.body.results?result.body.results.previous:{};
         _lastSeasonResult = new ClanWarLogSeasonEntry(_loc1_);
         var _loc4_:int = 0;
         var _loc3_:* = result.body.history;
         for each(var _loc2_ in result.body.history)
         {
            _logs.push(new ClanWarLogEntry(_loc2_));
         }
         super.successHandler();
      }
   }
}
