package game.mediator.gui.popup.tower
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.model.GameModel;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.tower.PlayerTowerChestEntry;
   import game.model.user.tower.PlayerTowerChestFloor;
   import idv.cjcat.signals.Signal;
   
   public class TowerChestValueObject
   {
       
      
      private var _entry:PlayerTowerChestEntry;
      
      private var _floor:PlayerTowerChestFloor;
      
      public const signal_selected:Signal = new Signal(TowerChestValueObject);
      
      public function TowerChestValueObject(param1:PlayerTowerChestEntry, param2:PlayerTowerChestFloor)
      {
         super();
         this._entry = param1;
         this._floor = param2;
      }
      
      protected function get floorNumber() : int
      {
         return GameModel.instance.player.tower.floor.value;
      }
      
      public function get vipLevel() : int
      {
         return DataStorage.rule.vipRule.tower3rdChest;
      }
      
      public function get vipLocked() : Boolean
      {
         return _floor.chestsOpened == 2 && GameModel.instance.player.vipLevel.level < vipLevel;
      }
      
      public function get crit() : Boolean
      {
         return critValue > 1;
      }
      
      public function get critValue() : Number
      {
         return _entry.critMultiplier;
      }
      
      public function get signal_rewardUpdated() : Signal
      {
         return _entry.signal_updated;
      }
      
      public function get signal_costUpdated() : Signal
      {
         return _entry.signal_costUpdated;
      }
      
      public function get entry() : PlayerTowerChestEntry
      {
         return _entry;
      }
      
      public function get opened() : Boolean
      {
         return _entry.opened;
      }
      
      public function get reward() : RewardData
      {
         return _entry.reward;
      }
      
      public function get cost() : CostData
      {
         return DataStorage.tower.getFloor(floorNumber).getChestCost(_floor.chestsOpened);
      }
      
      public function get costItem() : InventoryItem
      {
         var _loc2_:* = undefined;
         var _loc1_:CostData = this.cost;
         if(_loc1_)
         {
            _loc2_ = _loc1_.outputDisplay;
            if(_loc2_.length > 0)
            {
               return _loc2_[0];
            }
            return null;
         }
         return null;
      }
      
      public function select() : void
      {
         if(!opened)
         {
            signal_selected.dispatch(this);
         }
      }
   }
}
