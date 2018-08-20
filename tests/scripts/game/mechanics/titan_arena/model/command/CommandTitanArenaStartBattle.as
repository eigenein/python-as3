package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   
   public class CommandTitanArenaStartBattle extends RPCCommandBase
   {
       
      
      private var _enemy:PlayerTitanArenaEnemy;
      
      public function CommandTitanArenaStartBattle(param1:PlayerTitanArenaEnemy, param2:Vector.<UnitDescription>)
      {
         super();
         this._enemy = param1;
         rpcRequest = new RpcRequest("titanArenaStartBattle");
         rpcRequest.writeParam("rivalId",param1.id);
         var _loc4_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = param2;
         for each(var _loc3_ in param2)
         {
            _loc4_.push(_loc3_.id);
         }
         rpcRequest.writeParam("titans",_loc4_);
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return _enemy;
      }
      
      public function get battle() : Object
      {
         return result.body.battle;
      }
      
      public function get startBattleError() : String
      {
         return result.body.error;
      }
      
      public function get endTime() : int
      {
         return result.body.endTime;
      }
   }
}
