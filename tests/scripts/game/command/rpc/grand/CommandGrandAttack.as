package game.command.rpc.grand
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   import idv.cjcat.signals.Signal;
   
   public class CommandGrandAttack extends RPCCommandBase
   {
       
      
      private var _enemy:PlayerArenaEnemy;
      
      private var _resultBattle:GrandBattleResult;
      
      public const signal_battleReady:Signal = new Signal(GrandBattleResult);
      
      public const signal_outOfRetargetDelta:Signal = new Signal();
      
      public function CommandGrandAttack(param1:PlayerArenaEnemy, param2:Vector.<Vector.<UnitDescription>>)
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc4_:* = undefined;
         super();
         rpcRequest = new RpcRequest("grandAttack");
         this._enemy = param1;
         var _loc5_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            var _loc8_:* = [];
            _loc5_[_loc6_] = _loc8_;
            _loc7_ = _loc8_;
            _loc4_ = param2[_loc6_];
            var _loc10_:int = 0;
            var _loc9_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               _loc7_.push(_loc3_.id);
            }
            _loc6_++;
         }
         rpcRequest.writeParam("userId",int(param1.id));
         rpcRequest.writeParam("heroes",_loc5_);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(!result.body || result.body.error)
         {
            if(result.body && result.body.error == "outOfRetargetDelta")
            {
               signal_outOfRetargetDelta.dispatch();
            }
            else
            {
               trace("Invalid battle");
            }
            return;
         }
         signal_outOfRetargetDelta.clear();
         super.clientExecute(param1);
         param1.grand.setEnemies(PlayerArenaEnemy.parseRawEnemies(result.body.enemies));
         var _loc2_:* = result.body.state;
         param1.grand.setPlace(_loc2_.grandPlace);
         param1.refillable.spend(param1.refillable.getById(DataStorage.arena.grand.refillableBattleId),1);
         param1.refillable.spend(param1.refillable.getById(DataStorage.arena.grand.refillableCooldownId),1);
         if(result.body.battles)
         {
            _resultBattle = new GrandBattleResult(param1,param1.getUserInfo(),_enemy,result.body.battles);
            signal_battleReady.dispatch(_resultBattle);
         }
      }
   }
}
