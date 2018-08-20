package game.mediator.gui.popup.billing.vip
{
   import game.data.storage.DataStorage;
   import game.data.storage.admiration.AdmirationDescription;
   import game.data.storage.level.VIPLevel;
   import game.data.storage.refillable.RefillableDescription;
   import game.data.storage.rewardmodifier.RewardModifierDescription;
   import game.data.storage.rule.VipRuleValueObject;
   import game.data.storage.shop.ShopDescription;
   
   public class VipBenefitDataAggregator
   {
       
      
      private var factory:VipBenefitValueObjectFactory;
      
      private var benefits:Vector.<VipBenefitValueObject>;
      
      private var benefitCount:int = 0;
      
      public function VipBenefitDataAggregator()
      {
         factory = new VipBenefitValueObjectFactory();
         benefits = new Vector.<VipBenefitValueObject>();
         super();
      }
      
      public function getBenefitsByLevel(param1:int) : Vector.<VipBenefitValueObject>
      {
         benefitCount = 0;
         includueShops(param1);
         includeRewardModifiers(param1);
         includeRules(param1);
         includeAdmiration(param1);
         includeRefillables(param1);
         benefits.length = benefitCount;
         return benefits.concat();
      }
      
      protected function includeRefillables(param1:int) : void
      {
         var _loc2_:Vector.<RefillableDescription> = DataStorage.refillable.getVipUpgradeable();
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.maxValue && _loc3_.maxValue.length > 1)
            {
               addIfNotNull(factory.refillableMaxLevel(_loc3_,param1));
            }
            if(_loc3_.maxRefillCount && _loc3_.maxRefillCount.length > 1)
            {
               addIfNotNull(factory.refillableMaxRefillCount(_loc3_,param1));
            }
         }
      }
      
      protected function includeRules(param1:int) : void
      {
         addIfNotNull(factory.mercenaryRule(DataStorage.rule.mercenaryRule,param1));
         var _loc2_:VipRuleValueObject = DataStorage.rule.vipRule;
         if(param1 == _loc2_.missionRaid)
         {
            addIfNotNull(factory.missionRaidAvailable());
         }
         if(param1 == _loc2_.missionMultiRaid)
         {
            addIfNotNull(factory.bigMissionRaidAvailable());
         }
         if(param1 == _loc2_.towerReset)
         {
            addIfNotNull(factory.towerResetAvailable());
         }
         if(param1 == _loc2_.enchant)
         {
            addIfNotNull(factory.enchantAvailable());
         }
         if(param1 == _loc2_.tower3rdChest)
         {
            addIfNotNull(factory.tower3rdChest());
         }
         if(param1 == _loc2_.allBundlesCarousel)
         {
            addIfNotNull(factory.allBundlesAvailable());
         }
         if(param1 == _loc2_.expeditionVip)
         {
            addIfNotNull(factory.expeditionVip());
         }
      }
      
      protected function includeAdmiration(param1:int) : void
      {
         var _loc3_:Vector.<AdmirationDescription> = DataStorage.admiration.getUnlockableAt(param1);
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            addIfNotNull(factory.admiration(_loc2_));
         }
      }
      
      protected function includueShops(param1:int) : void
      {
         var _loc3_:Vector.<ShopDescription> = DataStorage.shop.getByVipLevelPermanent(param1);
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            addIfNotNull(factory.shopPermanent(_loc2_));
         }
      }
      
      protected function includeRewardModifiers(param1:int) : void
      {
         var _loc2_:VIPLevel = DataStorage.level.getVipLevel(param1);
         var _loc3_:Vector.<RewardModifierDescription> = DataStorage.rewardModifier.getByVipLevel(_loc2_);
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_.isOnBilling)
            {
               addIfNotNull(factory.billingGems(_loc4_));
            }
            else if(_loc4_.isOnEndRaidBattle)
            {
               addIfNotNull(factory.raidGold(_loc4_));
            }
            else if(_loc4_.isOnTowerChest)
            {
               addIfNotNull(factory.towerGold(_loc4_));
            }
            else if(!_loc4_.isOnQuestFarm)
            {
            }
         }
      }
      
      protected function addIfNotNull(param1:VipBenefitValueObject) : void
      {
         if(param1 != null && param1.text != null)
         {
            benefitCount = Number(benefitCount) + 1;
            benefits[Number(benefitCount)] = param1;
         }
      }
   }
}
