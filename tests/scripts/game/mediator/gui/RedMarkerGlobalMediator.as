package game.mediator.gui
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.expedition.model.PlayerExpeditionEntry;
   import game.model.user.Player;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestEventEntry;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.model.user.specialoffer.PlayerSpecialOfferDailyReward;
   import org.osflash.signals.SignalWatcher;
   
   public class RedMarkerGlobalMediator
   {
      
      private static var _instance:RedMarkerGlobalMediator;
       
      
      private var player:Player;
      
      private var _mail:RedMarkerState;
      
      private var _inventory:RedMarkerState;
      
      private var _quest:RedMarkerState;
      
      private var _dailyQuest:RedMarkerState;
      
      private var _specialQuest:RedMarkerState;
      
      private var _questDaily:RedMarkerState;
      
      private var _chest:RedMarkerState;
      
      private var _dailyBonus:RedMarkerState;
      
      private var _skinCoinsDailyReward:RedMarkerState;
      
      private var _hero:RedMarkerState;
      
      private var _titan:RedMarkerState;
      
      private var _titanValley:RedMarkerState;
      
      private var _friends:RedMarkerState;
      
      private var _summonKeys:RedMarkerState;
      
      private var _activity:RedMarkerState;
      
      private var _zeppelin:RedMarkerState;
      
      private var _subscription:RedMarkerState;
      
      private var _artifactChest:RedMarkerState;
      
      private var _expeditions:RedMarkerState;
      
      private var _artifacts:RedMarkerState;
      
      private var _clanWar:RedMarkerState;
      
      private var _titan_artifacts:RedMarkerState;
      
      private var _titan_spirit_artifacts:RedMarkerState;
      
      private var _titan_arena_reward:RedMarkerState;
      
      private var _titan_arena_points_reward:RedMarkerState;
      
      private var _titanArtifactChest:RedMarkerState;
      
      private var _outland:RedMarkerState;
      
      public function RedMarkerGlobalMediator(param1:Player)
      {
         super();
         this.player = param1;
         _mail = new RedMarkerState("mail");
         _inventory = new RedMarkerState("inventory");
         _quest = new RedMarkerState("quest");
         _chest = new RedMarkerState("chest");
         _dailyBonus = new RedMarkerState("dailyBonus");
         _hero = new RedMarkerState("hero");
         _titan = new RedMarkerState("titan");
         _titan_artifacts = new RedMarkerState("titan_artifacts");
         _titan_spirit_artifacts = new RedMarkerState("titan_spirit_artifacts");
         _titanArtifactChest = new RedMarkerState("titanArtifactChest");
         _titanValley = new RedMarkerState("titanValley");
         _dailyQuest = new RedMarkerState("dailyQuest");
         _skinCoinsDailyReward = new RedMarkerState("skinCoinsDailyReward");
         _specialQuest = new RedMarkerState("specialQuest");
         _friends = new RedMarkerState("friends");
         _summonKeys = new RedMarkerState("summonKeys");
         _activity = new RedMarkerState("activity");
         _zeppelin = new RedMarkerState("zeppelin");
         _subscription = new RedMarkerState("subscription");
         _artifactChest = new RedMarkerState("artifactChest");
         _expeditions = new RedMarkerState("expeditions");
         _artifacts = new RedMarkerState("artifacts");
         _clanWar = new RedMarkerState("clanWar");
         _titan_arena_reward = new RedMarkerState("titan_arena_reward");
         _titan_arena_points_reward = new RedMarkerState("titan_arena_points_reward");
         _outland = new RedMarkerState("outland");
         _subscription.signal_update.add(handler_zeppelin);
         _artifactChest.signal_update.add(handler_zeppelin);
         _expeditions.signal_update.add(handler_zeppelin);
         _titan_arena_reward.signal_update.add(handler_titanValley);
         _titan_arena_points_reward.signal_update.add(handler_titanValley);
         _titanArtifactChest.signal_update.add(handler_titanValley);
         _instance = this;
         if(param1.isInited)
         {
            handler_playerInit();
         }
         else
         {
            param1.signal_update.initSignal.add(handler_playerInit);
         }
      }
      
      public static function get instance() : RedMarkerGlobalMediator
      {
         return _instance;
      }
      
      public function get mail() : RedMarkerState
      {
         return _mail;
      }
      
      public function get inventory() : RedMarkerState
      {
         return _inventory;
      }
      
      public function get quest() : RedMarkerState
      {
         return _quest;
      }
      
      public function get dailyQuest() : RedMarkerState
      {
         return _dailyQuest;
      }
      
      public function get specialQuest() : RedMarkerState
      {
         return _specialQuest;
      }
      
      public function get questDaily() : RedMarkerState
      {
         return _questDaily;
      }
      
      public function get chest() : RedMarkerState
      {
         return _chest;
      }
      
      public function get dailyBonus() : RedMarkerState
      {
         return _dailyBonus;
      }
      
      public function get skinCoinsDailyReward() : RedMarkerState
      {
         return _skinCoinsDailyReward;
      }
      
      public function get hero() : RedMarkerState
      {
         return _hero;
      }
      
      public function get titan() : RedMarkerState
      {
         return _titan;
      }
      
      public function get titanValley() : RedMarkerState
      {
         return _titanValley;
      }
      
      public function get friends() : RedMarkerState
      {
         return _friends;
      }
      
      public function get summnonKeys() : RedMarkerState
      {
         return _summonKeys;
      }
      
      public function get activity() : RedMarkerState
      {
         return _activity;
      }
      
      public function get zeppelin() : RedMarkerState
      {
         return _zeppelin;
      }
      
      public function get subscription() : RedMarkerState
      {
         return _subscription;
      }
      
      public function get artifactChest() : RedMarkerState
      {
         return _artifactChest;
      }
      
      public function get expeditions() : RedMarkerState
      {
         return _expeditions;
      }
      
      public function get artifacts() : RedMarkerState
      {
         return _artifacts;
      }
      
      public function get clanWar() : RedMarkerState
      {
         return _clanWar;
      }
      
      public function get titan_artifacts() : RedMarkerState
      {
         return _titan_artifacts;
      }
      
      public function get titan_spirit_artifacts() : RedMarkerState
      {
         return _titan_spirit_artifacts;
      }
      
      public function get titan_arena_reward() : RedMarkerState
      {
         return _titan_arena_reward;
      }
      
      public function get titan_arena_points_reward() : RedMarkerState
      {
         return _titan_arena_points_reward;
      }
      
      public function get titanArtifactChest() : RedMarkerState
      {
         return _titanArtifactChest;
      }
      
      public function get outland() : RedMarkerState
      {
         return _outland;
      }
      
      private function handler_playerInit() : void
      {
         SignalWatcher.nameContext("redMarker");
         player.heroes.watcher.signal_update.add(handler_playerHeroUpgradeWatch);
         handler_playerHeroUpgradeWatch();
         player.titans.watcher.signal_update.add(handler_playerTitanUpgradeWatch);
         handler_playerTitanUpgradeWatch();
         player.friends.signal_update.add(handler_playerFriendsUpdate);
         handler_playerFriendsUpdate();
         player.questData.signal_questProgress.add(handler_playerQuestUpdate);
         player.questData.signal_questAdded.add(handler_playerQuestUpdate);
         player.questData.signal_questRemoved.add(handler_playerQuestUpdate);
         handler_playerQuestUpdate(null);
         player.questData.signal_eventAdd.add(handler_playerEventsUpdate);
         player.questData.signal_eventRemove.add(handler_playerEventsUpdate);
         handler_playerEventsUpdate(null);
         player.refillable.signal_chestUpdate.add(handler_chestRefillableUpdate);
         handler_chestRefillableUpdate(null);
         player.dailyBonus.signal_update.add(handler_playerDailyBonusUpdate);
         handler_playerDailyBonusUpdate();
         player.mail.signal_mailUpdated.add(handler_playerMailStateUpdate);
         handler_playerMailStateUpdate();
         player.inventory.signal_update.add(handler_playerInventoryUpdate);
         handler_playerInventoryUpdate(null,null);
         player.signal_takeReward.add(handler_playerTakeReward);
         player.signal_spendCost.add(handler_playerSpendCost);
         handler_summonKeys();
         player.expedition.signal_redDotStateChange.add(handler_expeditions);
         handler_expeditions();
         player.subscription.dailyReward.canFarm.signal_update.add(handler_subscription);
         player.subscription.currentZeppelinGift.canFarm.signal_update.add(handler_subscription);
         player.clan.clanWarData.property_redMarkerClanTries.signal_update.add(handler_currentWarMyTriesCountUpdate);
         player.clan.clanWarData.property_redMarkerArePointsMax.signal_update.add(handler_currentWarPointsUpdate);
         player.clan.clanWarData.signal_setDefenseAvaliableUpdate.add(handler_setDefenseAvaliableUpdate);
         handler_clanWarUpdate();
         player.titanArenaData.signal_rewardUpdate.add(handler_titanArenaRewardUpdate);
         handler_titanArenaRewardUpdate();
         player.titanArenaData.hasChestReward.signal_update.add(handler_titanArenaPointsRewardUpdate);
         handler_titanArenaPointsRewardUpdate();
         handler_subscription();
         player.levelData.signal_levelUp.add(handler_playerLevel);
         var _loc1_:PlayerSpecialOfferDailyReward = player.specialOffer.getSpecialOffer("dailyReward") as PlayerSpecialOfferDailyReward;
         if(_loc1_)
         {
            _loc1_.freeRewardObtained.signal_update.add(handler_skinShopOfferUpdate);
            handler_skinShopOfferUpdate(_loc1_.freeRewardObtained.value);
         }
         handler_artifactChestKeys();
         handler_titanArtifactChestKeys();
         player.boss.markerActions.signal_update.add(handler_outland);
         handler_outland();
         SignalWatcher.nameContext("after redMarker");
      }
      
      private function handler_skinShopOfferUpdate(param1:Boolean) : void
      {
         _skinCoinsDailyReward.value = !param1;
         handler_activityUpdate();
      }
      
      private function handler_subscription(param1:Boolean = false) : void
      {
         _subscription.value = player.subscription.currentZeppelinGift.canFarm.value || player.subscription.dailyReward.canFarm.value;
      }
      
      private function handler_expeditions() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         var _loc1_:int = player.expedition.list.value.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if((player.expedition.list.value[_loc3_] as PlayerExpeditionEntry).isReadyToFarm)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         _expeditions.value = _loc2_;
      }
      
      private function handler_playerHeroUpgradeWatch() : void
      {
         _hero.value = player.heroes.watcher.hasAvailableHeroUpgrades;
         _artifacts.value = player.heroes.watcher.checkAvailableArtifactUpdates();
      }
      
      private function handler_playerTitanUpgradeWatch() : void
      {
         _titan.value = player.titans.watcher.hasAvailableTitanUpgrades;
         _titan_artifacts.value = player.titans.watcher.checkAvailableArtifactUpdates();
         _titan_spirit_artifacts.value = player.titans.watcher.checkAvailableSpiritArtifactUpdates();
      }
      
      private function handler_playerQuestUpdate(param1:PlayerQuestEntry) : void
      {
         var _loc2_:int = 1;
         _quest.value = player.questData.hasQuestsToFarm;
         _dailyQuest.value = player.questData.hasDailyQuestsToFarm;
         _specialQuest.value = player.questData.hasSpecialQuestsToFarm;
         handler_activityUpdate();
      }
      
      private function handler_playerEventsUpdate(param1:PlayerQuestEventEntry) : void
      {
         handler_activityUpdate();
      }
      
      private function handler_chestRefillableUpdate(param1:PlayerRefillableEntry) : void
      {
         _chest.value = player.refillable.hasFreeChests;
      }
      
      private function handler_playerDailyBonusUpdate() : void
      {
         _dailyBonus.value = player.dailyBonus.availableSingle;
         handler_activityUpdate();
      }
      
      private function handler_activityUpdate() : void
      {
         _activity.value = _specialQuest.value || _dailyBonus.value || _skinCoinsDailyReward.value;
      }
      
      private function handler_playerMailStateUpdate() : void
      {
         _mail.value = player.mail.hasUnreadMail;
      }
      
      private function handler_playerFriendsUpdate() : void
      {
         _friends.value = player.friends.getFriendsToSendGift().length > 0;
      }
      
      private function handler_playerInventoryUpdate(param1:Inventory, param2:InventoryItem) : void
      {
         _inventory.value = player.inventory.hasNotifications();
      }
      
      private function handler_playerTakeReward(param1:RewardData) : void
      {
         handler_summonKeys();
         handler_artifactChestKeys();
         handler_titanArtifactChestKeys();
      }
      
      private function handler_playerSpendCost(param1:CostData) : void
      {
         handler_summonKeys();
         handler_artifactChestKeys();
         handler_titanArtifactChestKeys();
      }
      
      private function handler_summonKeys() : void
      {
         _summonKeys.value = player.inventory.getItemCount(DataStorage.coin.getByIdent("summon_key")) > 0;
      }
      
      private function handler_currentWarMyTriesCountUpdate(param1:int = -1) : void
      {
         handler_clanWarUpdate();
      }
      
      private function handler_currentWarPointsUpdate(param1:Boolean = false) : void
      {
         handler_clanWarUpdate();
      }
      
      private function handler_setDefenseAvaliableUpdate() : void
      {
         handler_clanWarUpdate();
      }
      
      private function handler_clanWarUpdate() : void
      {
         _clanWar.value = player.clan.clan && (player.clan.clanWarData.property_redMarkerClanTries.value > 0 && !player.clan.clanWarData.property_redMarkerArePointsMax.value || player.clan.clanWarData.setDefenseAvaliable);
      }
      
      private function handler_artifactChestKeys() : void
      {
         _artifactChest.value = player.inventory.getItemCount(DataStorage.consumable.getArtifactChestKeyDesc()) > 0;
      }
      
      private function handler_titanArtifactChestKeys() : void
      {
         _titanArtifactChest.value = player.inventory.getItemCount(DataStorage.consumable.getTitanArtifactChestKeyDesc()) > 0;
      }
      
      private function handler_zeppelin() : void
      {
         var _loc1_:* = player.levelData.level.level >= MechanicStorage.ARTIFACT.teamLevel;
         _zeppelin.value = _loc1_ && (_subscription.value || _artifactChest.value || _expeditions.value);
      }
      
      private function handler_titanValley() : void
      {
         var _loc1_:* = player.levelData.level.level >= MechanicStorage.TITAN_VALLEY.teamLevel;
         _titanValley.value = _loc1_ && (_titanArtifactChest.value || _titan_arena_reward.value || _titan_arena_points_reward.value);
      }
      
      private function handler_playerLevel(param1:PlayerTeamLevel) : void
      {
         handler_zeppelin();
         handler_titanValley();
         handler_outland();
      }
      
      private function handler_titanArenaRewardUpdate() : void
      {
         _titan_arena_reward.value = player.titanArenaData.trophyWithNotFarmedReward != null;
      }
      
      private function handler_titanArenaPointsRewardUpdate(param1:Boolean = false) : void
      {
         _titan_arena_points_reward.value = player.titanArenaData.hasChestReward.value;
      }
      
      private function handler_outland(param1:Boolean = false) : void
      {
         var _loc2_:* = player.levelData.level.level >= MechanicStorage.BOSS.teamLevel;
         _outland.value = _loc2_ && (!player.boss.rpcInitialized || player.boss.markerActions.value);
      }
   }
}
