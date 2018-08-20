package game.data.storage.rule
{
   import game.data.reward.RewardData;
   
   public class TownChestRule
   {
       
      
      private var data:Object;
      
      private var _chestHeroList:Vector.<int>;
      
      private var _chestHeroUnlockableList:Vector.<int>;
      
      private var _superPrizeId:int;
      
      private var _coinSuperPrize:RewardData;
      
      public function TownChestRule(param1:Object)
      {
         var _loc5_:* = 0;
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         super();
         this.data = param1;
         _chestHeroList = new Vector.<int>();
         _chestHeroUnlockableList = new Vector.<int>();
         var _loc7_:int = 0;
         var _loc6_:* = param1.chestHeroList;
         for(_loc5_ in param1.chestHeroList)
         {
            _loc3_ = param1.chestHeroList[_loc5_];
            _loc2_ = _loc3_.requirement;
            if(_loc2_)
            {
               _chestHeroUnlockableList.push(_loc5_);
            }
            else
            {
               _chestHeroList.push(_loc5_);
            }
         }
         _superPrizeId = param1.superPrize.id;
         _coinSuperPrize = new RewardData(param1.coinSuperPrize.reward);
      }
      
      public function get chestHeroList() : Vector.<int>
      {
         return _chestHeroList;
      }
      
      public function get chestHeroUnlockableList() : Vector.<int>
      {
         return _chestHeroUnlockableList;
      }
      
      public function get superPrizeId() : int
      {
         return _superPrizeId;
      }
      
      public function get coinSuperPrize() : RewardData
      {
         return _coinSuperPrize;
      }
   }
}
