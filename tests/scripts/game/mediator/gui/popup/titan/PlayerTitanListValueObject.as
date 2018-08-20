package game.mediator.gui.popup.titan
{
   import game.data.storage.titan.TitanDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.watch.PlayerTitanWatcherEntry;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTitanListValueObject extends PlayerTitanEntryValueObject
   {
       
      
      protected var _watch:PlayerTitanWatcherEntry;
      
      protected var _sortPower:int;
      
      protected var player:Player;
      
      private var _signal_updateActionAvailable:Signal;
      
      private var _signal_updateArtifactUpgradeAvaliable:Signal;
      
      private var _signal_updateSpiritArtifactUpgradeAvaliable:Signal;
      
      private var _signal_updateExp:Signal;
      
      private var _signal_updateLevel:Signal;
      
      private var _signal_fragmentCountUpdate:Signal;
      
      private var _signal_updateOwnershipStatus:Signal;
      
      private var _signal_updateFragmentsCount:Signal;
      
      private var _signal_titanPromote:Signal;
      
      private var _signal_titanEvolve:Signal;
      
      private var _signal_artifactEvolve:Signal;
      
      private var _signal_artifactLevelUp:Signal;
      
      private var heroFragment:InventoryItemCountProxy;
      
      public function PlayerTitanListValueObject(param1:TitanDescription, param2:Player)
      {
         _signal_updateActionAvailable = new Signal();
         _signal_updateArtifactUpgradeAvaliable = new Signal();
         _signal_updateSpiritArtifactUpgradeAvaliable = new Signal();
         _signal_updateExp = new Signal();
         _signal_updateLevel = new Signal();
         _signal_fragmentCountUpdate = new Signal();
         _signal_updateOwnershipStatus = new Signal();
         _signal_updateFragmentsCount = new Signal();
         _signal_titanPromote = new Signal();
         _signal_titanEvolve = new Signal();
         _signal_artifactEvolve = new Signal();
         _signal_artifactLevelUp = new Signal();
         this.player = param2;
         this._watch = param2.titans.watcher.getTitanWatch(param1);
         super(param1,param2.titans.getById(param1.id));
         if(_playerEntry)
         {
            _playerEntry.signal_updateExp.add(onUpdateXP);
            _playerEntry.signal_evolve.add(listener_titanEvolve);
            _playerEntry.signal_promote.add(listener_titanPromote);
            _playerEntry.signal_levelUp.add(handler_titanLevelUp);
            _playerEntry.signal_artifactLevelUp.add(listener_artifactLevelUp);
            _playerEntry.signal_artifactEvolve.add(listener_artifactEvolve);
         }
         else
         {
            param2.titans.signal_newTitanObtained.add(listener_newPlayerTitan);
         }
         _watch.signal_updateActionAvailable.add(onWatchActionAvailableUpdate);
         _watch.signal_updateArtifactUpgradeAvaliable.add(onWatchArtifactUpgradeAvaliableUpdate);
         _watch.signal_updateSpiritArtifactUpgradeAvaliable.add(onWatchSpiritArtifactUpgradeAvaliableUpdate);
         heroFragment = param2.inventory.getItemCounterProxy(param1,true);
         heroFragment.signal_update.add(handler_fragmentCountUpdate);
      }
      
      public static function sort(param1:PlayerTitanListValueObject, param2:PlayerTitanListValueObject) : int
      {
         return param2.sortValue - param1.sortValue;
      }
      
      public function dispose() : void
      {
         if(_playerEntry)
         {
            _playerEntry.signal_promote.remove(listener_titanPromote);
            _playerEntry.signal_evolve.remove(listener_titanEvolve);
            _playerEntry.signal_updateExp.remove(onUpdateXP);
            _playerEntry.signal_levelUp.remove(handler_titanLevelUp);
            _playerEntry.signal_artifactLevelUp.remove(listener_artifactLevelUp);
            _playerEntry.signal_artifactEvolve.remove(listener_artifactEvolve);
         }
         if(heroFragment)
         {
            heroFragment.signal_update.remove(handler_fragmentCountUpdate);
            heroFragment.dispose();
         }
         player.titans.signal_newTitanObtained.remove(listener_newPlayerTitan);
         var _loc1_:Inventory = player.inventory.getFragmentCollection();
         _loc1_.updateSignal.remove(onUpdateFragmentsCount);
         _watch.signal_updateActionAvailable.remove(onWatchActionAvailableUpdate);
         _watch.signal_updateArtifactUpgradeAvaliable.remove(onWatchArtifactUpgradeAvaliableUpdate);
         _watch.signal_updateArtifactUpgradeAvaliable.remove(onWatchSpiritArtifactUpgradeAvaliableUpdate);
         player = null;
      }
      
      public function get signal_updateActionAvailable() : Signal
      {
         return _signal_updateActionAvailable;
      }
      
      public function get signal_updateArtifactUpgradeAvaliable() : Signal
      {
         return _signal_updateArtifactUpgradeAvaliable;
      }
      
      public function get signal_updateSpiritArtifactUpgradeAvaliable() : Signal
      {
         return _signal_updateSpiritArtifactUpgradeAvaliable;
      }
      
      public function get signal_updateExp() : Signal
      {
         return _signal_updateExp;
      }
      
      public function get signal_updateLevel() : Signal
      {
         return _signal_updateLevel;
      }
      
      public function get signal_fragmentCountUpdate() : Signal
      {
         return _signal_fragmentCountUpdate;
      }
      
      public function get signal_updateOwnershipStatus() : Signal
      {
         return _signal_updateOwnershipStatus;
      }
      
      public function get signal_updateFragmentsCount() : Signal
      {
         return _signal_updateFragmentsCount;
      }
      
      public function get signal_titanPromote() : Signal
      {
         return _signal_titanPromote;
      }
      
      public function get signal_titanEvolve() : Signal
      {
         return _signal_titanEvolve;
      }
      
      public function get signal_artifactEvolve() : Signal
      {
         return _signal_artifactEvolve;
      }
      
      public function get signal_artifactLevelUp() : Signal
      {
         return _signal_artifactLevelUp;
      }
      
      public function get fragmentCount() : int
      {
         return heroFragment.amount;
      }
      
      public function get maxFragments() : int
      {
         if(_playerEntry)
         {
            return !!_playerEntry.star.next?_playerEntry.star.next.star.evolveFragmentCost:0;
         }
         return titan.startingStar.star.summonFragmentCost;
      }
      
      public function get canCraft() : Boolean
      {
         return fragmentCount >= maxFragments;
      }
      
      public function get redDotState() : Boolean
      {
         return _watch.actionAvailable;
      }
      
      public function get isMaxExperience() : Boolean
      {
         return exp >= maxExperience;
      }
      
      public function get maxExperience() : int
      {
         return player.heroes.getMaxHeroExp();
      }
      
      public function get sortValue() : int
      {
         if(owned)
         {
            if(_sortPower == 0)
            {
               _sortPower = playerEntry.getSortPower();
            }
            return _sortPower + 1000;
         }
         if(canCraft)
         {
            return 1000000;
         }
         return fragmentCount / _titan.startingStar.star.summonFragmentCost * 1000;
      }
      
      private function onUpdateFragmentsCount(param1:InventoryItem) : void
      {
         if(param1.item == titan)
         {
            _signal_updateFragmentsCount.dispatch();
         }
      }
      
      private function onUpdateXP(param1:PlayerTitanEntry) : void
      {
         _signal_updateExp.dispatch();
      }
      
      private function onWatchActionAvailableUpdate(param1:PlayerTitanWatcherEntry) : void
      {
         _signal_updateActionAvailable.dispatch();
      }
      
      private function onWatchArtifactUpgradeAvaliableUpdate(param1:PlayerTitanWatcherEntry) : void
      {
         _signal_updateArtifactUpgradeAvaliable.dispatch();
      }
      
      private function onWatchSpiritArtifactUpgradeAvaliableUpdate(param1:PlayerTitanWatcherEntry) : void
      {
         _signal_updateSpiritArtifactUpgradeAvaliable.dispatch();
      }
      
      private function listener_newPlayerTitan(param1:PlayerTitanEntry) : void
      {
         if(param1.titan == titan)
         {
            player.titans.signal_newTitanObtained.remove(listener_newPlayerTitan);
            _titanEntry = param1;
            _playerEntry.signal_updateExp.add(onUpdateXP);
            _playerEntry.signal_levelUp.add(handler_titanLevelUp);
            _playerEntry.signal_evolve.add(listener_titanEvolve);
            _playerEntry.signal_promote.add(listener_titanPromote);
            _playerEntry.signal_artifactLevelUp.add(listener_artifactLevelUp);
            _playerEntry.signal_artifactEvolve.add(listener_artifactEvolve);
            _signal_updateOwnershipStatus.dispatch();
         }
      }
      
      private function handler_titanLevelUp(param1:PlayerTitanEntry) : void
      {
         _signal_updateLevel.dispatch();
      }
      
      private function listener_titanEvolve(param1:PlayerTitanEntry) : void
      {
         _signal_titanEvolve.dispatch();
      }
      
      private function listener_titanPromote(param1:PlayerTitanEntry) : void
      {
         signal_titanPromote.dispatch();
      }
      
      private function handler_fragmentCountUpdate(param1:InventoryItemCountProxy) : void
      {
         _signal_fragmentCountUpdate.dispatch();
      }
      
      private function listener_artifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         _signal_artifactLevelUp.dispatch();
      }
      
      private function listener_artifactEvolve(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         _signal_artifactEvolve.dispatch();
      }
   }
}
