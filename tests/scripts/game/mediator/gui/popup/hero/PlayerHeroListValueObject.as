package game.mediator.gui.popup.hero
{
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.watch.PlayerHeroWatcherEntry;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import idv.cjcat.signals.Signal;
   
   public class PlayerHeroListValueObject extends PlayerHeroEntryValueObject
   {
       
      
      protected var _watch:PlayerHeroWatcherEntry;
      
      protected var _sortPower:int;
      
      protected var player:Player;
      
      private var _inventory:HeroInventoryProxy;
      
      private var _signal_updateActionAvailable:Signal;
      
      private var _signal_updateArtifactUpgradeAvaliable:Signal;
      
      private var _signal_updateTitanGiftLevelUpAvailable:Signal;
      
      private var _signal_updateExp:Signal;
      
      private var _signal_updateLevel:Signal;
      
      private var _signal_fragmentCountUpdate:Signal;
      
      private var _signal_updateOwnershipStatus:Signal;
      
      private var _signal_updateFragmentsCount:Signal;
      
      private var _signal_heroPromote:Signal;
      
      private var _signal_heroEvolve:Signal;
      
      private var heroFragment:InventoryItemCountProxy;
      
      public function PlayerHeroListValueObject(param1:HeroDescription, param2:Player)
      {
         _signal_updateActionAvailable = new Signal();
         _signal_updateArtifactUpgradeAvaliable = new Signal();
         _signal_updateTitanGiftLevelUpAvailable = new Signal();
         _signal_updateExp = new Signal();
         _signal_updateLevel = new Signal();
         _signal_fragmentCountUpdate = new Signal();
         _signal_updateOwnershipStatus = new Signal();
         _signal_updateFragmentsCount = new Signal();
         _signal_heroPromote = new Signal();
         _signal_heroEvolve = new Signal();
         this.player = param2;
         this._watch = param2.heroes.watcher.getHeroWatch(param1);
         super(param1,param2.heroes.getById(param1.id));
         if(_playerEntry)
         {
            _playerEntry.signal_updateExp.add(onUpdateXP);
            _playerEntry.signal_evolve.add(listener_heroEvolve);
            _playerEntry.signal_promote.add(listener_heroPromote);
            _playerEntry.signal_levelUp.add(handler_heroLevelUp);
         }
         else
         {
            param2.heroes.signal_newHeroObtained.add(listener_newPlayerHero);
         }
         if(_playerEntry)
         {
            _inventory = new HeroInventoryProxy(param2,_playerEntry);
         }
         _watch.signal_updateActionAvailable.add(onWatchActionAvailableUpdate);
         _watch.signal_updateArtifactUpgradeAvaliable.add(onWatchArtifactUpgradeAvaliableUpdate);
         _watch.signal_updateTitanGiftLevelUpAvaliable.add(onWatchTitanGiftLevelUpAvailableUpdate);
         heroFragment = param2.inventory.getItemCounterProxy(param1,true);
         heroFragment.signal_update.add(handler_fragmentCountUpdate);
      }
      
      public static function sort(param1:PlayerHeroListValueObject, param2:PlayerHeroListValueObject) : int
      {
         return param2.sortValue - param1.sortValue;
      }
      
      public function dispose() : void
      {
         if(_playerEntry)
         {
            _playerEntry.signal_promote.remove(listener_heroPromote);
            _playerEntry.signal_evolve.remove(listener_heroEvolve);
            _playerEntry.signal_updateExp.remove(onUpdateXP);
            _playerEntry.signal_levelUp.remove(handler_heroLevelUp);
         }
         if(_inventory)
         {
            _inventory.dispose();
            _inventory = null;
         }
         if(heroFragment)
         {
            heroFragment.signal_update.remove(handler_fragmentCountUpdate);
            heroFragment.dispose();
         }
         player.heroes.signal_newHeroObtained.remove(listener_newPlayerHero);
         var _loc1_:Inventory = player.inventory.getFragmentCollection();
         _loc1_.updateSignal.remove(onUpdateFragmentsCount);
         _watch.signal_updateActionAvailable.remove(onWatchActionAvailableUpdate);
         _watch.signal_updateArtifactUpgradeAvaliable.remove(onWatchArtifactUpgradeAvaliableUpdate);
         _watch.signal_updateTitanGiftLevelUpAvaliable.remove(onWatchTitanGiftLevelUpAvailableUpdate);
         player = null;
      }
      
      public function get color() : HeroColor
      {
         if(playerEntry)
         {
            return playerEntry.color.color;
         }
         return null;
      }
      
      public function get inventory() : HeroInventoryProxy
      {
         return _inventory;
      }
      
      public function get signal_updateActionAvailable() : Signal
      {
         return _signal_updateActionAvailable;
      }
      
      public function get signal_updateArtifactUpgradeAvaliable() : Signal
      {
         return _signal_updateArtifactUpgradeAvaliable;
      }
      
      public function get signal_updateTitanGiftLevelUpAvailable() : Signal
      {
         return _signal_updateTitanGiftLevelUpAvailable;
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
      
      public function get signal_heroPromote() : Signal
      {
         return _signal_heroPromote;
      }
      
      public function get signal_heroEvolve() : Signal
      {
         return _signal_heroEvolve;
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
         return hero.startingStar.star.summonFragmentCost;
      }
      
      public function get canCraft() : Boolean
      {
         return fragmentCount >= maxFragments;
      }
      
      public function get titanGiftLevelUpAvaliable() : Boolean
      {
         return _watch.titanGiftLevelUpAvaliable;
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
         return fragmentCount / _hero.startingStar.star.summonFragmentCost * 1000;
      }
      
      private function onUpdateFragmentsCount(param1:InventoryItem) : void
      {
         if(param1.item == hero)
         {
            _signal_updateFragmentsCount.dispatch();
         }
      }
      
      private function onUpdateXP(param1:PlayerHeroEntry) : void
      {
         _signal_updateExp.dispatch();
      }
      
      private function onWatchActionAvailableUpdate(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_updateActionAvailable.dispatch();
      }
      
      private function onWatchArtifactUpgradeAvaliableUpdate(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_updateArtifactUpgradeAvaliable.dispatch();
      }
      
      private function onWatchTitanGiftLevelUpAvailableUpdate(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_updateTitanGiftLevelUpAvailable.dispatch();
      }
      
      private function listener_newPlayerHero(param1:PlayerHeroEntry) : void
      {
         if(_inventory)
         {
            _inventory.dispose();
            _inventory = null;
         }
         if(param1.hero == hero)
         {
            player.heroes.signal_newHeroObtained.remove(listener_newPlayerHero);
            _heroEntry = param1;
            _playerEntry.signal_updateExp.add(onUpdateXP);
            _playerEntry.signal_levelUp.add(handler_heroLevelUp);
            _playerEntry.signal_evolve.add(listener_heroEvolve);
            _playerEntry.signal_promote.add(listener_heroPromote);
            _inventory = new HeroInventoryProxy(player,_playerEntry);
            _signal_updateOwnershipStatus.dispatch();
         }
      }
      
      private function handler_heroLevelUp(param1:PlayerHeroEntry) : void
      {
         _signal_updateLevel.dispatch();
      }
      
      private function listener_heroEvolve(param1:PlayerHeroEntry) : void
      {
         _signal_heroEvolve.dispatch();
      }
      
      private function listener_heroPromote(param1:PlayerHeroEntry) : void
      {
         signal_heroPromote.dispatch();
      }
      
      private function handler_fragmentCountUpdate(param1:InventoryItemCountProxy) : void
      {
         _signal_fragmentCountUpdate.dispatch();
      }
   }
}
