package game.mechanics.dungeon.model
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.DungeonHeroBattleThread;
   import game.battle.controller.thread.TitanBattleThread;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.dungeon.mediator.DungeonBattleFloorPopupMediator;
   import game.mechanics.dungeon.mediator.DungeonBattleVictoryPopupMediator;
   import game.mechanics.dungeon.mediator.DungeonRewardPopupMediator;
   import game.mechanics.dungeon.model.command.CommandDungeonEndBattle;
   import game.mechanics.dungeon.model.command.CommandDungeonGetInfo;
   import game.mechanics.dungeon.model.command.CommandDungeonSaveProgress;
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.mechanics.dungeon.model.state.DungeonFloorElement;
   import game.mechanics.dungeon.model.state.DungeonFloorSaveState;
   import game.mechanics.dungeon.storage.DungeonFloorDescription;
   import game.mechanics.dungeon.storage.DungeonFloorType;
   import game.mechanics.dungeon.storage.SaveInteractionType;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.mediator.gui.popup.tower.TowerTeamGatherHeroValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.UnitEntry;
   import game.model.user.tower.TowerHeroState;
   import game.screen.BattleScreen;
   import game.view.popup.ClipBasedPopup;
   import idv.cjcat.signals.Signal;
   
   public class PlayerDungeonData
   {
      
      public static const MIN_TITANS_AMOUNT_TO_START:int = 2;
       
      
      private var player:Player;
      
      public const teamState_heroes:PlayerDungeonHeroTeamState = new PlayerDungeonHeroTeamState();
      
      public const teamState_titans:PlayerDungeonHeroTeamState = new PlayerDungeonHeroTeamState();
      
      public const signal_saveLeverIsAvailable:Signal = new Signal();
      
      public const signal_batlleEnd:Signal = new Signal();
      
      public const signal_init:Signal = new Signal();
      
      private const _floor:IntPropertyWriteable = new IntPropertyWriteable();
      
      public const floor:IntProperty = _floor;
      
      private var _currentFloor:PlayerDungeonBattleFloor;
      
      private var _maxFloorReached:IntPropertyWriteable;
      
      private var _respawnFloor:IntPropertyWriteable;
      
      private var _currentFloor_canSkip:Boolean;
      
      public function PlayerDungeonData(param1:Player)
      {
         _maxFloorReached = new IntPropertyWriteable();
         _respawnFloor = new IntPropertyWriteable();
         super();
         this.player = param1;
      }
      
      public static function __print(param1:String, ... rest) : void
      {
      }
      
      public function get initialized() : Boolean
      {
         return _floor.value > 0;
      }
      
      public function get currentFloor() : PlayerDungeonBattleFloor
      {
         return _currentFloor;
      }
      
      public function get previouseFloorDescription() : DungeonFloorDescription
      {
         return DataStorage.dungeon.getDescriptionByFloorNumber(_floor.value - 1);
      }
      
      public function get maxFloorReached() : IntProperty
      {
         return _maxFloorReached;
      }
      
      public function get respawnFloor() : IntProperty
      {
         return _respawnFloor;
      }
      
      public function get currentFloor_canSkip() : Boolean
      {
         return _currentFloor_canSkip;
      }
      
      protected function get readyToSave() : Boolean
      {
         return floor.value == findNextNotCapturedSaveLeverFloor();
      }
      
      public function initRequest() : void
      {
         __print("getInfoRequest");
         var _loc1_:CommandDungeonGetInfo = GameModel.instance.actionManager.dungeon.dungeonGetInfo();
         _loc1_.onClientExecute(handler_getInfoRequest);
      }
      
      public function reset(param1:Object) : void
      {
         __print("reset");
         parseNewState(param1);
      }
      
      public function createHeroList(param1:TeamGatherPopupMediator, param2:Player) : Vector.<TeamGatherPopupHeroValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function createTitanList(param1:TeamGatherPopupMediator, param2:PlayerDungeonBattleEnemy, param3:Player) : Vector.<TeamGatherPopupHeroValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function action_saveProgress() : void
      {
         var _loc1_:CommandDungeonSaveProgress = GameModel.instance.actionManager.dungeon.dungeonSaveProgress();
         _loc1_.signal_complete.add(handler_commandComplete_saveProgress);
      }
      
      public function action_openFloorPopup(param1:PopupStashEventParams) : void
      {
         var _loc2_:* = null;
         if(currentFloor is PlayerDungeonBattleFloor)
         {
            _loc2_ = new DungeonBattleFloorPopupMediator(player,currentFloor as PlayerDungeonBattleFloor);
            _loc2_.open(param1);
         }
      }
      
      public function action_startBattle(param1:Vector.<UnitEntry>, param2:*) : void
      {
         var _loc3_:* = null;
         if(currentFloor.type == DungeonFloorType.BATTLE_HERO)
         {
            _loc3_ = new DungeonHeroBattleThread(param2);
         }
         else
         {
            _loc3_ = new TitanBattleThread(param2);
         }
         _loc3_.onComplete.addOnce(handler_battleComplete);
         _loc3_.onRetreat.addOnce(handler_battleRetreat);
         _loc3_.run();
      }
      
      public function action_instantBattle(param1:MultiBattleResult) : CommandDungeonEndBattle
      {
         __print("battleInstantComplete");
         var _loc2_:CommandDungeonEndBattle = GameModel.instance.actionManager.dungeon.dungeonEndBattle(param1);
         _loc2_.onClientExecute(handler_battleEndCommandExecuted);
         return _loc2_;
      }
      
      public function action_parseNewState(param1:Object) : void
      {
         parseNewState(param1);
      }
      
      public function getNextNotCapturedSaveEntrance() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function findNextNotCapturedSaveLeverFloor() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function findLastCapturedSaveLeverFloor() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getActiveHeroes(param1:Player) : Vector.<UnitDescription>
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:Vector.<UnitDescription> = param1.heroes.teamData.getByDungeonElement(null);
         if(_loc3_ == null)
         {
            _loc3_ = new Vector.<UnitDescription>();
         }
         if(_loc3_.length == 0)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param1.heroes.getList();
            for each(var _loc4_ in param1.heroes.getList())
            {
               _loc2_ = _loc4_.hero;
               _loc5_ = teamState_heroes.getHeroState(_loc2_.id);
               if(_loc5_ == null || _loc5_.isDead == false)
               {
                  _loc3_.push(_loc2_);
                  if(_loc3_.length <= 5)
                  {
                     continue;
                  }
                  break;
               }
            }
         }
         return _loc3_;
      }
      
      public function getActiveTitans(param1:Player) : Vector.<UnitDescription>
      {
         var _loc6_:int = 0;
         _loc6_ = 3;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         addTitansFromTeamData(_loc5_,DungeonFloorElement.NEUTRAL);
         addTitansFromTeamData(_loc5_,DungeonFloorElement.EARTH);
         addTitansFromTeamData(_loc5_,DungeonFloorElement.FIRE);
         addTitansFromTeamData(_loc5_,DungeonFloorElement.WATER);
         _loc5_.sort(sort_titanByPower);
         if(_loc5_.length == 0)
         {
            var _loc8_:int = 0;
            var _loc7_:* = param1.titans.getList();
            for each(var _loc4_ in param1.titans.getList())
            {
               _loc2_ = _loc4_.titan;
               _loc3_ = teamState_titans.getHeroState(_loc2_.id);
               if(_loc3_ == null || _loc3_.isDead == false)
               {
                  _loc5_.push(_loc2_);
                  if(_loc5_.length <= 3)
                  {
                     continue;
                  }
                  break;
               }
            }
         }
         if(_loc5_.length > 3)
         {
            _loc5_.length = 3;
         }
         return _loc5_;
      }
      
      protected function init(param1:*) : void
      {
         if(param1)
         {
            __print("init");
            parseNewState(param1);
         }
         else
         {
            __print("init notUnlockedYet");
         }
      }
      
      protected function parseNewState(param1:*) : void
      {
         var _loc2_:* = !initialized;
         teamState_heroes.parse(param1.states.heroes);
         teamState_titans.parse(param1.states.titans);
         _maxFloorReached.value = param1.maxFloorReached;
         _respawnFloor.value = param1.respawnFloor;
         parseNewFloor(param1);
         if(_loc2_)
         {
            signal_init.dispatch();
         }
      }
      
      protected function parseNewFloor(param1:*) : void
      {
         var _loc3_:String = param1.floorType;
         var _loc4_:* = param1.floor;
         if(!currentFloor || currentFloor.type.ident != _loc3_)
         {
            _currentFloor = new PlayerDungeonBattleFloor();
         }
         var _loc2_:int = param1.floorNumber;
         currentFloor.updateDescription(DataStorage.dungeon.getDescriptionByFloorNumber(_loc2_));
         currentFloor.parseRawData(_loc4_);
         var _loc5_:int = findLastCapturedSaveLeverFloor();
         var _loc6_:int = findNextNotCapturedSaveLeverFloor();
         if(_loc2_ <= _loc5_)
         {
            _currentFloor.setSaveState(DungeonFloorSaveState.ALREADY_SAVED);
         }
         else if(_loc2_ == _loc6_ && currentFloor.state_battle.value == DungeonFloorBattleState.BATTLE_FINISHED)
         {
            _currentFloor.setSaveState(DungeonFloorSaveState.CAN_SAVE);
         }
         else
         {
            _currentFloor.setSaveState(DungeonFloorSaveState.NOT_SAVED_YET);
         }
         _floor.value = _loc2_;
         _maxFloorReached.value = int(Math.max(_maxFloorReached.value,_floor.value));
      }
      
      private function removeUnitsDuplicates(param1:Vector.<UnitDescription>) : Vector.<UnitDescription>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function filter_aliveHero(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         var _loc4_:TowerHeroState = teamState_heroes.getHeroState(param1.id);
         return _loc4_ == null || _loc4_.isDead == false;
      }
      
      private function filter_aliveTitan(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         var _loc4_:TowerHeroState = teamState_titans.getHeroState(param1.id);
         return _loc4_ == null || _loc4_.isDead == false;
      }
      
      private function sort_titanByPower(param1:UnitDescription, param2:UnitDescription) : int
      {
         return player.titans.getById(param1.id).getSortPower() - player.titans.getById(param2.id).getSortPower();
      }
      
      private function addTitansFromTeamData(param1:Vector.<UnitDescription>, param2:DungeonFloorElement) : void
      {
         var _loc6_:* = null;
         var _loc3_:Boolean = false;
         var _loc5_:Vector.<UnitDescription> = player.heroes.teamData.getByDungeonElement(param2);
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc6_ = teamState_titans.getHeroState(_loc4_.id);
            _loc3_ = _loc6_ == null || _loc6_.isDead == false;
            if(_loc3_ && param1.indexOf(_loc4_) == -1)
            {
               param1.push(_loc4_);
            }
         }
      }
      
      private function handler_getInfoRequest(param1:CommandDungeonGetInfo) : void
      {
         __print("handler_getInfoRequest");
         this.init(param1.result.body);
      }
      
      private function handler_battleComplete(param1:BattleThread) : void
      {
         __print("battleComplete");
         var _loc2_:CommandDungeonEndBattle = GameModel.instance.actionManager.dungeon.dungeonEndBattle(param1.battleResult);
         _loc2_.onClientExecute(handler_battleEndCommandExecuted);
      }
      
      private function handler_battleRetreat(param1:BattleThread) : void
      {
         __print("battleRetreat");
      }
      
      private function handler_battleEndCommandExecuted(param1:CommandDungeonEndBattle) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         __print("battleEndCommandComplete");
         if(!param1.success)
         {
            Game.instance.screen.hideBattle();
            return;
         }
         if(param1.victory)
         {
            _loc3_ = new DungeonBattleVictoryPopupMediator(GameModel.instance.player,param1);
            _loc5_ = Game.instance.screen.getBattleScreen();
            if(_loc5_ && _loc5_.scene)
            {
               _loc2_ = _loc3_.createPopup() as ClipBasedPopup;
               _loc5_.gui.lockAndHideControlls();
               _loc5_.gui.addBattlePopup(_loc2_);
               _loc5_.scene.setBlur();
               _loc3_.signal_closed.add(handler_victoryPopupClosed);
            }
            else
            {
               _loc3_.open();
            }
            _loc3_.signal_complete.add(handler_battleAndActionComplete);
         }
         else
         {
            _loc5_ = Game.instance.screen.getBattleScreen();
            if(_loc5_ && _loc5_.scene)
            {
               Game.instance.screen.hideBattle();
            }
            _loc4_ = new MissionDefeatPopupMediator(GameModel.instance.player,param1.commandResult,MechanicStorage.CLAN_DUNGEON);
            _loc4_.open();
         }
         signal_batlleEnd.dispatch();
      }
      
      protected function handler_victoryPopupClosed() : void
      {
         Game.instance.screen.hideBattle();
      }
      
      private function handler_commandComplete_saveProgress(param1:CommandDungeonSaveProgress) : void
      {
         currentFloor.setSaveState(DungeonFloorSaveState.ALREADY_SAVED);
         var _loc2_:DungeonRewardPopupMediator = new DungeonRewardPopupMediator(player,param1);
         _loc2_.open();
         _loc2_.signal_complete.add(handler_getRewardActionComplete);
      }
      
      private function handler_getRewardActionComplete(param1:CommandDungeonSaveProgress) : void
      {
         if(param1.result.body.dungeon)
         {
            action_parseNewState(param1.result.body.dungeon);
         }
      }
      
      private function handler_battleAndActionComplete(param1:CommandDungeonEndBattle) : void
      {
         if(currentFloor is PlayerDungeonBattleFloor)
         {
            _currentFloor.setCompleted();
            if(readyToSave)
            {
               _currentFloor.setSaveState(DungeonFloorSaveState.CAN_SAVE);
               signal_saveLeverIsAvailable.dispatch();
            }
         }
         if(param1.result.body.dungeon)
         {
            action_parseNewState(param1.result.body.dungeon);
         }
      }
   }
}
