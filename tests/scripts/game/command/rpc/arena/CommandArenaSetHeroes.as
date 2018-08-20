package game.command.rpc.arena
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.Player;
   
   public class CommandArenaSetHeroes extends RPCCommandBase
   {
       
      
      protected var heroes:Vector.<UnitDescription>;
      
      public function CommandArenaSetHeroes(param1:Vector.<UnitDescription>)
      {
         super();
         this.heroes = param1;
         rpcRequest = new RpcRequest("arenaSetHeroes");
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_.id);
         }
         rpcRequest.writeParam("heroes",_loc3_);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(result.body)
         {
            param1.arena.update(result.body);
         }
      }
   }
}
