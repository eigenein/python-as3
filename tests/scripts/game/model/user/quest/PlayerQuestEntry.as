package game.model.user.quest
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestDescription;
   import game.model.user.specialoffer.InventoryItemSortOrder;
   import idv.cjcat.signals.Signal;
   
   public class PlayerQuestEntry
   {
       
      
      private var _signal_progressUpdate:Signal;
      
      private var _desc:QuestDescription;
      
      private var _reward:RewardData;
      
      private var _rewardSorting:InventoryItemSortOrder;
      
      private var _state:PlayerQuestConditionState;
      
      public function PlayerQuestEntry(param1:Object)
      {
         _signal_progressUpdate = new Signal(PlayerQuestEntry);
         super();
         _desc = DataStorage.quest.getQuestById(param1.id);
         _state = new PlayerQuestConditionState(_desc.farmCondition,param1.progress,param1.state);
         if(param1.reward)
         {
            _reward = new RewardData(param1.reward);
         }
         if(param1.rewardSorting && param1.rewardSorting is Array)
         {
            _rewardSorting = new InventoryItemSortOrder(param1.rewardSorting);
         }
      }
      
      public function get signal_progressUpdate() : Signal
      {
         return _signal_progressUpdate;
      }
      
      public function get desc() : QuestDescription
      {
         return _desc;
      }
      
      public function get reward() : RewardData
      {
         if(_reward)
         {
            return _reward;
         }
         return _desc.reward;
      }
      
      public function get rewardSorting() : InventoryItemSortOrder
      {
         return _rewardSorting;
      }
      
      public function get progressCurrent() : int
      {
         return _state.progress;
      }
      
      public function get canFarm() : Boolean
      {
         return _state.progress >= desc.farmCondition.amount;
      }
      
      function applyUpdate(param1:Object) : void
      {
         _state.applyUpdate(param1);
         _signal_progressUpdate.dispatch(this);
         if(param1.reward)
         {
            _reward = new RewardData(param1.reward);
         }
      }
   }
}
