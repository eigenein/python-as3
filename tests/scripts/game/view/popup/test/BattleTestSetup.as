package game.view.popup.test
{
   import battle.BattleConfig;
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.timeline.BucketTimeline;
   import battle.utils.Version;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.battle.RandomSequence;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.view.popup.test.grade.BattleTestGradeModel;
   import idv.cjcat.signals.Signal;
   
   public class BattleTestSetup
   {
      
      public static const BATTLES_PER_FRAME:int = 2;
       
      
      protected const random:RandomSequence = new RandomSequence();
      
      protected const availableHeroes:Vector.<uint> = Vector.<uint>(DataStorage.rule.battleConfig.heroes);
      
      protected const availableTitans:Vector.<int> = UnitUtils.titanVectorToIntVector(DataStorage.hero.getPlayableTitans() as Vector.<TitanDescription>);
      
      private var currentBattle:BattleTestEntry;
      
      private var battleHeroes:Vector.<BattleHeroDescription>;
      
      private var factory:BattleDataFactory;
      
      private var attackerHeroes:Vector.<UnitDescription>;
      
      private var defenderHeroes:Vector.<UnitDescription>;
      
      private var _fillWithRandomLeft:Boolean = false;
      
      private var _fillWithRandomRight:Boolean = false;
      
      private var _evenFlipAttackersTeam:Boolean = false;
      
      private var _collectStatisticsRight:Boolean = false;
      
      private var scriptHash:uint;
      
      public const signal_codeChanged:Signal = new Signal();
      
      public const statistics:BattleStatistics = new BattleStatistics(lastHeroToInclude);
      
      public const statisticsA:BattleStatistics = new BattleStatistics(lastHeroToInclude);
      
      public const statisticsD:BattleStatistics = new BattleStatistics(lastHeroToInclude);
      
      public const onCountUpdated:Signal = new Signal();
      
      public var startedCount:int;
      
      public var failedCount:int;
      
      public var timeIsUpCount:int;
      
      public var succeededCount:int;
      
      public var attackersWinCount:int;
      
      public function BattleTestSetup()
      {
         battleHeroes = new Vector.<BattleHeroDescription>();
         factory = new BattleDataFactory();
         super();
         battleHeroes = new Vector.<BattleHeroDescription>();
         factory = new BattleDataFactory();
         AssetStorage.battle.requestAllCode();
      }
      
      public function get isReady() : Boolean
      {
         return AssetStorage.instance.globalLoader.tryComplete();
      }
      
      protected function getRandomHeroId(param1:BattleTestGradeModel) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = param1.stars.value;
         do
         {
            _loc3_ = availableHeroes[int(Math.random() * availableHeroes.length)];
            _loc2_ = DataStorage.hero.getHeroById(_loc3_).startingStar.star.id;
         }
         while(_loc2_ > _loc4_);
         
         return _loc3_;
      }
      
      protected function get randomHeroId() : int
      {
         return availableHeroes[int(Math.random() * availableHeroes.length)];
      }
      
      protected function get randomTitanId() : int
      {
         return availableTitans[int(Math.random() * availableTitans.length)];
      }
      
      public function get scriptsHashChanged() : Boolean
      {
         return scriptHash != getScriptHash();
      }
      
      public function set fillEmptySlotsLeft(param1:Boolean) : void
      {
         _fillWithRandomLeft = param1;
      }
      
      public function set fillEmptySlotsRight(param1:Boolean) : void
      {
         _fillWithRandomRight = param1;
      }
      
      public function set collectStatisticsRight(param1:Boolean) : void
      {
         _collectStatisticsRight = param1;
      }
      
      public function set evenFlipAttackersTeam(param1:Boolean) : void
      {
         _evenFlipAttackersTeam = param1;
      }
      
      public function setupTeams(param1:Vector.<UnitDescription>, param2:Vector.<UnitDescription>) : void
      {
         this.attackerHeroes = param1;
         this.defenderHeroes = param2;
      }
      
      public function clear() : void
      {
         startedCount = 0;
         failedCount = 0;
         succeededCount = 0;
         attackersWinCount = 0;
         onCountUpdated.dispatch();
      }
      
      public function run(param1:BattleTestGradeModel, param2:BattleTestGradeModel, param3:BattleConfig) : void
      {
         var _loc4_:int = 0;
         var _loc8_:* = false;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         BattleLog.doLog = false;
         _loc4_ = 0;
         while(_loc4_ < 2)
         {
            BattleLog.clear();
            _loc8_ = param3.defaultHeroSpeed < 100;
            _loc5_ = createBattleData(param1,param2,_loc8_);
            if(!_loc5_)
            {
               return;
            }
            random.seed = _loc5_.seed;
            _loc7_ = AssetStorage.battle.getBattleEngine();
            _loc7_.load(_loc5_,!!param3?param3:DataStorage.battleConfig.balancer,AssetStorage.battle.effectFactory,random.generateInt);
            _loc7_.doNotInterruptTimeAdvancement = true;
            startedCount = Number(startedCount) + 1;
            _loc6_ = BattleLog;
            _loc7_.advanceToEnd();
            _loc7_.finishBattleSeries();
            if(_loc5_.isOver())
            {
               succeededCount = Number(succeededCount) + 1;
               if(_loc5_.getStars() > 0)
               {
                  attackersWinCount = Number(attackersWinCount) + 1;
               }
            }
            else
            {
               failedCount = Number(failedCount) + 1;
            }
            statistics.collect(_loc5_,true,_collectStatisticsRight);
            statistics.collectDuration((_loc7_.timeline as BucketTimeline).frontTime);
            statisticsA.collect(_loc5_,true,false);
            statisticsD.collect(_loc5_,false,true);
            _loc4_++;
         }
         onCountUpdated.dispatch();
      }
      
      public function refreshCode() : void
      {
         scriptHash = getScriptHash();
         AssetStorage.battle.clearLoadedCode();
         AssetStorage.battle.requestAllCode();
      }
      
      public function createBattleData(param1:BattleTestGradeModel, param2:BattleTestGradeModel, param3:Boolean) : BattleData
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function fillTeamIds(param1:Vector.<UnitDescription>, param2:Boolean, param3:Boolean, param4:BattleTestGradeModel) : Vector.<int>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_invalidSetup(param1:String) : void
      {
         factory.invalidMessage = param1;
      }
      
      public function getAttackersDefendersReport() : String
      {
         var _loc3_:* = 0;
         if(statistics.isEmpty)
         {
            return " - ";
         }
         var _loc4_:int = statistics.minUnitId;
         var _loc1_:int = statistics.maxUnitId;
         var _loc2_:String = "";
         _loc3_ = _loc4_;
         while(_loc3_ <= _loc1_)
         {
            _loc2_ = _loc2_ + (statistics.getHeroWinrate(_loc3_) + "\t" + statisticsA.getHeroWinrate(_loc3_) + "\t" + statisticsD.getHeroWinrate(_loc3_));
            if(_loc3_ < _loc1_)
            {
               _loc2_ = _loc2_ + "\n";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function get lastHeroToInclude() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = availableHeroes;
         for each(var _loc2_ in availableHeroes)
         {
            if(_loc2_ > _loc1_)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      protected function getScriptHash() : uint
      {
         return AssetStorage.battle.getEncodedScriptByIdent("skills.sc").hash;
      }
      
      private function battleTraceMethod(... rest) : void
      {
         if(currentBattle)
         {
            currentBattle.log = currentBattle.log + (rest + "\n");
         }
         else
         {
            trace(rest);
         }
      }
   }
}
