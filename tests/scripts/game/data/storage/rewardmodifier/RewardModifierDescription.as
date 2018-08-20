package game.data.storage.rewardmodifier
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   
   public class RewardModifierDescription extends DescriptionBase
   {
      
      public static const ACTION_END_MISSION:String = "endMission";
      
      public static const ACTION_RAID_MISSION:String = "raidMission";
      
      public static const ACTION_BILLING:String = "billing";
      
      public static const ACTION_QUEST_FARM:String = "questFarm";
      
      public static const ACTION_END_RAID_BATTLE:String = "endRaidBattle";
      
      public static const ACTION_TOWER_CHEST:String = "towerChest";
      
      public static const ACTION_OFFER_END_MISSION:String = "offer_endMission";
       
      
      public var multiplier:Number;
      
      public var actionTypes:Array;
      
      public var rewardTypes;
      
      public var additionalReward:RewardData;
      
      public function RewardModifierDescription(param1:*)
      {
         super();
         _id = param1.id;
         multiplier = param1.multiplier;
         actionTypes = param1.actionTypes;
         _name = String(actionTypes);
         rewardTypes = param1.rewardTypes;
         additionalReward = new RewardData(param1.additionalReward);
      }
      
      public function get isOnMissionEnd() : Boolean
      {
         return actionTypes && actionTypes.indexOf("endMission") != -1;
      }
      
      public function get isOnRaidMission() : Boolean
      {
         return actionTypes && actionTypes.indexOf("raidMission") != -1;
      }
      
      public function get isOnBilling() : Boolean
      {
         return actionTypes && actionTypes.indexOf("billing") != -1;
      }
      
      public function get isOnQuestFarm() : Boolean
      {
         return actionTypes && actionTypes.indexOf("questFarm") != -1;
      }
      
      public function get isOnEndRaidBattle() : Boolean
      {
         return actionTypes && actionTypes.indexOf("endRaidBattle") != -1;
      }
      
      public function get isOnTowerChest() : Boolean
      {
         return actionTypes && actionTypes.indexOf("towerChest") != -1;
      }
      
      public function affectsItem(param1:InventoryItem) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:InventoryItemDescription = param1.item;
         if(_loc3_ is HeroDescription)
         {
            _loc2_ = "fragmentHero";
         }
         else if(param1 is InventoryFragmentItem)
         {
            if(_loc3_.type == InventoryItemType.GEAR)
            {
               _loc2_ = "fragmentGear";
            }
            else if(_loc3_.type == InventoryItemType.SCROLL)
            {
               _loc2_ = "fragmentGear";
            }
            else
            {
               trace("RewardModifierDescription","incorrect fragment item type");
               _loc2_ = _loc3_.type.type;
            }
         }
         else
         {
            _loc2_ = _loc3_.type.type;
         }
         if(rewardTypes is Array)
         {
            return rewardTypes.indexOf(_loc2_) != -1;
         }
         return rewardTypes[_loc2_] && rewardTypes[_loc2_].indexOf(param1.id) != -1;
      }
      
      public function get affectsClanCoins() : Boolean
      {
         var _loc1_:int = DataStorage.coin.getByIdent("guild").id;
         return rewardTypes && rewardTypes.coin && rewardTypes.coin.length == 1 && rewardTypes.coin[0] == _loc1_;
      }
   }
}
