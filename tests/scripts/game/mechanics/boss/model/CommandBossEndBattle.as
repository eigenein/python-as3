package game.mechanics.boss.model
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.InvalidBattleHandler;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandBossEndBattle extends RPCCommandBase
   {
       
      
      private var _boss:PlayerBossEntry;
      
      private var _commandResult:BossBattleResultValueObject;
      
      private var _battleResult:MultiBattleResult;
      
      public function CommandBossEndBattle(param1:MultiBattleResult, param2:PlayerBossEntry)
      {
         super();
         this._battleResult = param1;
         this._boss = param2;
         rpcRequest = new RpcRequest("bossEndBattle");
         rpcRequest.writeParam("result",param1.result);
         rpcRequest.writeParam("progress",param1.progress);
         if(param1.victory)
         {
            rpcRequest.writeRequest(new RpcRequest("bossGetAll"),"bossGetAll");
         }
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
      
      public function get commandResult() : BossBattleResultValueObject
      {
         return _commandResult;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         var _loc2_:uint = _boss.level != null?_boss.level.bossLevel + 1:1;
         _commandResult = new BossBattleResultValueObject(_boss.type.getLevelByBossLevel(_loc2_).level);
         _commandResult.result = _battleResult;
         _commandResult.stars = _battleResult.result.stars;
         _commandResult.win = _battleResult.result.win;
         if(result.body)
         {
            _commandResult.everyWinReward = new RewardData(result.body.everyWinReward);
            _commandResult.firstWinReward = new RewardData(result.body.firstWinReward);
            param1.takeReward(_commandResult.everyWinReward);
            param1.takeReward(_commandResult.firstWinReward);
            param1.boss.updateAll(result.data["bossGetAll"]);
            if(result.body.error)
            {
               InvalidBattleHandler.boss(_battleResult,result.body.serverVersion);
            }
         }
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
