package game.mechanics.dungeon.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.hero.UnitEntry;
   
   public class CommandDungeonStartBattle extends RPCCommandBase
   {
       
      
      private var _units:Vector.<UnitEntry>;
      
      private var _enemyIndex:int;
      
      public function CommandDungeonStartBattle(param1:Vector.<UnitEntry>, param2:int)
      {
         var _loc4_:int = 0;
         this._units = param1;
         this._enemyIndex = param2;
         var _loc5_:Array = [];
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_[_loc4_] = param1[_loc4_].id;
            _loc4_++;
         }
         super();
         rpcRequest = new RpcRequest("dungeonStartBattle");
         rpcRequest.writeParam("heroes",_loc5_);
         rpcRequest.writeParam("teamNum",param2);
      }
      
      public function get enemyIndex() : int
      {
         return _enemyIndex;
      }
      
      public function get units() : Vector.<UnitEntry>
      {
         return _units;
      }
      
      public function get battleInfo() : Object
      {
         return result.body;
      }
      
      public function startBattle(param1:Player) : void
      {
         param1.dungeon.action_startBattle(units,result.body);
      }
   }
}
