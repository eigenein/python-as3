package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   
   public class CommandClanWarSetDefenceTeam extends RPCCommandBase
   {
       
      
      public function CommandClanWarSetDefenceTeam(param1:Vector.<UnitDescription>, param2:Boolean)
      {
         super();
         rpcRequest = new RpcRequest("clanWarSetDefenceTeam");
         var _loc4_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc4_.push(_loc3_.id);
         }
         rpcRequest.writeParam("team",_loc4_);
         rpcRequest.writeParam("type",!!param2?"clanDefence_titans":"clanDefence_heroes");
      }
   }
}
