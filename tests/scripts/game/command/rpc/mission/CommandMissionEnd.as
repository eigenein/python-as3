package game.command.rpc.mission
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.InvalidBattleHandler;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.data.reward.RewardData;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.mission.PlayerMissionBattle;
   import game.view.gui.tutorial.Tutorial;
   
   public class CommandMissionEnd extends CostCommand
   {
       
      
      private var mission:PlayerMissionBattle;
      
      private var missionResult:MultiBattleResult;
      
      private var _battleResult:MissionBattleResultValueObject;
      
      public function CommandMissionEnd(param1:MultiBattleResult)
      {
         super();
         this.missionResult = param1;
         rpcRequest = new RpcRequest("missionEnd");
         mission = GameModel.instance.player.missions.currentMission;
         if(param1.victory)
         {
            _cost = mission.desc.cost;
         }
         rpcRequest.writeParam("id",mission.id);
         rpcRequest.writeParam("result",param1.result);
         rpcRequest.writeParam("progress",param1.progress);
      }
      
      public function get battleResult() : MissionBattleResultValueObject
      {
         return _battleResult;
      }
      
      public function get victory() : Boolean
      {
         return missionResult.victory;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(param1.clan.clan && _reward)
         {
            _reward.clanActivity = mission.desc.totalCost.stamina;
         }
         Game.instance.screen.hideBattle();
         super.clientExecute(param1);
         param1.missions.updateMissionProgress(mission,missionResult);
      }
      
      override protected function successHandler() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:* = null;
         if(result.body && !result.body.error)
         {
            _loc2_ = true;
            successMissionCompleteHandler();
            if(result.body.battleResult && result.body.battleResult.valid == false)
            {
               InvalidBattleHandler.mission(missionResult,result.body.battleResult.serverVersion);
            }
         }
         else
         {
            _loc1_ = result.body.error;
            if(_loc1_.indexOf("Invalid battle") != -1)
            {
               InvalidBattleHandler.missionWithMessage(missionResult,result.body.serverVersion);
            }
         }
         super.successHandler();
         if(_loc2_ && victory)
         {
            Tutorial.events.triggerEvent_missionComplete(mission.desc);
         }
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         Game.instance.screen.hideBattle();
         super.onRpc_errorHandler(param1);
      }
      
      protected function successMissionCompleteHandler() : void
      {
         var _loc3_:int = 0;
         _battleResult = BattleResultValueObjectFactory.createMissionResult(missionResult);
         _reward = new RewardData(result.body.reward);
         var _loc2_:Array = [];
         var _loc1_:int = mission.team.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_.push(mission.team[_loc3_].id);
            _loc3_++;
         }
         _battleResult.reward = _reward;
      }
   }
}
