package game.model.user.refillable
{
   import flash.utils.Dictionary;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.refillable.RefillableDescription;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class PlayerRefillableData
   {
       
      
      private var dict:Dictionary;
      
      private var vip:PlayerRefillableVIPSource;
      
      private var lvl:PlayerRefillableLevelSource;
      
      private var _signal_update:Signal;
      
      private var _signal_chestUpdate:Signal;
      
      private var _stamina:PlayerRefillableEntry;
      
      private var _skillpoints:PlayerRefillableEntry;
      
      public function PlayerRefillableData()
      {
         _signal_update = new Signal(PlayerRefillableEntry);
         super();
         dict = new Dictionary();
         _signal_chestUpdate = new Signal(PlayerRefillableEntry);
         _signal_update = new Signal(PlayerRefillableEntry);
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get signal_chestUpdate() : Signal
      {
         return _signal_chestUpdate;
      }
      
      public function get stamina() : PlayerRefillableEntry
      {
         return _stamina;
      }
      
      public function get skillpoints() : PlayerRefillableEntry
      {
         return _skillpoints;
      }
      
      public function get hasFreeChests() : Boolean
      {
         var _loc1_:PlayerRefillableEntry = getById(DataStorage.chest.CHEST_TOWN.freeRefill);
         return _loc1_.value > 0;
      }
      
      public function init(param1:Object, param2:Player) : void
      {
         var _loc4_:int = 0;
         vip = new PlayerRefillableVIPSource(param2);
         lvl = new PlayerRefillableLevelSource(param2);
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            createRefillable(param1[_loc4_]);
            _loc4_++;
         }
      }
      
      public function setEnergyBuyLimit(param1:Boolean) : void
      {
         if(!param1)
         {
            RefillableDescription.removeMaxRefillCount(_stamina.desc);
         }
      }
      
      public function reset(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_].id;
            if(dict[_loc5_])
            {
               _loc2_ = dict[_loc5_];
               _loc2_.init(param1[_loc4_]);
               _loc2_.updateAlarm();
               dispatchUpdate(_loc2_);
            }
            else
            {
               createRefillable(param1[_loc4_]);
            }
            _loc4_++;
         }
      }
      
      private function createRefillable(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc3_:RefillableDescription = DataStorage.refillable.getById(param1.id) as RefillableDescription;
         if(_loc3_ == null)
         {
            trace("Не найде refillable с ID=" + param1.id);
         }
         var _loc4_:* = _loc3_.ident;
         if("skill_point" !== _loc4_)
         {
            if("stamina" !== _loc4_)
            {
               if("alchemy" !== _loc4_)
               {
                  _loc2_ = new PlayerRefillableEntry(param1,_loc3_,vip);
               }
               else
               {
                  _loc2_ = new PlayerAlchemyRefillableEntry(param1,_loc3_,vip);
               }
            }
            else
            {
               _loc2_ = new PlayerEnergyRefillableEntry(param1,_loc3_,vip,lvl);
               _stamina = _loc2_;
            }
         }
         else
         {
            _loc2_ = new PlayerRefillableEntry(param1,_loc3_,vip);
            _skillpoints = _loc2_;
         }
         dict[_loc2_.id] = _loc2_;
         _loc2_.updateAlarm();
         _loc2_.signal_timedRefill.add(onRefillableRefillSelf);
      }
      
      public function spend(param1:PlayerRefillableEntry, param2:int) : void
      {
         if(param1 && param2)
         {
            if(param1.value >= param1.maxValue)
            {
               param1.setLastRefill(GameTimer.instance.currentServerTime);
            }
            param1.spend(param2);
            param1.updateAlarm();
            dispatchUpdate(param1);
         }
      }
      
      public function empty(param1:PlayerRefillableEntry) : void
      {
         if(param1)
         {
            if(param1.value >= param1.maxValue)
            {
               param1.setLastRefill(GameTimer.instance.currentServerTime);
            }
            param1.spend(param1.value);
            param1.updateAlarm();
            dispatchUpdate(param1);
         }
      }
      
      public function refill(param1:PlayerRefillableEntry) : void
      {
         if(param1)
         {
            param1.setLastRefill(GameTimer.instance.currentServerTime);
            param1.setRefillCount(param1.refillCount + 1);
            param1.add(param1.refillAmount);
            param1.updateAlarm();
            dispatchUpdate(param1);
         }
      }
      
      public function add(param1:PlayerRefillableEntry, param2:int) : void
      {
         if(param1)
         {
            param1.add(param2);
            param1.setLastRefill(GameTimer.instance.currentServerTime);
            param1.updateAlarm();
            dispatchUpdate(param1);
         }
      }
      
      public function freeChestOpen(param1:ChestDescription) : void
      {
         var _loc2_:PlayerRefillableEntry = getById(param1.freeRefill);
         _loc2_.setRefillCount(_loc2_.refillCount + 1);
         _loc2_.setLastRefill(GameTimer.instance.currentServerTime);
         _loc2_.spend(1);
         _loc2_.updateAlarm();
         dispatchUpdate(_loc2_);
      }
      
      public function freeLootBoxOpen(param1:int) : void
      {
         var _loc2_:PlayerRefillableEntry = getById(param1);
         _loc2_.setRefillCount(_loc2_.refillCount + 1);
         _loc2_.setLastRefill(GameTimer.instance.currentServerTime);
         _loc2_.spend(1);
         _loc2_.updateAlarm();
         dispatchUpdate(_loc2_);
      }
      
      public function tutorialDropChestTimer(param1:ChestDescription) : void
      {
         var _loc3_:PlayerRefillableEntry = getById(param1.freeRefill);
         var _loc2_:Number = GameTimer.instance.currentServerTime;
         if(_loc3_.value < 1)
         {
            _loc3_.add(1);
            if(_loc3_.maxValue == _loc3_.value)
            {
               _loc3_.setLastRefill(GameTimer.instance.currentServerTime);
               _loc3_.updateAlarm();
            }
            dispatchUpdate(_loc3_);
         }
      }
      
      public function getById(param1:int) : PlayerRefillableEntry
      {
         return dict[param1];
      }
      
      public function getByIdent(param1:String) : PlayerRefillableEntry
      {
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc2_ in dict)
         {
            if(_loc2_.desc.ident == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function dispatchUpdate(param1:PlayerRefillableEntry) : void
      {
         _signal_update.dispatch(param1);
         if(param1.id == DataStorage.chest.CHEST_TOWN.freeRefill)
         {
            _signal_chestUpdate.dispatch(param1);
         }
      }
      
      private function onRefillableRefillSelf(param1:PlayerRefillableEntry) : void
      {
         add(param1,1);
      }
   }
}
