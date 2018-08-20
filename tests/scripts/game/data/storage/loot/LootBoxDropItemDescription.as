package game.data.storage.loot
{
   import game.data.reward.RewardData;
   
   public class LootBoxDropItemDescription
   {
       
      
      public var chance:Number;
      
      public var reward:RewardData;
      
      public function LootBoxDropItemDescription(param1:Object)
      {
         super();
         this.chance = param1.chance;
         this.reward = new RewardData(param1.reward);
      }
   }
}
