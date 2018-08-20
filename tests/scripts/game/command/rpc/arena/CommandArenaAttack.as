package game.command.rpc.arena
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.view.gui.tutorial.Tutorial;
   import idv.cjcat.signals.Signal;
   
   public class CommandArenaAttack extends RPCCommandBase
   {
       
      
      public const signal_outOfRetargetDelta:Signal = new Signal();
      
      private var _battleResult:ArenaBattleResultValueObject;
      
      public function CommandArenaAttack(param1:PlayerArenaEnemy, param2:Vector.<UnitDescription>)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get battleResult() : ArenaBattleResultValueObject
      {
         return _battleResult;
      }
      
      public function get battle() : Object
      {
         if(result.body && result.body.battles && result.body.battles.length > 0)
         {
            return result.body.battles[0];
         }
         return null;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:* = null;
         if(result.body.error)
         {
            if(result.body.error == "outOfRetargetDelta")
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
         if(GameModel.instance.player.arena.rankingIsLocked)
         {
            _battleResult.oldPlace = 0;
         }
         else
         {
            _battleResult.oldPlace = param1.arena.getPlace();
         }
         super.clientExecute(param1);
         param1.arena.setEnemies(PlayerArenaEnemy.parseRawEnemies(result.body.enemies));
         param1.refillable.spend(param1.refillable.getById(DataStorage.arena.arena.refillableBattleId),1);
         param1.refillable.spend(param1.refillable.getById(DataStorage.arena.arena.refillableCooldownId),1);
         Tutorial.events.triggerEvent_arenaStart();
         var _loc3_:* = result.body.state;
         param1.arena.setRewardFlag(_loc3_.rewardFlag);
         param1.arena.setBattles(_loc3_.battles,_loc3_.wins);
         param1.arena.setPlace(_loc3_.arenaPlace);
         if(GameModel.instance.player.arena.rankingIsLocked)
         {
            _battleResult.newPlace = 0;
         }
         if(result.body.reward)
         {
            _loc2_ = new RewardData(result.body.reward);
            param1.takeReward(_loc2_);
         }
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         super.onRpc_errorHandler(param1);
      }
      
      override protected function successHandler() : void
      {
         if(!result.body.error)
         {
            _battleResult = BattleResultValueObjectFactory.parseArenaCommandResult(result.body);
         }
         super.successHandler();
      }
   }
}
