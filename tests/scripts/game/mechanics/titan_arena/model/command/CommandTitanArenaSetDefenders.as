package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   
   public class CommandTitanArenaSetDefenders extends RPCCommandBase
   {
       
      
      public function CommandTitanArenaSetDefenders(param1:Vector.<UnitDescription>)
      {
         super();
         rpcRequest = new RpcRequest("titanArenaSetDefenders");
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_.id);
         }
         rpcRequest.writeParam("titans",_loc3_);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
