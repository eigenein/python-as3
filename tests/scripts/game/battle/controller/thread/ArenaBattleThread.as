package game.battle.controller.thread
{
   import battle.BattleConfig;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.instant.ArenaInstantReplay;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   import game.model.GameModel;
   import game.model.user.sharedobject.RefreshMetadata;
   import game.view.popup.PromptPopup;
   
   public class ArenaBattleThread extends BattleThread
   {
      
      public static var INVALIDATE_NEXT_BATTLE_TYPE:int = 0;
      
      public static var INVALIDATE_NEXT_BATTLE_TYPE_NO:int = 0;
      
      public static var INVALIDATE_NEXT_BATTLE_TYPE_HIGH:int = 1;
      
      public static var INVALIDATE_NEXT_BATTLE_TYPE_LOW:int = 2;
      
      public static var INVALIDATE_NEXT_BATTLE_TYPE_SAME:int = 3;
       
      
      protected var serverVictory:Boolean;
      
      protected var attackerWinCount:int;
      
      protected var isDefensiveBattle:Boolean;
      
      protected var rawBattleInfo:Object;
      
      protected var _commandResult:BattleResultValueObject;
      
      public function ArenaBattleThread(param1:Object, param2:Boolean)
      {
         super(DataStorage.battleConfig.pvp);
         this.rawBattleInfo = param1;
         this.isDefensiveBattle = param2;
         if(param1.result)
         {
            serverVictory = param1.result.win != param2;
            version = parseServerVersion(param1.result);
         }
         parseTeams(param1);
         var _loc5_:int = 0;
         var _loc4_:* = battles;
         for each(var _loc3_ in battles)
         {
            _loc3_.playerIsAttacker = !param2;
         }
         attackerWinCount = 0;
      }
      
      public static function checkValidness(param1:Boolean, param2:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param2 && param2.result && param2.result.win !== undefined)
         {
            _loc3_ = param2.result.win;
            return param1 == _loc3_;
         }
         return true;
      }
      
      public function get commandResult() : BattleResultValueObject
      {
         return _commandResult;
      }
      
      public function set commandResult(param1:BattleResultValueObject) : void
      {
         this._commandResult = param1;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(true,false,true,param1);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.arenaRule.arenaBattlegroundAsset);
      }
      
      override protected function nextBattle() : void
      {
         var _loc1_:* = null;
         if(nextBattleIndex == 0)
         {
            _loc1_ = new ArenaInstantReplay(rawBattleInfo,null);
            _loc1_.signal_hasInstantReplayResult.add(handler_validReplay);
            _loc1_.signal_invalidReplay.add(handler_invalidReplay);
            _loc1_.start();
         }
         else
         {
            super.nextBattle();
         }
      }
      
      override protected function checkBattleResultForLastBattle(param1:Boolean) : Boolean
      {
         if(param1)
         {
            attackerWinCount = Number(attackerWinCount) + 1;
         }
         var _loc2_:int = nextBattleIndex - attackerWinCount;
         var _loc4_:int = battles.length / 2;
         var _loc3_:Boolean = attackerWinCount > _loc4_ || _loc2_ > _loc4_;
         if(!_loc3_ && nextBattleIndex == battles.length)
         {
            trace("ArenaBattleThread:onWaveCompletedListener DRAW");
            _loc3_ = true;
         }
         if(_loc3_ && _commandResult)
         {
            if(checkValidness(param1,_commandResult.source) == false)
            {
               InvalidBattleHandler.arena(result,_commandResult.source.result);
            }
         }
         return _loc3_;
      }
      
      protected function continueAfterRefresh(param1:ArenaBattleResultValueObject) : void
      {
         if(param1 != null)
         {
            GameModel.instance.player.sharedObjectStorage.refreshMeta = RefreshMetadata.arena(param1.replayId,param1.oldPlace,param1.newPlace);
         }
      }
      
      protected function handler_validReplay(param1:ArenaInstantReplay) : void
      {
         if(ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE != ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE_NO)
         {
            handler_invalidReplay(param1);
            ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE = ArenaBattleThread.INVALIDATE_NEXT_BATTLE_TYPE_NO;
            return;
         }
         super.nextBattle();
      }
      
      protected function handler_invalidReplay(param1:ArenaInstantReplay) : void
      {
         if(commandResult)
         {
            commandResult.result = param1.result;
         }
         var _loc2_:Boolean = param1.incorrectVersionHigh;
         var _loc3_:Boolean = param1.incorrectVersionLow;
         if(INVALIDATE_NEXT_BATTLE_TYPE == INVALIDATE_NEXT_BATTLE_TYPE_HIGH)
         {
            _loc2_ = true;
            _loc3_ = false;
         }
         else if(INVALIDATE_NEXT_BATTLE_TYPE == INVALIDATE_NEXT_BATTLE_TYPE_LOW)
         {
            _loc2_ = false;
            _loc3_ = true;
         }
         else if(INVALIDATE_NEXT_BATTLE_TYPE == INVALIDATE_NEXT_BATTLE_TYPE_SAME)
         {
            _loc2_ = false;
            _loc3_ = false;
         }
         var _loc4_:PromptPopup = InvalidBattleHandler.beforeReplay(commandResult as ArenaBattleResultValueObject,_loc2_,_loc3_);
         if(_loc4_ != null)
         {
            _loc4_.signal_cancel.add(handler_doReplayInvalid);
            _loc4_.signal_confirm.add(handler_cancelInvalid);
         }
         else
         {
            continueAfterRefresh(commandResult as ArenaBattleResultValueObject);
            handler_cancelInvalid(null);
         }
      }
      
      protected function handler_doReplayInvalid(param1:PromptPopup) : void
      {
         super.nextBattle();
      }
      
      protected function handler_cancelInvalid(param1:PromptPopup) : void
      {
         Game.instance.screen.hideBattle();
         dispose();
      }
   }
}
