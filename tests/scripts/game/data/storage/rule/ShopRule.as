package game.data.storage.rule
{
   import game.data.reward.RewardData;
   import game.model.user.inventory.InventoryItem;
   
   public class ShopRule
   {
       
      
      private var _rewardPerSoulStone:InventoryItem;
      
      private var _rewardPerTitanSoulStone:InventoryItem;
      
      public function ShopRule(param1:Object)
      {
         super();
         _rewardPerSoulStone = new RewardData(param1.soulshop.rewardPerSoulStone).outputDisplayFirst;
         _rewardPerTitanSoulStone = new RewardData(param1.titanSoulShop.rewardPerTitanSoulStone).outputDisplayFirst;
      }
      
      public function get rewardPerSoulStone() : InventoryItem
      {
         return _rewardPerSoulStone;
      }
      
      public function get rewardPerTitanSoulStone() : InventoryItem
      {
         return _rewardPerTitanSoulStone;
      }
   }
}
