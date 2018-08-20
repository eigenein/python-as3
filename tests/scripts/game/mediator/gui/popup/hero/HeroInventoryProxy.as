package game.mediator.gui.popup.hero
{
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.watch.PlayerHeroWatcherEntry;
   import idv.cjcat.signals.Signal;
   
   public class HeroInventoryProxy
   {
       
      
      private var watch:PlayerHeroWatcherEntry;
      
      private var hero:PlayerHeroEntry;
      
      private var _inventory:Vector.<HeroInventorySlotValueObject>;
      
      private var _signal_update:Signal;
      
      private var _signal_slotStatesUpdate:Signal;
      
      public function HeroInventoryProxy(param1:Player, param2:PlayerHeroEntry)
      {
         _signal_update = new Signal();
         _signal_slotStatesUpdate = new Signal();
         super();
         this.hero = param2;
         watch = param1.heroes.watcher.getHeroWatch(param2.hero);
         param2.signal_promote.add(heroEntryListener_promote);
         watch.signal_updateInventorySlotActionAvailable.add(watchListener_inventoryUpdate);
         update();
      }
      
      public function dispose() : void
      {
         hero.signal_promote.remove(heroEntryListener_promote);
         watch.signal_updateInventorySlotActionAvailable.remove(watchListener_inventoryUpdate);
         watch = null;
      }
      
      public function get inventory() : Vector.<HeroInventorySlotValueObject>
      {
         return _inventory;
      }
      
      public function get signal_reset() : Signal
      {
         return _signal_update;
      }
      
      public function get signal_slotStatesUpdate() : Signal
      {
         return _signal_slotStatesUpdate;
      }
      
      private function update() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _inventory = new Vector.<HeroInventorySlotValueObject>();
         var _loc1_:int = hero.color.itemList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new HeroInventorySlotValueObject(hero.color.itemList[_loc2_],hero,_loc2_,watch.inventorySlotState(_loc2_));
            _inventory.push(_loc3_);
            _loc2_++;
         }
         if(_signal_update)
         {
            _signal_update.dispatch();
         }
      }
      
      private function watchListener_inventoryUpdate(param1:PlayerHeroWatcherEntry) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(watch != null && _inventory != null)
         {
            _loc2_ = _inventory.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _inventory[_loc3_].slotState = watch.inventorySlotState(_loc3_);
               _loc3_++;
            }
            _signal_slotStatesUpdate.dispatch();
         }
      }
      
      private function heroEntryListener_promote(param1:PlayerHeroEntry) : void
      {
         update();
      }
   }
}
