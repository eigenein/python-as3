package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.model.user.Player;
   
   public class CommandTitanArenaStartRaid extends RPCCommandBase
   {
       
      
      private var units:Vector.<UnitDescription>;
      
      public function CommandTitanArenaStartRaid(param1:Vector.<UnitDescription>)
      {
         super();
         rpcRequest = new RpcRequest("titanArenaStartRaid");
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_.id);
         }
         this.units = param1;
         rpcRequest.writeParam("titans",_loc3_);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.heroes.teamData.saveTeam(units,MechanicStorage.TITAN_ARENA);
      }
   }
}
