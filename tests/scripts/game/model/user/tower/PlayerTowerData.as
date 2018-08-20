package game.model.user.tower
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.battle.controller.thread.TowerBattleThread;
   import game.command.tower.CommandTowerEndBattle;
   import game.command.tower.CommandTowerGetInfo;
   import game.command.tower.CommandTowerNextChest;
   import game.command.tower.CommandTowerNextFloor;
   import game.command.tower.CommandTowerSkipFloor;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.data.storage.tower.TowerFloorType;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.mediator.gui.popup.tower.TowerBattleFloorPopupMediator;
   import game.mediator.gui.popup.tower.TowerBuffFloorPopupMediator;
   import game.mediator.gui.popup.tower.TowerBuffSelectHeroValueObject;
   import game.mediator.gui.popup.tower.TowerBuffValueObject;
   import game.mediator.gui.popup.tower.TowerChestFloorPopupMediator;
   import game.mediator.gui.popup.tower.TowerRewardPopupMediator;
   import game.mediator.gui.popup.tower.TowerSkipFloorPopupMediator;
   import game.mediator.gui.popup.tower.TowerSkipPopupMediator;
   import game.mediator.gui.popup.tower.TowerTeamGatherHeroValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTowerData
   {
       
      
      private const _points:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _maySkipUpToFloor:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _floor:IntPropertyWriteable = new IntPropertyWriteable();
      
      public const points:IntProperty = _points;
      
      public const maySkipUpToFloor:IntProperty = _maySkipUpToFloor;
      
      public const floor:IntProperty = _floor;
      
      public const heroes:PlayerTowerHeroStates = new PlayerTowerHeroStates();
      
      private const effects:PlayerTowerEffects = new PlayerTowerEffects();
      
      private var maxTodayFloor:int;
      
      public const signal_init:Signal = new Signal();
      
      private var _mayFullSkip:Boolean;
      
      private var _chestSkip:Boolean;
      
      private var _fullSkipCost:CostData;
      
      private var _signal_battleComplete:Signal;
      
      private var _currentFloor:PlayerTowerFloor;
      
      private var _mayBuySkip:Boolean;
      
      private var _skipBought:Boolean;
      
      private var _rewardsList:Vector.<RewardData>;
      
      public function PlayerTowerData()
      {
         _signal_battleComplete = new Signal();
         super();
      }
      
      public static function __print(param1:String, ... rest) : void
      {
      }
      
      public function get mayFullSkip() : Boolean
      {
         return _mayFullSkip;
      }
      
      public function get chestSkip() : Boolean
      {
         return _chestSkip;
      }
      
      public function get fullSkipCost() : CostData
      {
         return _fullSkipCost;
      }
      
      public function get signal_battleComplete() : Signal
      {
         return _signal_battleComplete;
      }
      
      public function get signal_effectsUpdated() : Signal
      {
         return effects.signal_update;
      }
      
      public function get canSkipCurrentFloor() : Boolean
      {
         var _loc1_:Boolean = true;
         _loc1_ = _loc1_ && currentFloor && currentFloor is PlayerTowerBattleFloor && floor.value <= maySkipUpToFloor.value;
         return _loc1_;
      }
      
      public function get currentFloor() : PlayerTowerFloor
      {
         return _currentFloor;
      }
      
      public function get mayBuySkip() : Boolean
      {
         return _mayBuySkip;
      }
      
      public function get skipBought() : Boolean
      {
         return _skipBought;
      }
      
      public function get coin() : CoinDescription
      {
         return DataStorage.coin.getByIdent("tower");
      }
      
      public function get skullCoin() : CoinDescription
      {
         return DataStorage.coin.getByIdent("skull");
      }
      
      public function get initialized() : Boolean
      {
         return floor.value > 0;
      }
      
      public function get rewardsList() : Vector.<RewardData>
      {
         return _rewardsList;
      }
      
      public function initRequest() : void
      {
         __print("getInfoRequest");
         var _loc1_:CommandTowerGetInfo = GameModel.instance.actionManager.tower.towerGetInfo();
         _loc1_.onClientExecute(handler_getInfoRequest);
      }
      
      public function getEffectList() : Vector.<PlayerTowerBuffEffect>
      {
         return effects.getList();
      }
      
      public function init(param1:*) : void
      {
         if(param1)
         {
            __print("init");
            parseRewards(param1);
            parseNewState(param1);
            if(heroes.allDead)
            {
               maxTodayFloor = floor.value;
            }
         }
         else
         {
            __print("init notUnlockedYet");
         }
      }
      
      public function reset(param1:*) : void
      {
         heroes.clear();
         effects.clear();
         init(param1);
         var _loc3_:int = GameModel.instance.player.inventory.getItemCount(skullCoin);
         var _loc2_:CostData = new CostData();
         _loc2_.inventoryCollection.addItem(skullCoin,_loc3_);
         GameModel.instance.player.spendCost(_loc2_);
         maxTodayFloor = 0;
      }
      
      public function parseRewards(param1:*) : void
      {
         _rewardsList = new Vector.<RewardData>();
         var _loc4_:int = 0;
         var _loc3_:* = param1.reward;
         for each(var _loc2_ in param1.reward)
         {
            _rewardsList.push(new RewardData(_loc2_));
         }
      }
      
      public function parseNewState(param1:*) : void
      {
         var _loc2_:* = !initialized;
         _points.value = param1.points;
         _maySkipUpToFloor.value = param1.maySkipFloor;
         _mayBuySkip = param1.mayBuySkip;
         _skipBought = param1.skipBought;
         _mayFullSkip = param1.mayFullSkip;
         _chestSkip = param1.chestSkip;
         if(param1.fullSkipCost)
         {
            _fullSkipCost = new CostData(param1.fullSkipCost);
         }
         else
         {
            _fullSkipCost = null;
         }
         parseNewFloor(param1);
         effects.parse(param1.effects);
         heroes.parse(param1.states.heroes);
         _floor.value = param1.floorNumber;
         if(_loc2_)
         {
            signal_init.dispatch();
         }
      }
      
      public function parseNewFloor(param1:*) : void
      {
         var _loc2_:String = param1.floorType;
         var _loc3_:* = param1.floor;
         if(!currentFloor || currentFloor.floor != param1.floorNumber)
         {
            if(_loc2_ == TowerFloorType.BATTLE.ident)
            {
               _currentFloor = new PlayerTowerBattleFloor();
            }
            else if(_loc2_ == TowerFloorType.CHEST.ident)
            {
               _currentFloor = new PlayerTowerChestFloor();
            }
            else if(_loc2_ == TowerFloorType.BUFF.ident)
            {
               _currentFloor = new PlayerTowerBuffFloor();
            }
            if(mayFullSkip && param1.floorNumber == 1)
            {
               currentFloor.canAddValkyrie = true;
            }
         }
         currentFloor.updateDescription(DataStorage.tower.getFloor(param1.floorNumber));
         currentFloor.parseRawData(_loc3_);
      }
      
      public function updateChestReward(param1:int, param2:RewardData, param3:Boolean, param4:Number) : void
      {
         if(currentFloor is PlayerTowerChestFloor)
         {
            (currentFloor as PlayerTowerChestFloor).updateChestReward(param1,param2,param3,param4);
         }
         rewardsList.push(param2);
      }
      
      public function battleSkipReward(param1:RewardData) : void
      {
      }
      
      public function openFloorPopup() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         if(currentFloor is PlayerTowerBattleFloor)
         {
            if(mayFullSkip)
            {
               _loc3_ = new TowerSkipPopupMediator(GameModel.instance.player);
               _loc3_.open();
            }
            else if(canSkipCurrentFloor)
            {
               _loc4_ = new TowerSkipFloorPopupMediator(GameModel.instance.player,currentFloor as PlayerTowerBattleFloor);
               _loc4_.signal_fight.add(handler_fightFloor);
               _loc4_.signal_skip.add(handler_skipFloor);
               _loc4_.open();
            }
            else
            {
               _loc2_ = new TowerBattleFloorPopupMediator(GameModel.instance.player,currentFloor as PlayerTowerBattleFloor);
               _loc2_.open();
            }
         }
         else if(currentFloor is PlayerTowerChestFloor)
         {
            _loc1_ = new TowerChestFloorPopupMediator(GameModel.instance.player,currentFloor as PlayerTowerChestFloor);
            _loc1_.open();
         }
         else if(currentFloor is PlayerTowerBuffFloor)
         {
            _loc5_ = new TowerBuffFloorPopupMediator(GameModel.instance.player,currentFloor as PlayerTowerBuffFloor);
            (currentFloor as PlayerTowerBuffFloor).updateCanProceed();
            _loc5_.open();
         }
      }
      
      private function handler_fightFloor() : void
      {
         var _loc1_:TowerBattleFloorPopupMediator = new TowerBattleFloorPopupMediator(GameModel.instance.player,currentFloor as PlayerTowerBattleFloor);
         _loc1_.open();
      }
      
      private function handler_skipFloor() : void
      {
         var _loc1_:CommandTowerSkipFloor = GameModel.instance.actionManager.tower.towerSkipFloor();
         _loc1_.onClientExecute(handler_onFloorSkipCommandResult);
      }
      
      private function handler_onFloorSkipCommandResult(param1:CommandTowerSkipFloor) : void
      {
      }
      
      public function startBattle(param1:Vector.<PlayerHeroEntry>, param2:*) : void
      {
         var _loc3_:TowerBattleThread = new TowerBattleThread(param2);
         _loc3_.onComplete.addOnce(onBattleCompleteListener);
         _loc3_.onRetreat.addOnce(onBattleRetreatListener);
         _loc3_.run();
      }
      
      public function chooseDifficulty(param1:TowerBattleDifficulty) : void
      {
         if(currentFloor is PlayerTowerBattleFloor)
         {
            (currentFloor as PlayerTowerBattleFloor).chooseDifficulty(param1);
         }
      }
      
      public function nextFloor() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(chestSkip)
         {
            _loc2_ = GameModel.instance.actionManager.tower.towerNextChest();
         }
         else
         {
            _loc1_ = GameModel.instance.actionManager.tower.towerNextFloor();
         }
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
      
      public function createBuffSelectHeroList(param1:Player, param2:TowerBuffValueObject) : Vector.<TowerBuffSelectHeroValueObject>
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
         var _loc2_:* = undefined;
         var _loc3_:Vector.<UnitDescription> = null;
         var _loc5_:MechanicDescription = DataStorage.mechanic.getByType("tower");
         var _loc4_:Vector.<UnitDescription> = param1.heroes.teamData.getByActivity(_loc5_);
         if(_loc4_)
         {
            _loc3_ = _loc4_.filter(filter_aliveHero);
         }
         if(_loc3_ == null || _loc3_.length == 0)
         {
            _loc2_ = param1.heroes.teamGathering.getTowerHeroesDescriptions();
            _loc3_ = _loc2_.filter(filter_aliveHero);
            if(_loc3_.length > 5)
            {
               _loc3_.length = 5;
            }
         }
         return _loc3_;
      }
      
      public function towerEndMessage() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(floor.value < maxTodayFloor)
         {
            return;
         }
         maxTodayFloor = floor.value;
         var _loc3_:int = DataStorage.tower.countBattleFloorsTill(maxTodayFloor);
         if(_loc3_ > 0)
         {
            _loc1_ = Translate.translateArgs("UI_TOWER_END_TITLE",_loc3_);
            _loc2_ = Translate.translateArgs("UI_TOWER_END_MESSAGE",_loc3_);
            PopupList.instance.message(_loc2_,_loc1_);
         }
      }
      
      public function action_skipFull() : void
      {
         GameModel.instance.actionManager.tower.towerFullSkip(_fullSkipCost);
      }
      
      public function action_skipSelect() : void
      {
         GameModel.instance.actionManager.tower.towerNextChest();
      }
      
      private function filter_aliveHero(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         var _loc4_:TowerHeroState = heroes.getHeroState(param1.id);
         return _loc4_ == null || _loc4_.isDead == false;
      }
      
      private function onBattleCompleteListener(param1:TowerBattleThread) : void
      {
         __print("battleComplete");
         var _loc2_:CommandTowerEndBattle = GameModel.instance.actionManager.tower.towerEndBattle(param1.battleResult);
         _loc2_.onClientExecute(onBattleEndCommandListener);
      }
      
      private function onBattleRetreatListener(param1:TowerBattleThread) : void
      {
         __print("battleRetreat");
      }
      
      private function onBattleEndCommandListener(param1:CommandTowerEndBattle) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         __print("battleEndCommandComplete");
         Game.instance.screen.hideBattle();
         if(!param1.success)
         {
            return;
         }
         if(param1.victory)
         {
            _loc2_ = new TowerRewardPopupMediator(GameModel.instance.player,param1);
            _loc2_.open();
            if(currentFloor is PlayerTowerBattleFloor)
            {
               (currentFloor as PlayerTowerBattleFloor).setCompleted();
            }
            nextFloor();
         }
         else
         {
            _loc3_ = new MissionDefeatPopupMediator(GameModel.instance.player,param1.commandResult,MechanicStorage.TOWER);
            _loc3_.open();
         }
         _signal_battleComplete.dispatch();
      }
      
      private function handler_getInfoRequest(param1:CommandTowerGetInfo) : void
      {
         __print("handler_getInfoRequest");
         this.init(param1.result.body);
      }
   }
}
