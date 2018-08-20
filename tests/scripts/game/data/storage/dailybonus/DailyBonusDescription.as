package game.data.storage.dailybonus
{
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   import game.model.user.inventory.InventoryItem;
   
   public class DailyBonusDescription extends DescriptionBase
   {
       
      
      private var _rawReward:Object;
      
      public var day:int;
      
      public var vipLevelDouble:int = -1;
      
      private var __reward:InventoryItem;
      
      public function DailyBonusDescription(param1:Object)
      {
         var _loc2_:* = null;
         super();
         if(param1.reward.hero || param1.reward.fragmentHero)
         {
            _rawReward = param1.reward;
         }
         else
         {
            _loc2_ = new RewardData(param1.reward);
            __reward = _loc2_.outputDisplay[0];
         }
         day = param1.day;
         if(param1.vipLevelDouble)
         {
            vipLevelDouble = param1.vipLevelDouble;
         }
      }
      
      public function get reward() : InventoryItem
      {
         return __reward;
      }
      
      public function set heroId(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(_rawReward)
         {
            _loc3_ = "";
            if(_rawReward.hero)
            {
               _loc3_ = "hero";
            }
            else if(_rawReward.fragmentHero)
            {
               _loc3_ = "fragmentHero";
            }
            _loc4_ = _rawReward[_loc3_][0];
            _rawReward[_loc3_][param1] = _loc4_;
            delete _rawReward[_loc3_][0];
            _loc2_ = new RewardData(_rawReward);
            __reward = _loc2_.outputDisplay[0];
            _rawReward = null;
         }
         try
         {
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
   }
}
