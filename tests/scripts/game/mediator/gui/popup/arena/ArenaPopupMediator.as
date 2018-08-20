package game.mediator.gui.popup.arena
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.command.rpc.arena.CommandArenaAttack;
   import game.command.rpc.arena.CommandArenaFindEnemies;
   import game.command.rpc.arena.CommandArenaGetLog;
   import game.command.rpc.arena.CommandArenaSetHeroes;
   import game.command.rpc.arena.CommandArenaSkipCooldown;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.refillable.RefillableDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.team.ArenaDefenderTeamGatherPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaData;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.model.user.inventory.InventoryItem;
   import game.screen.navigator.IRefillableNavigatorResult;
   import game.stat.Stash;
   import game.view.gui.homescreen.ShopHoverSound;
   import game.view.popup.PopupBase;
   import game.view.popup.arena.ArenaPopup;
   import game.view.popup.arena.rules.ArenaRulesPopup;
   import starling.animation.DelayedCall;
   import starling.core.Starling;
   
   public class ArenaPopupMediator extends ArenaPopupMediatorBase
   {
      
      private static var _music:ShopHoverSound;
       
      
      protected var outOfRangeController:ArenaPopupAttackOutOfRangeController;
      
      private var rerollEnemiesActionBlockedDelayedCall:DelayedCall;
      
      private var _startOnTeamSelect_mediator:ArenaAttackTeamGatherPopupMediator;
      
      protected var _action_buyTries_lastEnemy:PlayerArenaEnemy;
      
      protected var _action_skipCooldown_lastEnemy:PlayerArenaEnemy;
      
      protected var _property_rerollBlocked:BooleanPropertyWriteable;
      
      public function ArenaPopupMediator(param1:Player)
      {
         _property_rerollBlocked = new BooleanPropertyWriteable(true);
         super(param1);
         outOfRangeController = new ArenaPopupAttackOutOfRangeController(arena);
         signal_enemiesUpdate.add(handler_enemiesUpdated);
         shopIdent = "arena";
         shopResource = DataStorage.coin.getByIdent("arena");
      }
      
      public static function get music() : ShopHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(0.5,1.5,AssetStorage.sound.arenaHover);
         }
         return _music;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         signal_enemiesUpdate.remove(handler_enemiesUpdated);
         outOfRangeController.dispose();
      }
      
      public function get cost_skipCooldown() : InventoryItem
      {
         return _cooldown.refillCost.outputDisplay[0];
      }
      
      public function get defenders() : Vector.<HeroEntryValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get defenderTeamPower() : int
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<HeroEntryValueObject> = this.defenders;
         var _loc1_:int = 0;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc1_ + _loc2_[_loc4_].heroEntry.getPower();
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function get rankingIsLocked() : Boolean
      {
         return arena.rankingIsLocked;
      }
      
      public function get rankingIsLockedBattlesLeft() : int
      {
         return arena.rankingIsLockedBattlesLeft;
      }
      
      public function get rankingIsLockedUpToBattlesCount() : int
      {
         return arena.rankingIsLockedUpToBattlesCount;
      }
      
      public function get property_rerollBlocked() : BooleanProperty
      {
         return _property_rerollBlocked;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArenaPopup(this);
         return _popup;
      }
      
      override public function action_setupTeam() : void
      {
         var _loc1_:ArenaDefenderTeamGatherPopupMediator = new ArenaDefenderTeamGatherPopupMediator(player,player.arena.getValidDefenders(player));
         _loc1_.signal_teamGatherComplete.addOnce(saveArenaTeamOnTeamSelect);
         _loc1_.open(Stash.click("team_gather_arena_defense",_popup.stashParams));
      }
      
      override public function action_attack(param1:PlayerArenaEnemy) : void
      {
         var _loc2_:* = null;
         if(arenaNewbie())
         {
            return;
         }
         if(attemptsCount < 1)
         {
            action_buyTries(param1);
            return;
         }
         if(skippedCooldowns < 1)
         {
            action_skipCooldown(param1);
            return;
         }
         var _loc3_:Boolean = player.heroes.teamGathering.needArenaTeamGathering();
         if(_loc3_)
         {
            _loc2_ = new ArenaAttackTeamGatherPopupMediator(player,param1);
            _loc2_.signal_teamGatherComplete.addOnce(onAtackTeamGatheringComplete);
            _loc2_.signal_teamGatherCanceled.addOnce(handler_teamGatheringCanceled);
            _loc2_.signal_teamUpdate.add(handler_teamUpdated);
            outOfRangeController.teamGatheringStarted(param1,_loc2_);
            _loc2_.open();
         }
         else
         {
            attackEnemyWithTeam(param1,player.heroes.teamGathering.gatherDefaultArenaTeam());
         }
      }
      
      override public function action_rerollEnemies() : void
      {
         if(arenaNewbie())
         {
            return;
         }
         lockRerollButton();
         syncExecute(new CommandArenaFindEnemies());
      }
      
      public function action_buyTries(param1:PlayerArenaEnemy = null) : void
      {
         if(arenaNewbie())
         {
            return;
         }
         _action_buyTries_lastEnemy = param1;
         var _loc2_:IRefillableNavigatorResult = Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("arena_battle"),Stash.click("arena_battle_refill",_popup.stashParams));
         _loc2_.signal_refillComplete.addOnce(handler_buyTriesComplete);
      }
      
      public function action_skipCooldown(param1:PlayerArenaEnemy = null) : void
      {
         if(arenaNewbie())
         {
            return;
         }
         _action_skipCooldown_lastEnemy = param1;
         var _loc2_:IRefillableNavigatorResult = Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getById(DataStorage.arena.arena.refillableCooldownId) as RefillableDescription,Stash.click("arena_skip_cooldown",_popup.stashParams));
         _loc2_.signal_refillComplete.addOnce(handler_skipCooldownComplete);
      }
      
      public function action_skipCooldown_immediate() : void
      {
         if(arenaNewbie())
         {
            return;
         }
         _action_skipCooldown_lastEnemy = null;
         var _loc1_:CommandArenaSkipCooldown = new CommandArenaSkipCooldown();
         syncExecute(_loc1_);
      }
      
      public function action_toLogs() : void
      {
         var _loc1_:CommandArenaGetLog = new CommandArenaGetLog();
         _loc1_.signal_complete.add(handler_onArenaLogsLoaded);
         syncExecute(_loc1_);
      }
      
      public function action_toRules() : void
      {
         var _loc2_:ArenaRulesPopupValueObject = new ArenaRulesPopupValueObject(place,player.grand.getPlace());
         var _loc1_:ArenaRulesPopup = new ArenaRulesPopup(_loc2_);
         PopUpManager.addPopUp(_loc1_);
      }
      
      public function action_checkPlayerIsActive() : void
      {
         outOfRangeController.playerIsActive();
      }
      
      override protected function arenaNewbie() : Boolean
      {
         if(arena.getPlace() > 0)
         {
            return false;
         }
         var _loc1_:Vector.<UnitDescription> = player.heroes.teamGathering.getArenaDefenders();
         var _loc2_:CommandArenaSetHeroes = new CommandArenaSetHeroes(_loc1_);
         if(arena.getPlace() == 0)
         {
            _loc2_.signal_complete.add(onDefendersAutoSet);
         }
         syncExecute(_loc2_);
         return true;
      }
      
      protected function onDefendersAutoSet(param1:CommandArenaSetHeroes) : void
      {
         syncExecute(new CommandArenaFindEnemies());
      }
      
      override protected function _getArena() : PlayerArenaData
      {
         return player.arena;
      }
      
      protected function lockRerollButton() : void
      {
         if(rerollEnemiesActionBlockedDelayedCall)
         {
            Starling.juggler.remove(rerollEnemiesActionBlockedDelayedCall);
            rerollEnemiesActionBlockedDelayedCall = null;
         }
         _property_rerollBlocked.value = true;
      }
      
      protected function unlockRerollButton() : void
      {
         _property_rerollBlocked.value = false;
         rerollEnemiesActionBlockedDelayedCall = null;
      }
      
      private function handler_teamUpdated() : void
      {
         outOfRangeController.teamGatheringActivity();
      }
      
      private function saveArenaTeamOnTeamSelect(param1:TeamGatherPopupMediator) : void
      {
         syncExecute(new CommandArenaSetHeroes(param1.descriptionList));
         if(arena.getPlace() == 0)
         {
            syncExecute(new CommandArenaFindEnemies());
         }
         param1.close();
      }
      
      private function onAtackTeamGatheringComplete(param1:ArenaAttackTeamGatherPopupMediator) : void
      {
         attackEnemyWithTeam(param1.enemy,param1.descriptionList);
         _startOnTeamSelect_mediator = param1;
         outOfRangeController.teamGatheringStoped();
         param1.signal_teamUpdate.remove(handler_teamUpdated);
         param1.signal_teamGatherCanceled.remove(handler_teamGatheringCanceled);
      }
      
      private function attackEnemyWithTeam(param1:PlayerArenaEnemy, param2:Vector.<UnitDescription>) : void
      {
         var _loc3_:CommandArenaAttack = new CommandArenaAttack(param1,param2);
         _loc3_.signal_complete.addOnce(startBattle);
         _loc3_.signal_outOfRetargetDelta.addOnce(handler_attackOutOfRetagetDelta);
         syncExecute(_loc3_);
      }
      
      private function startBattle(param1:CommandArenaAttack) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = param1.battle;
         if(_loc2_)
         {
            _loc3_ = new ArenaBattleThread(_loc2_,false);
            _loc3_.commandResult = param1.battleResult;
            _loc3_.onComplete.addOnce(onBattleEnded);
            _loc3_.run();
            if(_startOnTeamSelect_mediator)
            {
               _startOnTeamSelect_mediator.close();
               _startOnTeamSelect_mediator = null;
            }
         }
      }
      
      private function handler_attackOutOfRetagetDelta() : void
      {
         outOfRangeController.handler_attackOutOfRetagetDelta();
         if(_startOnTeamSelect_mediator)
         {
            _startOnTeamSelect_mediator.close();
            _startOnTeamSelect_mediator = null;
         }
      }
      
      private function handler_onArenaLogsLoaded(param1:CommandArenaGetLog) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<ArenaLogEntryVOProxy> = new Vector.<ArenaLogEntryVOProxy>();
         var _loc2_:int = param1.resultLog.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_[_loc5_] = ArenaLogEntryVOProxy.create(param1.resultLog[_loc5_],player);
            _loc5_++;
         }
         var _loc4_:ArenaLogPopupMediator = new ArenaLogPopupMediator(player,_loc3_);
         _loc4_.open();
      }
      
      private function handler_enemiesUpdated() : void
      {
         if(rerollEnemiesActionBlockedDelayedCall)
         {
            Starling.juggler.remove(rerollEnemiesActionBlockedDelayedCall);
         }
         outOfRangeController.resetTimer();
         rerollEnemiesActionBlockedDelayedCall = Starling.juggler.delayCall(unlockRerollButton,DataStorage.rule.arenaRule.arenaEnemiesRerollCooldown) as DelayedCall;
      }
      
      private function handler_teamGatheringCanceled(param1:TeamGatherPopupMediator) : void
      {
         outOfRangeController.teamGatheringStoped();
         param1.signal_teamUpdate.remove(handler_teamUpdated);
         param1.signal_teamGatherCanceled.remove(handler_teamGatheringCanceled);
      }
      
      private function handler_battleStart() : void
      {
      }
      
      private function handler_buyTriesComplete() : void
      {
         if(_action_buyTries_lastEnemy)
         {
            action_attack(_action_buyTries_lastEnemy);
         }
      }
      
      private function handler_skipCooldownComplete() : void
      {
         if(_action_skipCooldown_lastEnemy)
         {
            action_attack(_action_skipCooldown_lastEnemy);
         }
      }
   }
}
