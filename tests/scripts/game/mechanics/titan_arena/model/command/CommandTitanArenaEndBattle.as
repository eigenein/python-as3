package game.mechanics.titan_arena.model.command
{
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.TitanArenaBattleThread;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.data.reward.RewardData;
   import game.mechanics.clan_war.mediator.ClanWarBattleResultValueObject;
   import game.mechanics.titan_arena.mediator.TitanArenaRoundResultValueObject;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mediator.gui.popup.hero.UnitUtils;
   
   public class CommandTitanArenaEndBattle extends CostCommand
   {
       
      
      private var _battleResult:MultiBattleResult;
      
      private var _battleResultValueObject:ClanWarBattleResultValueObject;
      
      private var _enemy:PlayerTitanArenaEnemy;
      
      private var _result_attack:TitanArenaRoundResultValueObject;
      
      private var _result_defense:TitanArenaRoundResultValueObject;
      
      public function CommandTitanArenaEndBattle(param1:TitanArenaBattleThread)
      {
         super();
         this._battleResult = param1.battleResult;
         rpcRequest = new RpcRequest("titanArenaEndBattle");
         rpcRequest.writeParam("result",battleResult.result);
         rpcRequest.writeParam("progress",battleResult.progress);
         rpcRequest.writeParam("rivalId",param1.enemy.id);
         _battleResultValueObject = BattleResultValueObjectFactory.createClanWarBattleResult(battleResult);
         _enemy = param1.enemy;
      }
      
      public function get battleResult() : MultiBattleResult
      {
         return _battleResult;
      }
      
      public function get battleResultValueObject() : ClanWarBattleResultValueObject
      {
         return _battleResultValueObject;
      }
      
      public function get victory() : Boolean
      {
         return _battleResult.victory;
      }
      
      public function get success() : Boolean
      {
         return result.body && !result.body.error;
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return _enemy;
      }
      
      public function get place() : int
      {
         return result.body.place;
      }
      
      public function get pointsEarned_attack() : int
      {
         return result.body.attackScoreEarned;
      }
      
      public function get pointsEarned_defense() : int
      {
         return result.body.defenceScoreEarned;
      }
      
      public function get pointsEarned_attack_total() : int
      {
         return result.body.attackScore;
      }
      
      public function get pointsEarned_defense_total() : int
      {
         return result.body.defenceScore;
      }
      
      public function get pointsEarned_total() : int
      {
         return result.body.defenceScoreEarned;
      }
      
      public function get battle() : Object
      {
         return result.body.battle;
      }
      
      public function get defBattle() : Object
      {
         return result.body.defBattle;
      }
      
      public function get result_attack() : TitanArenaRoundResultValueObject
      {
         return _result_attack;
      }
      
      public function get result_defense() : TitanArenaRoundResultValueObject
      {
         return _result_defense;
      }
      
      override protected function successHandler() : void
      {
         if(result.body.reward)
         {
            _reward = new RewardData(result.body.reward);
         }
         _result_attack = _createResultVO(result.body.battle,result.body.rivalTeam,false);
         _result_defense = _createResultVO(result.body.defBattle,result.body.defenceTeam,true);
         super.successHandler();
      }
      
      private function _createResultVO(param1:Object, param2:Object, param3:Boolean) : TitanArenaRoundResultValueObject
      {
         return new TitanArenaRoundResultValueObject(UnitUtils.createUnitEntryVectorFromRawData(param1.attackers),UnitUtils.createUnitEntryVectorFromRawData(param1.defenders[0]),param2,param3);
      }
   }
}
