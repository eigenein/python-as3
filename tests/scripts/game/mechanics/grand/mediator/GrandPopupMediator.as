package game.mechanics.grand.mediator
{
   import feathers.core.PopUpManager;
   import game.command.rpc.grand.CommandGrandAttack;
   import game.command.rpc.grand.CommandGrandFarmCoins;
   import game.command.rpc.grand.CommandGrandFindEnemies;
   import game.command.rpc.grand.CommandGrandGetLogs;
   import game.command.rpc.grand.CommandGrandSetHeroes;
   import game.command.rpc.grand.CommandGrandSkipCooldown;
   import game.command.rpc.grand.GrandBattleResult;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.grand.mediator.log.GrandLogListPopupMediator;
   import game.mechanics.grand.popup.GrandPopup;
   import game.mechanics.grand.popup.GrandRulesPopup;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.arena.ArenaPopupAttackOutOfRangeController;
   import game.mediator.gui.popup.arena.ArenaPopupMediatorBase;
   import game.mediator.gui.popup.arena.ArenaRulesPopupValueObject;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.rating.RatingPopupMediator;
   import game.mediator.gui.popup.team.MultiTeamGatherPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaData;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.screen.navigator.IRefillableNavigatorResult;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class GrandPopupMediator extends ArenaPopupMediatorBase
   {
       
      
      protected var outOfRangeController:ArenaPopupAttackOutOfRangeController;
      
      private var _teamGatherMediator:Object;
      
      private var _defendersPower:int = 0;
      
      public function GrandPopupMediator(param1:Player)
      {
         super(param1);
         param1.grand.onEnemiesUpdate.add(handler_enemiesUpdate);
         shopIdent = "grandArena";
         shopResource = DataStorage.coin.getByIdent("grand_arena");
         outOfRangeController = new ArenaPopupAttackOutOfRangeController(param1.grand);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         outOfRangeController.dispose();
      }
      
      public function get defenders() : Vector.<Vector.<HeroEntryValueObject>>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get defendersPower() : int
      {
         return _defendersPower;
      }
      
      public function get onCoinsUpdate() : Signal
      {
         return player.grand.onCoinsUpdate;
      }
      
      public function get farmableCoins() : int
      {
         return player.grand.currentCoins;
      }
      
      public function get coinsByHour() : int
      {
         return player.grand.coinsByHour;
      }
      
      public function get resourceTextureIdent() : String
      {
         return shopResource.iconAssetTexture;
      }
      
      public function get cost_skipCooldown() : InventoryItem
      {
         return _cooldown.refillCost.outputDisplay[0];
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new GrandPopup(this);
         return _popup;
      }
      
      public function action_getCoins() : void
      {
         if(arenaNewbie())
         {
            return;
         }
         syncExecute(new CommandGrandFarmCoins());
      }
      
      public function action_toRules() : void
      {
         var _loc2_:ArenaRulesPopupValueObject = new ArenaRulesPopupValueObject(player.arena.getPlace(),player.grand.getPlace());
         var _loc1_:GrandRulesPopup = new GrandRulesPopup(_loc2_);
         PopUpManager.addPopUp(_loc1_);
      }
      
      public function action_toLogs() : void
      {
         var _loc1_:CommandGrandGetLogs = new CommandGrandGetLogs();
         _loc1_.signal_resultLogs.addOnce(handler_onArenaLogsLoaded);
         syncExecute(_loc1_);
      }
      
      public function action_toRating() : void
      {
         var _loc1_:RatingPopupMediator = PopupList.instance.dialog_rating(null);
         _loc1_.action_toTabGrand();
      }
      
      public function action_findEnemies() : void
      {
         if(attemptsCount < 1)
         {
            action_buyTries(true);
            return;
         }
         if(skippedCooldowns < 1)
         {
            action_skipCooldown(true);
            return;
         }
         var _loc1_:GrandSelectEnemyPopupMediator = new GrandSelectEnemyPopupMediator(player);
         _loc1_.open(Stash.click("findEnemies",_popup.stashParams));
         _loc1_.signal_enemySelected.addOnce(handler_enemySelected);
      }
      
      override public function action_setupTeam() : void
      {
         var _loc1_:GrandDefendersTeamGatherPopupMedaitor = new GrandDefendersTeamGatherPopupMedaitor(player,UnitUtils.heroVectorToUnitVector2(arena.getDefenders()));
         _loc1_.signal_teamGatherComplete.addOnce(saveArenaTeamOnTeamSelect);
         PopUpManager.addPopUp(_loc1_.createPopup());
      }
      
      override public function action_attack(param1:PlayerArenaEnemy) : void
      {
         if(arenaNewbie())
         {
            return;
         }
         var _loc2_:GrandAttackTeamGatherPopupMediator = new GrandAttackTeamGatherPopupMediator(player,param1);
         _loc2_.signal_teamGatherComplete.addOnce(attackEnemyWithTeam);
         _loc2_.signal_teamGatherCanceled.addOnce(handler_teamGatheringCanceled);
         _loc2_.signal_teamUpdate.addOnce(handler_teamUpdated);
         _loc2_.open();
         outOfRangeController.teamGatheringStarted(param1,_loc2_);
      }
      
      override public function action_rerollEnemies() : void
      {
         if(arenaNewbie())
         {
            return;
         }
         syncExecute(new CommandGrandFindEnemies());
      }
      
      public function action_buyTries(param1:Boolean = false) : void
      {
         var _loc2_:IRefillableNavigatorResult = Game.instance.navigator.navigateToRefillable(_attempts.desc,Stash.click("grand_battle_refill",_popup.stashParams));
         if(_loc2_ && param1)
         {
            _loc2_.signal_refillComplete.addOnce(handler_triesBought);
         }
      }
      
      public function action_skipCooldown(param1:Boolean = false) : void
      {
         var _loc2_:IRefillableNavigatorResult = Game.instance.navigator.navigateToRefillable(_cooldown.desc,Stash.click("grand_skip_cooldown",_popup.stashParams));
         if(_loc2_ && param1)
         {
            _loc2_.signal_refillComplete.addOnce(handler_cooldownSkipped);
         }
      }
      
      public function action_skipCooldown_immediate() : void
      {
         var _loc1_:CommandGrandSkipCooldown = new CommandGrandSkipCooldown();
         syncExecute(_loc1_);
      }
      
      override protected function _getArena() : PlayerArenaData
      {
         return player.grand;
      }
      
      private function saveArenaTeamOnTeamSelect(param1:MultiTeamGatherPopupMediator) : void
      {
         syncExecute(new CommandGrandSetHeroes(param1.descriptions));
         param1.close();
      }
      
      private function attackEnemyWithTeam(param1:GrandAttackTeamGatherPopupMediator) : void
      {
         _teamGatherMediator = param1;
         var _loc2_:CommandGrandAttack = new CommandGrandAttack(param1.enemy,param1.descriptions);
         _loc2_.signal_battleReady.addOnce(startBattle);
         _loc2_.signal_outOfRetargetDelta.addOnce(handler_attackOutOfRetagetDelta);
         syncExecute(_loc2_);
      }
      
      private function startBattle(param1:GrandBattleResult) : void
      {
         if(_teamGatherMediator)
         {
            _teamGatherMediator.close();
            _teamGatherMediator = null;
         }
         var _loc2_:GrandBattleThread = new GrandBattleThread(player,param1);
         _loc2_.run();
      }
      
      private function handler_attackOutOfRetagetDelta() : void
      {
         outOfRangeController.handler_attackOutOfRetagetDelta();
         if(_teamGatherMediator)
         {
            _teamGatherMediator.close();
            _teamGatherMediator = null;
         }
      }
      
      private function handler_teamGatheringCanceled(param1:TeamGatherPopupMediator) : void
      {
         outOfRangeController.teamGatheringStoped();
         param1.signal_teamUpdate.remove(handler_teamUpdated);
         param1.signal_teamGatherCanceled.remove(handler_teamGatheringCanceled);
      }
      
      private function handler_teamUpdated() : void
      {
         outOfRangeController.teamGatheringActivity();
      }
      
      private function handler_enemiesUpdate() : void
      {
         outOfRangeController.resetTimer();
      }
      
      private function handler_onArenaLogsLoaded(param1:Vector.<GrandBattleResult>) : void
      {
         var _loc2_:GrandLogListPopupMediator = new GrandLogListPopupMediator(player,param1);
         _loc2_.open();
      }
      
      private function handler_enemySelected(param1:PlayerArenaEnemy) : void
      {
         action_attack(param1);
      }
      
      protected function handler_triesBought() : void
      {
         action_findEnemies();
      }
      
      protected function handler_cooldownSkipped() : void
      {
         action_findEnemies();
      }
   }
}
