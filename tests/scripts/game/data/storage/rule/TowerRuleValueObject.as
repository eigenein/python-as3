package game.data.storage.rule
{
   import game.data.cost.CostData;
   import game.data.storage.tower.TowerBattleDifficulty;
   
   public class TowerRuleValueObject
   {
       
      
      private var _buffCoinId:int;
      
      private var _buffCoinReward;
      
      private var _rewardMultiplier:Array;
      
      private var _battlegroundAsset:int;
      
      private var _fullTowerQuestId:int;
      
      private var _maxSkipFloor:int;
      
      private var _skipCost:CostData;
      
      private var _minFloorNumberToTransitionFastTo:int;
      
      private var _teamLevelToTransitionRealyFast:int;
      
      public function TowerRuleValueObject(param1:*)
      {
         super();
         _buffCoinId = param1.buffCoinId;
         _buffCoinReward = param1.buffCoinReward;
         _rewardMultiplier = param1.rewardMultiplier;
         _battlegroundAsset = param1.battlegroundAsset;
         _fullTowerQuestId = param1.fullTowerQuestId;
         _maxSkipFloor = param1.maxSkipFloor;
         _skipCost = new CostData(param1.skipCost);
         _minFloorNumberToTransitionFastTo = param1.minFloorNumberToTransitionFastTo;
         _teamLevelToTransitionRealyFast = param1.teamLevelToTransitionRealyFast;
      }
      
      public function get buffCoinId() : int
      {
         return _buffCoinId;
      }
      
      public function get battlegroundAsset() : int
      {
         return _battlegroundAsset;
      }
      
      public function get fullTowerQuestId() : int
      {
         return _fullTowerQuestId;
      }
      
      public function get maxSkipFloor() : int
      {
         return _maxSkipFloor;
      }
      
      public function get skipCost() : CostData
      {
         return _skipCost;
      }
      
      public function get minFloorNumberToTransitionFastTo() : int
      {
         return _minFloorNumberToTransitionFastTo;
      }
      
      public function get teamLevelToTransitionRealyFast() : int
      {
         return _teamLevelToTransitionRealyFast;
      }
      
      public function getDifficultySkullReward(param1:TowerBattleDifficulty) : String
      {
         if(!param1)
         {
            return "0";
         }
         var _loc2_:int = _buffCoinReward * _rewardMultiplier[1];
         var _loc3_:int = _buffCoinReward * _rewardMultiplier[_rewardMultiplier.length - 1];
         return _loc2_ + "-" + _loc3_;
      }
      
      public function getPointReward(param1:int) : String
      {
         if(param1 == 0)
         {
            return "0";
         }
         var _loc2_:int = param1 * _rewardMultiplier[1];
         var _loc3_:int = param1 * _rewardMultiplier[_rewardMultiplier.length - 1];
         return _loc2_ + "-" + _loc3_;
      }
      
      public function getMaxPointReward(param1:int) : int
      {
         return param1 * _rewardMultiplier[_rewardMultiplier.length - 1];
      }
      
      public function getMaxSkullReward(param1:TowerBattleDifficulty) : int
      {
         return _buffCoinReward * _rewardMultiplier[_rewardMultiplier.length - 1];
      }
   }
}
