package game.mediator.gui.popup.dailybonus
{
   import game.data.storage.DataStorage;
   import game.data.storage.dailybonus.DailyBonusDescription;
   import game.model.user.inventory.InventoryItem;
   import org.osflash.signals.Signal;
   
   public class DailyBonusValueObject
   {
       
      
      private var reward:DailyBonusDescription;
      
      private var _availableSingle:Boolean;
      
      private var _availableDouble:Boolean;
      
      private var _farmed:Boolean;
      
      private var _updateSignal:Signal;
      
      private var _isToday:Boolean;
      
      public function DailyBonusValueObject(param1:DailyBonusDescription)
      {
         _updateSignal = new Signal();
         super();
         this.reward = param1;
      }
      
      public function get availableSingle() : Boolean
      {
         return _availableSingle;
      }
      
      public function get availableDouble() : Boolean
      {
         return _availableDouble;
      }
      
      public function get rewardItem() : InventoryItem
      {
         return reward.reward;
      }
      
      public function get vipLevelDouble() : int
      {
         return reward.vipLevelDouble;
      }
      
      public function get vipHasDoubleReward() : Boolean
      {
         return reward.vipLevelDouble > 0;
      }
      
      public function get farmed() : Boolean
      {
         return _farmed;
      }
      
      public function get updateSignal() : Signal
      {
         return _updateSignal;
      }
      
      public function get day() : int
      {
         return reward.day;
      }
      
      public function get isGemReward() : Boolean
      {
         return reward.reward.item == DataStorage.pseudo.STARMONEY;
      }
      
      public function get isToday() : Boolean
      {
         return _isToday;
      }
      
      public function update(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean = false) : void
      {
         var _loc6_:Boolean = false;
         if(_availableSingle != param1)
         {
            _availableSingle = param1;
            _loc6_ = true;
         }
         if(_availableDouble != param2)
         {
            _availableDouble = param2;
            _loc6_ = true;
         }
         if(_farmed != param3)
         {
            _farmed = param3;
            _loc6_ = true;
         }
         if(_isToday != param4)
         {
            _isToday = param4;
            _loc6_ = true;
         }
         if(_loc6_ && param5)
         {
            updateSignal.dispatch();
         }
      }
   }
}
