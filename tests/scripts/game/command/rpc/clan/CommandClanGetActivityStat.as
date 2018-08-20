package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanGetActivityStat extends RPCCommandBase
   {
       
      
      public function CommandClanGetActivityStat()
      {
         super();
         rpcRequest = new RpcRequest("clanGetActivityStat");
      }
      
      public function get clanActivity() : int
      {
         return result.body.clanActivity;
      }
      
      public function get dungeonActivity() : int
      {
         return result.body.dungeonActivity;
      }
      
      public function get stat() : Object
      {
         return result.body.stat;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(result && result.body)
         {
            if(param1.clan.clan)
            {
               param1.clan.clan.updateActivity(this);
            }
         }
         super.clientExecute(param1);
      }
   }
}
