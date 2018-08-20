package game.data.storage.rule
{
   import flash.utils.Dictionary;
   import game.data.storage.rule.ny2018tree.NY2018TreeRule;
   import game.mechanics.clan_war.storage.ClanWarRuleValueObject;
   import game.mechanics.quiz.model.QuizRule;
   
   public class RuleStorage
   {
       
      
      private var dict:Dictionary;
      
      private var _nicknameUpdate:Object;
      
      private var _socialQuest:Object;
      
      private var _battleConfig:Object;
      
      private var _powerPerStat:Object;
      
      private var _battleStatDataPriority:Object;
      
      private var _chatRule:ChatRuleValueObject;
      
      private var _clanRule:ClanRuleValueObject;
      
      private var _clanWarRule:ClanWarRuleValueObject;
      
      private var _towerRule:TowerRuleValueObject;
      
      private var _mercenaryRule:MercenaryRuleValueObject;
      
      private var _vipRule:VipRuleValueObject;
      
      private var _fbVATRule:RuleFBVat;
      
      private var _runeEnchantStarmoney:int;
      
      private var _useAdaptiveTimer:Boolean;
      
      private var _arenaRule:ArenaRuleValueObject;
      
      private var _personalMerchantRule:PersonalMerchantValueObject;
      
      private var _questHeroAdviceTimerConfig:QuestHeroAdviceTimerConfigRule;
      
      private var _quizRule:QuizRule;
      
      private var _townChestRule:TownChestRule;
      
      private var _bossRule:BossRule;
      
      private var _u2uClientSortRule:U2UClientSortRule;
      
      private var _skipBillingConfirmationPopupRule:Boolean;
      
      private var _oneTimeBillings:Array;
      
      private var _showBillingBuyButtonOverlay:Boolean;
      
      private var _showHeroExpIncreasableMarkerUpToTeamLevel:int;
      
      private var _shopRule:ShopRule;
      
      private var _dailyBonusMonthlyHeroList:DailyBonusMonthlyHeroListRule;
      
      private var _socialGroupPromotionRule:SocialGroupPromotionRule;
      
      private var _titanExperienceStarMoneyCost:Number;
      
      private var _titanPowerPerStat:Object;
      
      private var _titanLevelPowerCoefficient:Number;
      
      private var _titanBattlegroundAsset:int;
      
      private var _questClanJoinSummonKeyReward:Object;
      
      private var _titanGiftResource:TitanGiftResourceRule;
      
      private var _dungeonRule:DungeonRuleValueObject;
      
      private var _artifactChestRule:ArtifactChestRule;
      
      private var _titanArtifactChestRule:TitanArtifactChestRule;
      
      private var _artifactWeaponPowerMultiplier:Number;
      
      private var _ny2018TreeRule:NY2018TreeRule;
      
      private var _summoningCircleFreeMultiplierRule:SummoningCircleFreeMultiplierRule;
      
      private var _summoningCircleRule:SummoningCircleRule;
      
      private var _clientOffer:Object;
      
      private var _heroicMissionUseTriesLimit:int;
      
      private var _titanArenaRule:TitanArenaRule;
      
      public function RuleStorage()
      {
         super();
      }
      
      public function get nicknameUpdate() : Object
      {
         return _nicknameUpdate;
      }
      
      public function get socialQuest() : Object
      {
         return _socialQuest;
      }
      
      public function get battleConfig() : Object
      {
         return _battleConfig;
      }
      
      public function get powerPerStat() : Object
      {
         return _powerPerStat;
      }
      
      public function get battleStatDataPriority() : Object
      {
         return _battleStatDataPriority;
      }
      
      public function get chatRule() : ChatRuleValueObject
      {
         return _chatRule;
      }
      
      public function get clanRule() : ClanRuleValueObject
      {
         return _clanRule;
      }
      
      public function get clanWarRule() : ClanWarRuleValueObject
      {
         return _clanWarRule;
      }
      
      public function get towerRule() : TowerRuleValueObject
      {
         return _towerRule;
      }
      
      public function get mercenaryRule() : MercenaryRuleValueObject
      {
         return _mercenaryRule;
      }
      
      public function get vipRule() : VipRuleValueObject
      {
         return _vipRule;
      }
      
      public function get fbVATRule() : RuleFBVat
      {
         return _fbVATRule;
      }
      
      public function get runeEnchantStarmoney() : int
      {
         return _runeEnchantStarmoney;
      }
      
      public function get useAdaptiveTimer() : Boolean
      {
         return _useAdaptiveTimer;
      }
      
      public function get arenaRule() : ArenaRuleValueObject
      {
         return _arenaRule;
      }
      
      public function get personalMerchantRule() : PersonalMerchantValueObject
      {
         return _personalMerchantRule;
      }
      
      public function get questHeroAdviceTimerConfig() : QuestHeroAdviceTimerConfigRule
      {
         return _questHeroAdviceTimerConfig;
      }
      
      public function get quizRule() : QuizRule
      {
         return _quizRule;
      }
      
      public function get townChestRule() : TownChestRule
      {
         return _townChestRule;
      }
      
      public function get bossRule() : BossRule
      {
         return _bossRule;
      }
      
      public function get u2uClientSortRule() : U2UClientSortRule
      {
         return _u2uClientSortRule;
      }
      
      public function get skipBillingConfirmationPopupRule() : Boolean
      {
         return _skipBillingConfirmationPopupRule;
      }
      
      public function get oneTimeBillings() : Array
      {
         return _oneTimeBillings;
      }
      
      public function get showBillingBuyButtonOverlay() : Boolean
      {
         return _showBillingBuyButtonOverlay;
      }
      
      public function get showHeroExpIncreasableMarkerUpToTeamLevel() : int
      {
         return _showHeroExpIncreasableMarkerUpToTeamLevel;
      }
      
      public function get shopRule() : ShopRule
      {
         return _shopRule;
      }
      
      public function get dailyBonusMonthlyHeroList() : DailyBonusMonthlyHeroListRule
      {
         return _dailyBonusMonthlyHeroList;
      }
      
      public function get socialGroupPromotionRule() : SocialGroupPromotionRule
      {
         return _socialGroupPromotionRule;
      }
      
      public function get titanExperienceStarMoneyCost() : Number
      {
         return _titanExperienceStarMoneyCost;
      }
      
      public function get titanPowerPerStat() : Object
      {
         return _titanPowerPerStat;
      }
      
      public function get titanLevelPowerCoefficient() : Number
      {
         return _titanLevelPowerCoefficient;
      }
      
      public function get titanBattlegroundAsset() : int
      {
         return _titanBattlegroundAsset;
      }
      
      public function get questClanJoinSummonKeyReward() : Object
      {
         return _questClanJoinSummonKeyReward;
      }
      
      public function get titanGiftResource() : TitanGiftResourceRule
      {
         return _titanGiftResource;
      }
      
      public function get dungeonRule() : DungeonRuleValueObject
      {
         return _dungeonRule;
      }
      
      public function get artifactChestRule() : ArtifactChestRule
      {
         return _artifactChestRule;
      }
      
      public function get titanArtifactChestRule() : TitanArtifactChestRule
      {
         return _titanArtifactChestRule;
      }
      
      public function get artifactWeaponPowerMultiplier() : Number
      {
         return _artifactWeaponPowerMultiplier;
      }
      
      public function get ny2018TreeRule() : NY2018TreeRule
      {
         return _ny2018TreeRule;
      }
      
      public function get summoningCircleMultiplierRule() : SummoningCircleFreeMultiplierRule
      {
         return _summoningCircleFreeMultiplierRule;
      }
      
      public function get summoningCircleRule() : SummoningCircleRule
      {
         return _summoningCircleRule;
      }
      
      public function get clientOffer() : Object
      {
         return _clientOffer;
      }
      
      public function get heroicMissionUseTriesLimit() : int
      {
         return _heroicMissionUseTriesLimit;
      }
      
      public function get titanArenaRule() : TitanArenaRule
      {
         return _titanArenaRule;
      }
      
      public function init(param1:Object) : void
      {
         dict = new Dictionary();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            dict[_loc2_] = param1[_loc2_];
            if(this.hasOwnProperty(_loc2_))
            {
               this["_" + _loc2_] = param1[_loc2_];
            }
         }
         _oneTimeBillings = param1.billingOneTime;
         _skipBillingConfirmationPopupRule = int(param1["skipBillingConfirmationPopup"]) == 1;
         _showBillingBuyButtonOverlay = int(param1["showBillingBuyButtonOverlay"]) == 1;
         _chatRule = new ChatRuleValueObject(param1.chat);
         _clanRule = new ClanRuleValueObject(param1.clan);
         _clanWarRule = new ClanWarRuleValueObject(param1.clanWar);
         _mercenaryRule = new MercenaryRuleValueObject(param1.mercenary);
         _vipRule = new VipRuleValueObject(param1.vip);
         _towerRule = new TowerRuleValueObject(param1.tower);
         _fbVATRule = new RuleFBVat(param1.fbVAT);
         _arenaRule = new ArenaRuleValueObject(param1.arena);
         _runeEnchantStarmoney = param1.runeEnchantStarmoney;
         _useAdaptiveTimer = param1.useAdaptiveTimer;
         _personalMerchantRule = new PersonalMerchantValueObject(param1.personalMerchant);
         _questHeroAdviceTimerConfig = new QuestHeroAdviceTimerConfigRule(param1.questAdviceTimerConfig);
         _townChestRule = new TownChestRule(param1.townChest);
         _bossRule = new BossRule(param1.boss);
         _u2uClientSortRule = new U2UClientSortRule(param1.u2uClientSort);
         _shopRule = new ShopRule(param1.shop);
         _dailyBonusMonthlyHeroList = new DailyBonusMonthlyHeroListRule(param1.dailyBonus_monthlyHeroList);
         _socialGroupPromotionRule = new SocialGroupPromotionRule(param1.socialGroupPromotion);
         _titanExperienceStarMoneyCost = Number(param1.titanExperienceStarMoneyCost);
         _dungeonRule = new DungeonRuleValueObject(param1.dungeon);
         _artifactChestRule = new ArtifactChestRule(param1.artifactChest,param1.artifactChest_rewardPresentation);
         _titanArtifactChestRule = new TitanArtifactChestRule(param1.titanArtifactChestClient);
         _ny2018TreeRule = new NY2018TreeRule(param1.NY2018_client);
         _summoningCircleFreeMultiplierRule = new SummoningCircleFreeMultiplierRule(param1.summoningCircleFreeMultiplier);
         _summoningCircleRule = new SummoningCircleRule(param1.summoningCircle);
         _quizRule = new QuizRule(param1.quiz);
         _titanGiftResource = new TitanGiftResourceRule(param1.titanGiftResourceBase);
         _titanArenaRule = new TitanArenaRule(param1.titanArena);
      }
   }
}
