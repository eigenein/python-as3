package game.data.storage.loot
{
   public class LootBoxRewardDescription
   {
       
      
      public var chance:Number;
      
      public var type:String;
      
      public var amount:int;
      
      public var ids:Array;
      
      public function LootBoxRewardDescription(param1:Object)
      {
         super();
         this.chance = param1.chance;
         this.type = param1.type;
         this.amount = param1.amount;
         this.ids = param1.ids;
      }
   }
}
