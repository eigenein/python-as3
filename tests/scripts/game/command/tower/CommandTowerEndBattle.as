package game.command.tower
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.InvalidBattleHandler;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.tower.TowerBattleResultValueObject;
   import game.model.user.Player;
   import game.model.user.tower.PlayerTowerData;
   
   public class CommandTowerEndBattle extends RPCCommandBase
   {
       
      
      private var _commandResult:TowerBattleResultValueObject;
      
      private var _reward:RewardData;
      
      private var _towerPoint:int;
      
      private var _battleResult:MultiBattleResult;
      
      public function CommandTowerEndBattle(param1:MultiBattleResult)
      {
         super();
         this._battleResult = param1;
         rpcRequest = new RpcRequest("towerEndBattle");
         rpcRequest.writeParam("result",param1.result);
         rpcRequest.writeParam("progress",param1.progress);
      }
      
      public function get battleResult() : MultiBattleResult
      {
         return _battleResult;
      }
      
      public function get victory() : Boolean
      {
         return battleResult.victory;
      }
      
      public function get success() : Boolean
      {
         return result.body && !result.body.error;
      }
      
      public function get commandResult() : TowerBattleResultValueObject
      {
         return _commandResult;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get towerPoint() : int
      {
         return _towerPoint;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         _commandResult = BattleResultValueObjectFactory.createTowerResult(battleResult,null);
         if(!result.body)
         {
            return;
         }
         if(result.body.error)
         {
            InvalidBattleHandler.tower(_battleResult,result.body);
            return;
         }
         var _loc2_:* = result.body.reward;
         var _loc3_:* = result.body.states.heroes;
         var _loc4_:Boolean = param1.tower.heroes.allDead;
         param1.tower.heroes.parse(_loc3_);
         if(_loc2_)
         {
            _reward = new RewardData(_loc2_);
            if(result.body.reward.towerPoint)
            {
               _towerPoint = result.body.reward.towerPoint;
            }
            param1.takeReward(_reward);
         }
         if(param1.tower.heroes.allDead && !_loc4_)
         {
            param1.tower.towerEndMessage();
         }
         PlayerTowerData.__print("takeBattleReward");
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         Game.instance.screen.hideBattle();
         super.onRpc_errorHandler(param1);
      }
   }
}
