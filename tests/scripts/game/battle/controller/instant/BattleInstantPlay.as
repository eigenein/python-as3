package game.battle.controller.instant
{
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.data.BattleData;
   import battle.proxy.ISceneProxy;
   import battle.utils.Version;
   import flash.utils.getTimer;
   import game.assets.battle.BattleCodeAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.battle.RandomSequence;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.BattlePresets;
   import org.osflash.signals.Signal;
   
   public class BattleInstantPlay
   {
       
      
      private var _computeDuration:Number;
      
      private var _started:Boolean = false;
      
      private var _result:MultiBattleResult;
      
      private var _data;
      
      private var presets:BattlePresets;
      
      private var rawBattle:Object;
      
      private var battleData:BattleData;
      
      public const signal_hasResult:Signal = new Signal(BattleInstantPlay);
      
      public var sceneProxy:ISceneProxy;
      
      public function BattleInstantPlay(param1:Object, param2:BattlePresets, param3:* = null)
      {
         super();
         this.rawBattle = param1;
         this.presets = param2;
         this._data = param3;
      }
      
      public function get result() : MultiBattleResult
      {
         return _result;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function get computeDuration() : Number
      {
         return _computeDuration;
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
            battleData.v = Version.last;
            battleData.seed = !!param1.seed?param1.seed:0;
            battleData.attackers = BattleDataFactory.createTeam(param1.attackers,param1.effects.attackers);
            battleData.defenders = BattleDataFactory.createTeam(param1.defenders[0],param1.effects.defenders);
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
         var _loc2_:String = BattleLog.getLog();
         _result.addBattleLog(_loc2_);
         _result.battleStatistics.add(param1);
         var _loc3_:int = param1.getStars();
         if(_loc3_ > 0)
         {
            _result.setVictory(_loc3_);
         }
         else
         {
            _result.setDefeat(param1.isOver());
         }
      }
      
      private function handler_battleCodeReady(param1:BattleCodeAsset) : void
      {
         var _loc5_:Number = getTimer();
         var _loc3_:BattleData = param1.battleData;
         _loc3_.attackers.initialize(AssetStorage.battle.skillFactory);
         _loc3_.defenders.initialize(AssetStorage.battle.skillFactory);
         if(!presets.isReplay)
         {
            _loc3_.attackers.setUserInput(!presets.autoOnStart);
         }
         var _loc2_:RandomSequence = new RandomSequence(_loc3_.seed);
         BattleLog.doLog = true;
         var _loc4_:BattleEngine = new BattleEngine(sceneProxy);
         _loc4_.load(_loc3_,presets.config,AssetStorage.battle.effectFactory,_loc2_.generateInt);
         _loc4_.doNotInterruptTimeAdvancement = true;
         _loc4_.replay();
         _loc4_.finishBattleSeries();
         BattleEngine.purge();
         if(!(rawBattle is BattleData))
         {
            createResult(_loc3_);
         }
         var _loc6_:Number = getTimer();
         _computeDuration = _loc6_ - _loc5_;
         signal_hasResult.dispatch(this);
         signal_hasResult.removeAll();
      }
   }
}
