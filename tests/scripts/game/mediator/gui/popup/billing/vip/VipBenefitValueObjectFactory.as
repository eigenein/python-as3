package game.mediator.gui.popup.billing.vip
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.admiration.AdmirationDescription;
   import game.data.storage.quest.QuestDailyDescription;
   import game.data.storage.refillable.RefillableDescription;
   import game.data.storage.rewardmodifier.RewardModifierDescription;
   import game.data.storage.rule.MercenaryRuleValueObject;
   import game.data.storage.shop.ShopDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class VipBenefitValueObjectFactory
   {
      
      private static const GUILD:Boolean = false;
      
      private static const TOWER:Boolean = true;
      
      private static const SHOW_GRAND_ARENA:Boolean = false;
      
      private static const SHOW_BOSS:Boolean = false;
      
      private static const SHOW_BILLINGS:Boolean = true;
      
      private static const SHOW_RAID_TICKETS:Boolean = true;
      
      private static const SHOW_GUILD_COINS:Boolean = false;
      
      private static const SHOW_RAID_GOLD:Boolean = false;
      
      private static const SHOW_TOWER_GOLD:Boolean = true;
      
      private static const SHOW_TOWER_3RDCHEST:Boolean = true;
      
      private static const SHOW_ALL_BUNDLES_AVAILABLE:Boolean = true;
      
      private static const SHOW_ADMIRATION:Boolean = false;
      
      private static const SHOW_SHOPS:Boolean = false;
      
      private static const SHOW_MERCENARY:Boolean = false;
      
      private static const SHOW_MISSION_RAID_AVAILABLE:Boolean = true;
      
      private static const SHOW_BIG_MISSION_RAID_ABAILABLE:Boolean = true;
      
      private static const SHOW_TOWER_RESET_AVAILABLE:Boolean = false;
      
      private static const SHOW_GEM_ENCHANT_AVAILABLE:Boolean = false;
      
      private static const QUEST_ID_VIP_RAID_TICKETS:int = 10012;
      
      private static const QUEST_ID_RAID_MISSION_COMPLETE_2_TIMES:int = 10017;
      
      private static const REFILLABLE_GRAND_ARENA:Vector.<int> = new <int>[14,20,21];
      
      private static const REFILLABLE_GUILD:Vector.<int> = new <int>[34];
      
      private static const REFILLABLE_BOSS:Vector.<int> = new <int>[36];
       
      
      private const raidTicketsDailyQuest:QuestDailyDescription = DataStorage.quest.getById(10012) as QuestDailyDescription;
      
      public const guildCoin:InventoryItem = new InventoryItem(DataStorage.coin.getByIdent("guild"));
      
      public function VipBenefitValueObjectFactory()
      {
         super();
      }
      
      public function refillableMaxLevel(param1:RefillableDescription, param2:int) : VipBenefitValueObject
      {
         if(true && REFILLABLE_GUILD.indexOf(param1.id) != -1)
         {
            return null;
         }
         if(true && REFILLABLE_GRAND_ARENA.indexOf(param1.id) != -1)
         {
            return null;
         }
         var _loc3_:int = param1.maxValueByLevel(param2);
         if(_loc3_ == param1.maxValue[0])
         {
            return null;
         }
         return new VipBenefitValueObject(translate("refillableMaxLevel_" + param1.ident,_loc3_));
      }
      
      public function refillableMaxRefillCount(param1:RefillableDescription, param2:int) : VipBenefitValueObject
      {
         if(true && REFILLABLE_GUILD.indexOf(param1.id) != -1)
         {
            return null;
         }
         if(true && REFILLABLE_GRAND_ARENA.indexOf(param1.id) != -1)
         {
            return null;
         }
         if(true && REFILLABLE_BOSS.indexOf(param1.id) != -1)
         {
            return null;
         }
         var _loc3_:int = param1.maxRefillCountByLevel(param2);
         if(_loc3_ == param1.maxRefillCount[0])
         {
            return null;
         }
         return new VipBenefitValueObject(translate("refillableMaxRefillCount_" + param1.ident,_loc3_));
      }
      
      public function shopPermanent(param1:ShopDescription) : VipBenefitValueObject
      {
         if(true)
         {
            return null;
         }
         return new VipBenefitValueObject(translate("shopPermanent",param1.name));
      }
      
      public function billingGems(param1:RewardModifierDescription) : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         var _loc2_:int = Math.round(param1.multiplier * 100 * 10) / 10 - 100;
         if(_loc2_ == 0)
         {
            return null;
         }
         return new VipBenefitValueObject(translate("billingGems",_loc2_));
      }
      
      public function raidGold(param1:RewardModifierDescription) : VipBenefitValueObject
      {
         if(true)
         {
            return null;
         }
         var _loc2_:int = Math.round(param1.multiplier * 100 * 10) / 10 - 100;
         if(_loc2_ == 0)
         {
            return null;
         }
         return new VipBenefitValueObject(translate("raidGold",_loc2_));
      }
      
      public function towerGold(param1:RewardModifierDescription) : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         var _loc2_:int = Math.round(param1.multiplier * 100 * 10) / 10 - 100;
         return new VipBenefitValueObject(translate("towerGold",_loc2_));
      }
      
      public function tower3rdChest() : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("towerChestAvailable"));
      }
      
      public function allBundlesAvailable() : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("allBundlesAvailable"));
      }
      
      public function expeditionVip() : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("expeditionVip"));
      }
      
      public function admiration(param1:AdmirationDescription) : VipBenefitValueObject
      {
         if(true)
         {
            return null;
         }
         if(param1.payerCost == null)
         {
            return null;
         }
         var _loc2_:String = param1.payerCost.outputDisplay[0].name;
         return new VipBenefitValueObject(translate("admiration",_loc2_));
      }
      
      public function mercenaryRule(param1:MercenaryRuleValueObject, param2:int) : VipBenefitValueObject
      {
         if(true)
         {
            return null;
         }
         var _loc3_:int = param1.getMercenariesCountPerVipLevel(param2);
         if(param2 == 0 || _loc3_ == param1.getMercenariesCountPerVipLevel(param2 - 1))
         {
            return null;
         }
         return new VipBenefitValueObject(translate("mercenaryRule",_loc3_));
      }
      
      public function missionRaidAvailable() : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("missionRaidAvailable"));
      }
      
      public function bigMissionRaidAvailable() : VipBenefitValueObject
      {
         if(false)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("bigMissionRaidAvailable"));
      }
      
      public function towerResetAvailable() : VipBenefitValueObject
      {
         if(true)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("towerResetAvailable"));
      }
      
      public function enchantAvailable() : VipBenefitValueObject
      {
         if(true)
         {
            return null;
         }
         return new VipBenefitValueObject(translateNoArgs("enchantAvailable"));
      }
      
      protected function translate(param1:String, param2:*) : String
      {
         var _loc3_:String = "LIB_VIP_BENEFIT_" + param1.toUpperCase();
         if(Translate.has(_loc3_))
         {
            return Translate.translateArgs(_loc3_,param2);
         }
         return null;
      }
      
      protected function translateNoArgs(param1:String) : String
      {
         var _loc2_:String = "LIB_VIP_BENEFIT_" + param1.toUpperCase();
         if(Translate.has(_loc2_))
         {
            return Translate.translate(_loc2_);
         }
         return null;
      }
   }
}
