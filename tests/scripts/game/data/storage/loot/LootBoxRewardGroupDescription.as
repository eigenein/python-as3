package game.data.storage.loot
{
   public class LootBoxRewardGroupDescription
   {
       
      
      public var ident:String;
      
      public var reward:Vector.<LootBoxRewardDescription>;
      
      public function LootBoxRewardGroupDescription(param1:Object)
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         super();
         this.ident = param1.ident;
         var _loc2_:Array = param1.reward;
         if(_loc2_)
         {
            reward = new Vector.<LootBoxRewardDescription>();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               reward.push(new LootBoxRewardDescription(_loc2_[_loc4_]));
               _loc4_++;
            }
         }
      }
   }
}
