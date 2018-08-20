package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import battle.data.BattleData;
   import battle.data.BattleTeamDescription;
   import battle.utils.Version;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlePlayerTeamIconDescription;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.battle.MultiBattleAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.battle.controller.BattleController;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.MultiBattleResult;
   import game.battle.gui.BattleGuiMediator;
   import game.battle.gui.BattleGuiViewBase;
   import game.screen.BattleScreen;
   import idv.cjcat.signals.Signal;
   
   public class BattleThread
   {
       
      
      protected var _presets:BattlePresets;
      
      private var _controller:BattleController;
      
      protected var _battleObjects:BattleMediatorObjects;
      
      protected var guiMediator:BattleGuiMediator;
      
      protected var battles:Vector.<BattleAsset>;
      
      protected var currentBattle:Battle;
      
      protected var nextBattleIndex:int;
      
      protected var result:MultiBattleResult;
      
      protected var version:int;
      
      protected var playerTeam:BattleTeamDescription;
      
      protected var replayProgress:Object;
      
      public const onComplete:Signal = new Signal(BattleThread);
      
      public const onRetreat:Signal = new Signal(BattleThread);
      
      public function BattleThread(param1:BattleConfig)
      {
         battles = new Vector.<BattleAsset>();
         result = new MultiBattleResult();
         super();
         _presets = createBattlePresets(param1);
         _controller = new BattleController(_presets);
         _battleObjects = new BattleMediatorObjects();
         _controller.signal_retreat.add(onRetreatListener);
         if(version == 0)
         {
            version = Version.last;
         }
         nextBattleIndex = 0;
      }
      
      public static function parseServerVersion(param1:*) : int
      {
         if(param1.serverVersion)
         {
            if(param1.serverVersion is String)
            {
               return int(param1.serverVersion.slice(param1.serverVersion.lastIndexOf(".")));
            }
            if(param1.serverVersion is int)
            {
               return param1.serverVersion;
            }
            return Version.last;
         }
         if(param1.clientVersion)
         {
            return param1.clientVersion;
         }
         return 108;
      }
      
      public function dispose() : void
      {
         _battleObjects.dispose();
         if(guiMediator)
         {
            guiMediator.dispose();
         }
         if(currentBattle)
         {
            currentBattle.dispose();
         }
         var _loc3_:int = 0;
         var _loc2_:* = battles;
         for each(var _loc1_ in battles)
         {
            _loc1_.dispose();
         }
      }
      
      public function get battleResult() : MultiBattleResult
      {
         return result;
      }
      
      public function get controller() : BattleController
      {
         return _controller;
      }
      
      public function get objects() : BattleMediatorObjects
      {
         return _battleObjects;
      }
      
      public function run() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function internalStart(param1:MultiBattleAsset) : void
      {
         controller.progressInfo.setup(battles.length,_presets.timeLimit);
         nextBattle();
      }
      
      public function fastCompleteBattle() : void
      {
         currentBattle.fastComplete();
      }
      
      public function unlink() : void
      {
         if(currentBattle)
         {
            currentBattle.unlink();
         }
      }
      
      protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         return new BattleAsset(param1,param2,_presets.config);
      }
      
      protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(false,true,false,param1);
      }
      
      protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.defaultAsset;
      }
      
      public function get isReplay() : Boolean
      {
         return replayProgress != null;
      }
      
      protected function parseTeams(param1:Object) : void
      {
         var _loc5_:int = 0;
         var _loc9_:* = undefined;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc13_:* = null;
         var _loc4_:int = param1.defenders.length;
         var _loc2_:uint = !!param1.seed?param1.seed:0;
         var _loc10_:BattlegroundAsset = createBattlegroundAsset();
         var _loc12_:Object = param1.attackers;
         result.parseAttackers(_loc12_);
         var _loc6_:BattleTeamDescription = BattleDataFactory.createTeam(_loc12_,param1.effects.attackers);
         var _loc11_:BattlePlayerTeamIconDescription = new BattlePlayerTeamIconDescription(_loc12_);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc9_ = param1.defenders[_loc5_];
            result.parseDefenders(_loc9_);
            _loc8_ = BattleDataFactory.createTeam(_loc9_,param1.effects.defenders);
            _loc7_ = new BattlePlayerTeamIconDescription(_loc9_);
            _loc3_ = createBattleData(_loc2_ ^ _loc5_,_loc6_,_loc8_);
            _loc13_ = createBattleAsset(_loc3_,_loc10_,_loc5_);
            _loc13_.attackerIconDescription = _loc11_;
            _loc13_.defenderIconDescription = _loc7_;
            battles.push(_loc13_);
            _loc5_++;
         }
         playerTeam = _loc6_;
      }
      
      protected function createBattleData(param1:uint, param2:BattleTeamDescription, param3:BattleTeamDescription) : BattleData
      {
         var _loc4_:BattleData = new BattleData();
         _loc4_.v = version;
         _loc4_.seed = param1;
         _loc4_.attackers = param2;
         _loc4_.defenders = param3;
         return _loc4_;
      }
      
      protected function nextBattle() : void
      {
         if(replayProgress && replayProgress.length > 0)
         {
            battles[nextBattleIndex].battleData.parseRawResult(replayProgress[nextBattleIndex]);
         }
         nextBattleIndex = Number(nextBattleIndex) + 1;
         var _loc1_:BattleAsset = battles[Number(nextBattleIndex)];
         controller.stop();
         controller.progressInfo.setWave(nextBattleIndex);
         enterLocation(_loc1_);
      }
      
      protected function enterLocation(param1:BattleAsset) : void
      {
         var _loc2_:* = null;
         if(currentBattle != null)
         {
            currentBattle.dispose();
            _loc2_ = Game.instance.screen.getBattleScreen();
         }
         else
         {
            _loc2_ = Game.instance.screen.showBattle(this);
            guiMediator = createBattleGuiMediator(_loc2_.gui,controller);
         }
         onBattleLogInitiated();
         currentBattle = new Battle(battles[nextBattleIndex - 1],_loc2_,controller,_presets);
         currentBattle.onComplete.addOnce(onBattleCompletedListener);
         currentBattle.signal_hasWinner.addOnce(handler_hasWinner);
         currentBattle.start();
      }
      
      protected function createBattleGuiMediator(param1:BattleGuiViewBase, param2:BattleController) : BattleGuiMediator
      {
         return new BattleGuiMediator(param1,param2);
      }
      
      protected function onAllComplete() : void
      {
         onComplete.dispatch(this);
      }
      
      protected function onBattleLogInitiated() : void
      {
         BattleLog.getLog();
         BattleLog.doLog = true;
      }
      
      protected function onBattleLogAvailable() : void
      {
         var _loc1_:String = BattleLog.getLog();
         result.addBattleLog(_loc1_);
      }
      
      protected function checkBattleResultForLastBattle(param1:Boolean) : Boolean
      {
         var _loc2_:* = false;
         if(param1)
         {
            _loc2_ = nextBattleIndex == battles.length;
         }
         else
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      protected function onRetreatListener() : void
      {
         Game.instance.screen.hideBattle();
         onRetreat.dispatch(this);
         currentBattle.dispose();
      }
      
      protected function onBattleCompletedListener(param1:Battle) : void
      {
         var _loc4_:Boolean = param1.hasWinner && param1.attackersWon;
         var _loc3_:Boolean = checkBattleResultForLastBattle(_loc4_);
         if(_loc3_)
         {
            param1.finishBattleSeries();
         }
         var _loc2_:BattleData = param1.battleData;
         result.addBattleProgress(_loc2_.serializeResult());
         _loc2_.clearInput();
         onBattleLogAvailable();
         result.battleStatistics.add(_loc2_);
         if(_loc3_)
         {
            if(param1.playerWon)
            {
               result.setVictory(_loc2_.getStars());
            }
            else
            {
               result.setDefeat(_loc2_.isOver());
            }
            onAllComplete();
         }
         else
         {
            nextBattle();
            param1.dispose();
         }
      }
      
      protected function handler_hasWinner(param1:Battle) : void
      {
         var _loc2_:Boolean = param1.playerWon;
         if(!_loc2_ || nextBattleIndex == battles.length)
         {
            _battleObjects.setHeroesHappy(_loc2_);
         }
      }
   }
}
