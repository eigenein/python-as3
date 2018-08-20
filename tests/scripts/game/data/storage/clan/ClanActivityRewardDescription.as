package game.data.storage.clan
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.model.user.inventory.InventoryItem;
   
   public class ClanActivityRewardDescription extends DescriptionBase
   {
       
      
      private var _clanGifts:int;
      
      private var _activityPoints:int;
      
      private var _reward:RewardData;
      
      private var _rewardDisplay:Vector.<InventoryItem>;
      
      public function ClanActivityRewardDescription(param1:Object)
      {
         super();
         _activityPoints = param1.activityPoints;
         _reward = new RewardData(param1.reward);
         _clanGifts = param1.clanGifts;
         _rewardDisplay = _reward.outputDisplay;
         if(_clanGifts)
         {
            _rewardDisplay.unshift(new InventoryItem(DataStorage.pseudo.CLAN_GIFT,_clanGifts));
         }
      }
      
      public function get clanGifts() : int
      {
         return _clanGifts;
      }
      
      public function get activityPoints() : int
      {
         return _activityPoints;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get rewardDisplay() : Vector.<InventoryItem>
      {
         return _rewardDisplay;
      }
   }
}
