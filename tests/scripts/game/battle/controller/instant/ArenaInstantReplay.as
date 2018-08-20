package game.battle.controller.instant
{
   import battle.BattleConfig;
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.data.BattleData;
   import battle.proxy.ISceneProxy;
   import battle.utils.Version;
   import game.assets.battle.BattleCodeAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.battle.RandomSequence;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.controller.thread.BattleThread;
   import game.data.storage.DataStorage;
   import org.osflash.signals.Signal;
   
   public class ArenaInstantReplay
   {
       
      
      private var _started:Boolean = false;
      
      private var _result:MultiBattleResult;
      
      private var _data;
      
      private var replayProgress:Object;
      
      private var rawBattle:Object;
      
      private var battleData:BattleData;
      
      public const signal_invalidReplay:Signal = new Signal(ArenaInstantReplay);
      
      public const signal_hasInstantReplayResult:Signal = new Signal(ArenaInstantReplay);
      
      public var config:BattleConfig;
      
      public var sceneProxy:ISceneProxy;
      
      public function ArenaInstantReplay(param1:Object, param2:*)
      {
         config = DataStorage.battleConfig.pvp;
         super();
         this.rawBattle = param1;
         this._data = param2;
         if(!(param1 is BattleData) && param1.progress != null && param1.progress.length > 0)
         {
            this.replayProgress = param1.progress[0];
         }
      }
      
      public function get result() : MultiBattleResult
      {
         return _result;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function get incorrectVersionHigh() : Boolean
      {
         return battleData.v > Version.last;
      }
      
      public function get incorrectVersionLow() : Boolean
      {
         return battleData.v < Version.last;
      }
      
      public function start() : void
      {
         if(!_started)
         {
            instantReplay(rawBattle);
            _started = true;
         }
      }
      
      private function instantReplay(param1:Object) : void
      {
         if(param1 is BattleData)
         {
            battleData = param1 as BattleData;
         }
         else
         {
            battleData = new BattleData();
            battleData.v = BattleThread.parseServerVersion(param1.result);
            battleData.seed = !!param1.seed?param1.seed:0;
            battleData.attackers = BattleDataFactory.createTeam(param1.attackers,param1.effects.attackers);
            battleData.defenders = BattleDataFactory.createTeam(param1.defenders[0],param1.effects.defenders);
            if(replayProgress)
            {
               battleData.parseRawResult(replayProgress);
            }
         }
         var _loc2_:BattleCodeAsset = new BattleCodeAsset(battleData);
         AssetStorage.battle.requestAssetWithPreloader(_loc2_,handler_battleCodeReady);
      }
      
      private function createResult(param1:BattleData) : void
      {
         _result = new MultiBattleResult();
         _result.parseAttackers(rawBattle.attackers);
         _result.parseDefenders(rawBattle.defenders[0]);
         _result.addBattleProgress(param1.serializeResult());
         _result.addBattleLog(BattleLog.getLog());
         _result.battleStatistics.add(param1);
         if(param1.getStars() > 0)
         {
            _result.setVictory(param1.getStars());
         }
         else
         {
            _result.setDefeat(param1.isOver());
         }
      }
      
      private function handler_battleCodeReady(param1:BattleCodeAsset) : void
      {
         var _loc3_:BattleData = param1.battleData;
         _loc3_.attackers.initialize(AssetStorage.battle.skillFactory);
         _loc3_.defenders.initialize(AssetStorage.battle.skillFactory);
         var _loc2_:RandomSequence = new RandomSequence(_loc3_.seed);
         var _loc4_:BattleEngine = new BattleEngine(sceneProxy);
         _loc4_.load(_loc3_,config,AssetStorage.battle.effectFactory,_loc2_.generateInt);
         _loc4_.doNotInterruptTimeAdvancement = true;
         _loc4_.replay();
         _loc4_.finishBattleSeries();
         BattleEngine.purge();
         var _loc5_:Boolean = _loc3_.isOver() && _loc3_.getStars() > 0;
         if(ArenaBattleThread.checkValidness(_loc5_,rawBattle))
         {
            createResult(_loc3_);
            signal_hasInstantReplayResult.dispatch(this);
         }
         else
         {
            createResult(_loc3_);
            signal_invalidReplay.dispatch(this);
         }
      }
   }
}
