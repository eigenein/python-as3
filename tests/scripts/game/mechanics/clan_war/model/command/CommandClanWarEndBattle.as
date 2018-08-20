package game.mechanics.clan_war.model.command
{
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.InvalidBattleHandler;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.mechanics.clan_war.mediator.ClanWarBattleResultValueObject;
   import game.model.user.Player;
   
   public class CommandClanWarEndBattle extends RPCCommandBase
   {
       
      
      private var _battleResult:MultiBattleResult;
      
      private var _battleResultValueObject:ClanWarBattleResultValueObject;
      
      private var _completedWithRetreat:Boolean;
      
      public function CommandClanWarEndBattle(param1:MultiBattleResult, param2:Boolean = false)
      {
         super();
         this._battleResult = param1;
         this._completedWithRetreat = param2;
         rpcRequest = new RpcRequest("clanWarEndBattle");
         rpcRequest.writeParam("result",param1.result);
         rpcRequest.writeParam("progress",param1.progress);
         _battleResultValueObject = BattleResultValueObjectFactory.createClanWarBattleResult(param1);
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
      
      public function get completedWithRetreat() : Boolean
      {
         return _completedWithRetreat;
      }
      
      public function get fortificationVictoryPoints() : int
      {
         return result.body.fortificationVictoryPoints;
      }
      
      public function get slotVictoryPoints() : int
      {
         return result.body.slotVictoryPoints;
      }
      
      public function get ourClanPoints() : int
      {
         return result.body.ourClanPoints;
      }
      
      public function get enemyClanPoints() : int
      {
         return result.body.enemyClanPoints;
      }
      
      public function get slotPointsFarmed() : int
      {
         return result.body.slot.pointsFarmed;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(result.body && result.body.error)
         {
            InvalidBattleHandler.clanWar(_battleResult,result.body);
         }
      }
   }
}
