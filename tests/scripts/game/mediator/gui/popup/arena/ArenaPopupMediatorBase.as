package game.mediator.gui.popup.arena
{
   import feathers.core.PopUpManager;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaData;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.view.popup.fightresult.pvp.ArenaVictoryPopup;
   import idv.cjcat.signals.Signal;
   
   public class ArenaPopupMediatorBase extends PopupMediator
   {
       
      
      protected var _attempts:PlayerRefillableEntry;
      
      protected var _cooldown:PlayerRefillableEntry;
      
      protected var arena:PlayerArenaData;
      
      protected var shopIdent:String;
      
      protected var shopResource:CoinDescription;
      
      public const signal_attemptsCountUpdate:Signal = new Signal();
      
      public const signal_buttonsLock:Signal = new Signal();
      
      public const signal_buttonsUnlock:Signal = new Signal();
      
      public function ArenaPopupMediatorBase(param1:Player)
      {
         super(param1);
         arena = _getArena();
         defineRefillables();
         param1.refillable.signal_update.add(onRefillableUpdated);
      }
      
      override protected function dispose() : void
      {
         player.refillable.signal_update.remove(onRefillableUpdated);
         super.dispose();
      }
      
      public function get signal_enemiesUpdate() : Signal
      {
         return arena.onEnemiesUpdate;
      }
      
      public function get signal_defendersUpdate() : Signal
      {
         return arena.onDefendersUpdate;
      }
      
      public function get signal_placeUpdate() : Signal
      {
         return arena.onPlaceUpdate;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(shopResource);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      public function get enemies() : Vector.<PlayerArenaEnemy>
      {
         return arena.getEnemies();
      }
      
      public function get place() : int
      {
         return arena.getPlace();
      }
      
      public function get battleCooldown() : int
      {
         return _cooldown.refillTimeLeft;
      }
      
      public function get attemptsCount() : int
      {
         return _attempts.value;
      }
      
      public function get attemptsMaxCount() : int
      {
         return _attempts.maxValue;
      }
      
      public function get skippedCooldowns() : int
      {
         return _cooldown.value;
      }
      
      public function get resourceCount() : int
      {
         return player.inventory.getItemCount(shopResource);
      }
      
      public function action_toShop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(shopIdent);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
      }
      
      public function action_setupTeam() : void
      {
      }
      
      public function action_attack(param1:PlayerArenaEnemy) : void
      {
      }
      
      public function action_rerollEnemies() : void
      {
      }
      
      protected function _getArena() : PlayerArenaData
      {
         trace("abstract method ArenaPopupMediator._getArena was called");
         return null;
      }
      
      protected function defineRefillables() : void
      {
         var _loc1_:ArenaDescription = arena.description;
         _attempts = player.refillable.getById(_loc1_.refillableBattleId);
         _cooldown = player.refillable.getById(_loc1_.refillableCooldownId);
      }
      
      protected function syncExecute(param1:RPCCommandBase) : void
      {
         if(GameModel.instance.actionManager.executeRPCCommand(param1))
         {
            signal_buttonsLock.dispatch();
            param1.signal_complete.addOnce(tryUnlockButtons);
            param1.signal_error.addOnce(tryUnlockButtons);
         }
      }
      
      protected function tryUnlockButtons(param1:RPCCommandBase) : void
      {
         param1.signal_complete.remove(tryUnlockButtons);
         param1.signal_error.remove(tryUnlockButtons);
         signal_buttonsUnlock.dispatch();
      }
      
      protected function arenaNewbie() : Boolean
      {
         if(arena.getPlace() > 0)
         {
            return false;
         }
         return true;
      }
      
      protected function onRefillableUpdated(param1:PlayerRefillableEntry) : void
      {
         signal_attemptsCountUpdate.dispatch();
      }
      
      protected function onBattleEnded(param1:ArenaBattleThread) : void
      {
         var _loc2_:* = null;
         Game.instance.screen.hideBattle();
         if(param1.commandResult)
         {
            param1.commandResult.result = param1.battleResult;
            if(param1.commandResult.win)
            {
               PopUpManager.addPopUp(new ArenaVictoryPopup(param1.commandResult as ArenaBattleResultValueObject));
            }
            else
            {
               _loc2_ = new MissionDefeatPopupMediator(GameModel.instance.player,param1.commandResult,MechanicStorage.ARENA);
               _loc2_.open();
            }
         }
      }
   }
}
