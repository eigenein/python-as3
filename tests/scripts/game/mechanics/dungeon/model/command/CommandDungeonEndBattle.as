package game.mechanics.dungeon.model.command
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.InvalidBattleHandler;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.data.reward.RewardData;
   import game.mechanics.dungeon.mediator.DungeonBattleResultValueObject;
   import game.mechanics.dungeon.model.PlayerDungeonData;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class CommandDungeonEndBattle extends CostCommand
   {
       
      
      private var _commandResult:DungeonBattleResultValueObject;
      
      private var _battleResult:MultiBattleResult;
      
      private var _rewardMultiplier:int;
      
      public function CommandDungeonEndBattle(param1:MultiBattleResult)
      {
         super();
         this._battleResult = param1;
         rpcRequest = new RpcRequest("dungeonEndBattle");
         rpcRequest.writeParam("result",param1.result);
         rpcRequest.writeParam("progress",param1.progress);
      }
      
      public function get commandResult() : DungeonBattleResultValueObject
      {
         return _commandResult;
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
      
      public function get rewardMultiplier() : int
      {
         return _rewardMultiplier;
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         Game.instance.screen.hideBattle();
         super.onRpc_errorHandler(param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc3_:int = 0;
         super.clientExecute(param1);
         _commandResult = BattleResultValueObjectFactory.createDungeonResult(battleResult,null);
         if(!result.body)
         {
            return;
         }
         if(result.body.error)
         {
            InvalidBattleHandler.dungeon(_battleResult,result.body);
            return;
         }
         var _loc2_:* = result.body.reward;
         var _loc5_:* = result.body.states.heroes;
         var _loc4_:* = result.body.states.titans;
         param1.dungeon.teamState_heroes.parse(_loc5_);
         param1.dungeon.teamState_titans.parse(_loc4_);
         if(_loc2_)
         {
            _reward = new RewardData(_loc2_);
            _loc3_ = _reward.dungeonActivity;
            _reward.dungeonActivity = 0;
            param1.takeReward(_reward);
            _reward.dungeonActivity = _loc3_;
         }
         if(result.body.dungeonActivity)
         {
            GameModel.instance.player.clan.clan.stat.addPersonalDungeonActivity(_loc3_);
            GameModel.instance.player.clan.clan.updateDungeonActivityOnly(result.body.dungeonActivity);
         }
         _rewardMultiplier = result.body.rewardMultiplier;
         PlayerDungeonData.__print("takeBattleReward");
      }
   }
}
