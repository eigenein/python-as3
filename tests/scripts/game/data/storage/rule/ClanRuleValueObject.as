package game.data.storage.rule
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   
   public class ClanRuleValueObject
   {
       
      
      private var _clanGiftReward:RewardData;
      
      private var _activityForRuneUpgrade:int;
      
      private var _paidActivityPoints_amount:int;
      
      private var _paidActivityPoints_cost:CostData;
      
      private var _sameClanCooldown:int;
      
      private var _minTitleLength:int;
      
      private var _maxTitleLength:int;
      
      private var _maxDescriptionLength:int;
      
      private var _itemsActivityDailyCap:int;
      
      private var _minContribution:int;
      
      private var _searchLimit:int;
      
      private var _topPeriod:int;
      
      private var _changeTitleCost:CostData;
      
      private var _changeIconCost:CostData;
      
      private var _changeRoleNamesCost:CostData;
      
      public function ClanRuleValueObject(param1:Object)
      {
         super();
         _activityForRuneUpgrade = param1.activityForRuneUpgrade;
         _sameClanCooldown = param1.sameClanCooldown;
         _minTitleLength = param1.minTitleLength;
         _maxTitleLength = param1.maxTitleLength;
         _maxDescriptionLength = param1.maxDescriptionLength;
         _itemsActivityDailyCap = param1.itemsActivityDailyCap;
         _minContribution = param1.minContribution;
         _searchLimit = param1.searchLimit;
         _topPeriod = param1.topPeriod;
         _changeRoleNamesCost = new CostData(param1.changeRoleNamesCost);
         _changeTitleCost = new CostData(param1.changeTitleCost);
         _changeIconCost = new CostData(param1.changeIconCost);
         _paidActivityPoints_amount = param1.paidActivityPoints.activityPoints;
         _paidActivityPoints_cost = new CostData(param1.paidActivityPoints.cost);
         _clanGiftReward = new RewardData(param1.clanGift.reward);
      }
      
      public function get clanGiftReward() : RewardData
      {
         return _clanGiftReward;
      }
      
      public function get activityForRuneUpgrade() : int
      {
         return _activityForRuneUpgrade;
      }
      
      public function get paidActivityPoints_amount() : int
      {
         return _paidActivityPoints_amount;
      }
      
      public function get paidActivityPoints_cost() : CostData
      {
         return _paidActivityPoints_cost;
      }
      
      public function get sameClanCooldown() : int
      {
         return _sameClanCooldown;
      }
      
      public function get minTitleLength() : int
      {
         return _minTitleLength;
      }
      
      public function get maxTitleLength() : int
      {
         return _maxTitleLength;
      }
      
      public function get maxDescriptionLength() : int
      {
         return _maxDescriptionLength;
      }
      
      public function get itemsActivityDailyCap() : int
      {
         return _itemsActivityDailyCap;
      }
      
      public function get minContribution() : int
      {
         return _minContribution;
      }
      
      public function get searchLimit() : int
      {
         return _searchLimit;
      }
      
      public function get topPeriod() : int
      {
         return _topPeriod;
      }
      
      public function get changeTitleCost() : CostData
      {
         return _changeTitleCost;
      }
      
      public function get changeIconCost() : CostData
      {
         return _changeIconCost;
      }
      
      public function get changeRoleNamesCost() : CostData
      {
         return _changeRoleNamesCost;
      }
   }
}
