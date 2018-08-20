package game.mechanics.boss.model
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import game.battle.controller.thread.BossBattleThread;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.boss.mediator.BossChestPopupMediator;
   import game.mechanics.boss.popup.BossVictoryPopup;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.screen.BattleScreen;
   import idv.cjcat.signals.Signal;
   
   public class PlayerBossData
   {
      
      private static const REFILLABLE_IDENT:String = "boss_battle";
      
      private static const REFILLABLE_IDENT_COOLDOWN:String = "boss_cooldown";
       
      
      private var player:Player;
      
      private var _rpcInitialized:Boolean = false;
      
      private var allBossesProgress:Vector.<PlayerBossEntry>;
      
      private var todayBosses:Vector.<PlayerBossEntry>;
      
      private var _tries:PlayerRefillableEntry;
      
      private var _cooldown:PlayerRefillableEntry;
      
      private const _currentBoss:ObjectPropertyWriteable = new ObjectPropertyWriteable(PlayerBossEntry);
      
      private const _canChangeBoss:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      public const signal_updateAll:Signal = new Signal();
      
      public const signal_bossChestOpened:Signal = new Signal();
      
      private var _markerActions:BooleanPropertyWriteable;
      
      public function PlayerBossData(param1:Player)
      {
         allBossesProgress = new Vector.<PlayerBossEntry>();
         todayBosses = new Vector.<PlayerBossEntry>();
         _markerActions = new BooleanPropertyWriteable();
         super();
         this.player = param1;
      }
      
      public function get tries() : PlayerRefillableEntry
      {
         return _tries;
      }
      
      public function get cooldown() : PlayerRefillableEntry
      {
         return _cooldown;
      }
      
      public function get currentBoss() : ObjectProperty
      {
         return _currentBoss;
      }
      
      public function get canChangeBoss() : BooleanProperty
      {
         return _canChangeBoss;
      }
      
      public function get rpcInitialized() : Boolean
      {
         return _rpcInitialized;
      }
      
      public function get hasSelectedBoss() : Boolean
      {
         return currentBoss.value != null;
      }
      
      public function get markerActions() : BooleanProperty
      {
         return _markerActions;
      }
      
      public function init(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = DataStorage.boss.getAllTypesList();
         for each(var _loc5_ in DataStorage.boss.getAllTypesList())
         {
            if(_loc3_ < _loc5_.id)
            {
               _loc3_ = _loc5_.id;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new PlayerBossEntry();
            _loc2_.signal_chestOpened.add(handler_chestOpen);
            allBossesProgress.push(_loc2_);
            _loc4_++;
         }
         _tries = player.refillable.getByIdent("boss_battle");
         _cooldown = player.refillable.getByIdent("boss_cooldown");
         updateAll(param1 as Array);
      }
      
      public function requestRpcInitialize() : void
      {
         GameModel.instance.actionManager.boss.bossGetAll();
      }
      
      public function action_selectBoss(param1:BossTypeDescription) : void
      {
         _currentBoss.value = getBossById(param1.id);
      }
      
      public function action_skipChestsLocal() : void
      {
         (currentBoss.value as PlayerBossEntry).skipChests();
      }
      
      public function getLevelByBoss(param1:BossTypeDescription) : int
      {
         return getBossById(param1.id).level.level;
      }
      
      public function isBossAvailableToday(param1:BossTypeDescription) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      function updateAll(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            _loc3_ = _loc4_.id;
            _loc2_ = getBossById(_loc3_);
            if(_loc2_)
            {
               _loc2_.update(_loc4_);
            }
         }
         _rpcInitialized = true;
         signal_updateAll.dispatch();
         updateMarkerActions();
      }
      
      function startBattle(param1:Vector.<PlayerHeroEntry>, param2:Object, param3:BossTypeDescription) : void
      {
         var _loc4_:BossBattleThread = new BossBattleThread(param2,param3);
         _loc4_.onComplete.addOnce(onBattleCompleteListener);
         _loc4_.run();
      }
      
      public function getBossById(param1:int) : PlayerBossEntry
      {
         var _loc2_:* = null;
         if(param1 < 1 || param1 > allBossesProgress.length)
         {
            return null;
         }
         _loc2_ = allBossesProgress[param1 - 1];
         if(_loc2_ == null)
         {
            var _loc3_:* = new PlayerBossEntry();
            allBossesProgress[param1 - 1] = _loc3_;
            _loc2_ = _loc3_;
            _loc2_.signal_chestOpened.add(handler_chestOpen);
         }
         return _loc2_;
      }
      
      public function getBossesWithMarkerActions() : Vector.<PlayerBossEntry>
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Vector.<PlayerBossEntry> = new Vector.<PlayerBossEntry>();
         var _loc1_:int = allBossesProgress.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = allBossesProgress[_loc3_];
            if(_hasMarkerActions(_loc4_))
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function updateMarkerActions() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = allBossesProgress.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = allBossesProgress[_loc3_];
            _loc1_ = _loc1_ || _hasMarkerActions(_loc4_);
            _loc3_++;
         }
         _markerActions.value = _loc1_;
      }
      
      private function _hasMarkerActions(param1:PlayerBossEntry) : Boolean
      {
         if(param1 && param1.type && param1.type.enabled)
         {
            return !param1.level || param1.level && (param1.mayRaid.value || (param1.chestCost.value as CostData).isEmpty);
         }
         return false;
      }
      
      protected function onBattleCompleteListener(param1:BossBattleThread) : void
      {
         var _loc2_:PlayerBossEntry = getBossById(param1.bossDescription.id);
         var _loc3_:CommandBossEndBattle = GameModel.instance.actionManager.boss.bossEndBattle(param1.battleResult,_loc2_);
         _loc3_.onClientExecute(onBattleEndListener);
      }
      
      protected function onBattleEndListener(param1:CommandBossEndBattle) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1.result.body && param1.result.body.error)
         {
            Game.instance.screen.hideBattle();
         }
         else
         {
            _loc2_ = param1.commandResult;
            if(param1.victory)
            {
               _loc3_ = new BossVictoryPopup(player,_loc2_);
               _loc4_ = Game.instance.screen.getBattleScreen();
               if(_loc4_ && _loc4_.scene)
               {
                  _loc4_.gui.lockAndHideControlls();
                  _loc4_.gui.addBattlePopup(_loc3_);
                  _loc4_.scene.setBlur();
               }
               _loc3_.signal_closed.add(onVictoryPopupClosed);
            }
            else
            {
               Game.instance.screen.hideBattle();
               _loc5_ = new MissionDefeatPopupMediator(player,_loc2_,MechanicStorage.BOSS);
               _loc5_.open();
            }
         }
      }
      
      protected function onVictoryPopupClosed() : void
      {
         Game.instance.screen.hideBattle();
         var _loc1_:BossChestPopupMediator = new BossChestPopupMediator(player,currentBoss.value as PlayerBossEntry);
         _loc1_.open();
      }
      
      private function handler_chestOpen(param1:CommandBossOpenChest) : void
      {
         signal_bossChestOpened.dispatch();
         updateMarkerActions();
      }
   }
}
