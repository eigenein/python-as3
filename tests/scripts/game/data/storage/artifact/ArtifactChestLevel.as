package game.data.storage.artifact
{
   import flash.utils.Dictionary;
   import game.data.reward.RewardData;
   
   public class ArtifactChestLevel
   {
       
      
      private var _level:int;
      
      private var _chestExp:int;
      
      private var _coreAmount:Array;
      
      private var _coreChance:Array;
      
      private var _levelUpReward:RewardData;
      
      private var _levelUpClanReward:RewardData;
      
      private var _fragmentChance:Dictionary;
      
      public function ArtifactChestLevel(param1:int)
      {
         super();
         _level = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get chestExp() : int
      {
         return _chestExp;
      }
      
      public function get coreAmount() : Array
      {
         return _coreAmount;
      }
      
      public function get coreChance() : Array
      {
         return _coreChance;
      }
      
      public function get levelUpReward() : RewardData
      {
         return _levelUpReward;
      }
      
      public function get levelUpClanReward() : RewardData
      {
         return _levelUpClanReward;
      }
      
      public function get fragmentChance() : Dictionary
      {
         return _fragmentChance;
      }
      
      public function deserialize(param1:Object) : void
      {
         _chestExp = param1.chestExp;
         _coreAmount = param1.coreAmount;
         _coreChance = param1.coreChance;
         _levelUpReward = new RewardData(param1.levelUpReward);
         _levelUpClanReward = new RewardData(param1.levelUpClanReward);
         _fragmentChance = new Dictionary();
         if(param1.fragmentChance)
         {
            var _loc4_:int = 0;
            var _loc3_:* = param1.fragmentChance;
            for(var _loc2_ in param1.fragmentChance)
            {
               fragmentChance[_loc2_] = int(param1.fragmentChance[_loc2_]);
            }
         }
      }
   }
}
