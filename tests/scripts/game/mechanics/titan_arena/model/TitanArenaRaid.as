package game.mechanics.titan_arena.model
{
   import battle.data.BattleData;
   import game.battle.controller.instant.ArenaInstantReplay;
   import game.battle.controller.instant.BattleInstantPlay;
   import game.battle.controller.thread.BattlePresets;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndRaid;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaStartRaid;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import org.osflash.signals.Signal;
   
   public class TitanArenaRaid
   {
       
      
      private var player:Player;
      
      private var rawBattles:Vector.<Object>;
      
      private var presets:BattlePresets;
      
      private var _currentBattleIndex:int;
      
      private var attackersTeam:Vector.<UnitDescription>;
      
      private var _enemies:Vector.<PlayerTitanArenaEnemy>;
      
      private var battles:Vector.<BattleData>;
      
      private var _results:Vector.<TitanArenaRaidBattleItem>;
      
      private var currentBattle:Boolean;
      
      private var rawBattleResults:Object;
      
      public const signal_nextBattle:Signal = new Signal(TitanArenaRaid);
      
      public const signal_raidResult:Signal = new Signal(TitanArenaRaid);
      
      public const signal_invalidBattle:Signal = new Signal(TitanArenaRaid);
      
      public const signal_stop:Signal = new Signal(TitanArenaRaid);
      
      public function TitanArenaRaid(param1:Player, param2:Vector.<UnitDescription>)
      {
         rawBattles = new Vector.<Object>();
         presets = new BattlePresets(false,false,true,DataStorage.battleConfig.titanClanPvp,false);
         battles = new Vector.<BattleData>();
         rawBattleResults = {};
         super();
         this.player = param1;
         this.attackersTeam = param2;
         currentBattle = false;
      }
      
      public function get currentBattleIndex() : int
      {
         return _currentBattleIndex;
      }
      
      public function get progressCurrentBattle() : Number
      {
         return 0;
      }
      
      public function get progressGlobal() : Number
      {
         return 0;
      }
      
      public function get lastBattleEnemy() : PlayerTitanArenaEnemy
      {
         if(_currentBattleIndex > 0)
         {
            return _enemies[_currentBattleIndex - 1];
         }
         return null;
      }
      
      public function get currentBattleEnemy() : PlayerTitanArenaEnemy
      {
         if(_currentBattleIndex >= 0)
         {
            return _enemies[_currentBattleIndex];
         }
         return null;
      }
      
      public function get results() : Vector.<TitanArenaRaidBattleItem>
      {
         return _results;
      }
      
      public function start() : void
      {
         _enemies = player.titanArenaData.rivals.concat();
         var _loc1_:CommandTitanArenaStartRaid = GameModel.instance.actionManager.titanArena.titanArenaStartRaid(attackersTeam);
         _loc1_.signal_complete.add(handler_commandStart);
      }
      
      public function stop() : void
      {
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(!currentBattle)
         {
         }
      }
      
      protected function handler_commandStart(param1:CommandTitanArenaStartRaid) : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:Object = param1.result.body;
         var _loc3_:Object = _loc4_.attackers;
         rawBattles = new Vector.<Object>();
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_.rivals;
         for(var _loc2_ in _loc4_.rivals)
         {
            _loc6_ = {};
            _loc5_ = _loc4_.rivals[_loc2_];
            _loc6_.attackers = _loc3_;
            _loc6_.defenders = [_loc5_.team];
            _loc6_.effects = [];
            _loc6_.reward = {};
            _loc6_.seed = _loc5_.seed;
            _loc6_.startTime = 0;
            _loc6_.type = 0;
            _loc6_.typeId = 0;
            _loc6_.userId = _loc2_;
            rawBattles.push(_loc6_);
         }
         _currentBattleIndex = -1;
         currentBattle = true;
         nextBattle();
      }
      
      protected function nextBattle() : void
      {
         if(_currentBattleIndex >= rawBattles.length - 1)
         {
            complete();
            return;
         }
         _currentBattleIndex = Number(_currentBattleIndex) + 1;
         var _loc1_:Object = rawBattles[_currentBattleIndex];
         var _loc2_:BattleInstantPlay = new BattleInstantPlay(_loc1_,presets);
         _loc2_.signal_hasResult.add(handler_replayResult);
         signal_nextBattle.dispatch(this);
         _loc2_.start();
      }
      
      protected function complete() : void
      {
         var _loc1_:CommandTitanArenaEndRaid = GameModel.instance.actionManager.titanArena.titanArenaEndRaid(rawBattleResults);
         _loc1_.onClientExecute(handler_complete);
      }
      
      protected function getPlayerDefenders() : Vector.<UnitDescription>
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc1_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
         if(_loc1_)
         {
            _loc2_ = _loc1_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_.push(_loc1_[_loc4_].unit);
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      protected function handler_replayResult(param1:BattleInstantPlay) : void
      {
         trace("raid battle computation finished. Time consumed: " + param1.computeDuration);
         rawBattleResults[rawBattles[currentBattleIndex].userId] = {
            "progress":param1.result.progress,
            "result":param1.result.result
         };
         nextBattle();
      }
      
      protected function handler_invalidReplay(param1:ArenaInstantReplay) : void
      {
      }
      
      protected function handler_complete(param1:CommandTitanArenaEndRaid) : void
      {
         player.titanArenaData.internal_updateOnEndRaid(param1);
         if(param1.hasRaidResult)
         {
            _results = param1.battles;
            signal_raidResult.dispatch(this);
         }
         else if(param1.invalidBattle)
         {
            signal_invalidBattle.dispatch(this);
         }
      }
   }
}
