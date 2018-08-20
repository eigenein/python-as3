package game.model.user
{
   import com.progrestar.common.Logger;
   import game.command.requirement.CommandRequirement;
   import game.command.requirement.CommandRequirementCheckResult;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.level.VIPLevel;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mechanics.boss.model.PlayerBossData;
   import game.mechanics.clientoffer.model.PlayerClientOffer;
   import game.mechanics.dungeon.model.PlayerDungeonData;
   import game.mechanics.expedition.model.PlayerExpeditionData;
   import game.mechanics.quiz.model.PlayerQuizData;
   import game.mechanics.titan_arena.model.PlayerTitanArenaData;
   import game.model.GameModel;
   import game.model.signal.PlayerUpdateSignalDispatcher;
   import game.model.user.arena.PlayerArenaData;
   import game.model.user.arena.PlayerGrandData;
   import game.model.user.artifactchest.PlayerArtifactChest;
   import game.model.user.billing.PlayerBillingData;
   import game.model.user.chat.PlayerChatData;
   import game.model.user.clan.PlayerClanData;
   import game.model.user.dailybonus.PlayerDailyBonusData;
   import game.model.user.easteregg.PlayerEasterEggData;
   import game.model.user.eventBox.PlayerEventBoxData;
   import game.model.user.flags.PlayerFlagData;
   import game.model.user.freegift.PlayerFreeGiftData;
   import game.model.user.friends.PlayerFriendData;
   import game.model.user.hero.PlayerHeroData;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanData;
   import game.model.user.hero.watch.InventoryItemInfoTooltipDataFactory;
   import game.model.user.inventory.FragmentInventory;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.PlayerInventory;
   import game.model.user.level.PlayerTeamLevelData;
   import game.model.user.level.PlayerVIPLevelData;
   import game.model.user.mail.PlayerMailData;
   import game.model.user.mission.PlayerMissionData;
   import game.model.user.ny.NewYearData;
   import game.model.user.quest.PlayerQuestData;
   import game.model.user.refillable.PlayerRefillableData;
   import game.model.user.settings.PlayerSettingsData;
   import game.model.user.sharedobject.PlayerSharedObjectStorage;
   import game.model.user.shop.SpecialShopManager;
   import game.model.user.socialquest.PlayerSocialQuestData;
   import game.model.user.specialoffer.PlayerSpecialOfferData;
   import game.model.user.subscription.PlayerSubscriptionData;
   import game.model.user.titanartifactchest.PlayerTitanArtifactChest;
   import game.model.user.titansummoningcircle.PlayerTitanSummoningCircle;
   import game.model.user.tower.PlayerTowerData;
   import game.model.user.tutorial.PlayerTutorialData;
   import idv.cjcat.signals.Signal;
   
   public class Player
   {
      
      private static const logger:Logger = Logger.getLogger(Player);
       
      
      public const signal_update:PlayerUpdateSignalDispatcher = new PlayerUpdateSignalDispatcher();
      
      private var _gold:int;
      
      private var _starmoney:int;
      
      private const _level:PlayerTeamLevelData = new PlayerTeamLevelData();
      
      private const _vip:PlayerVIPLevelData = new PlayerVIPLevelData();
      
      public const arena:PlayerArenaData = new PlayerArenaData(this);
      
      public const avatarData:PlayerAvatarData = new PlayerAvatarData();
      
      public const avatarFrame:PlayerAvatarFrameData = new PlayerAvatarFrameData(this);
      
      public const billingData:PlayerBillingData = new PlayerBillingData();
      
      public const boss:PlayerBossData = new PlayerBossData(this);
      
      public const chat:PlayerChatData = new PlayerChatData();
      
      public const clan:PlayerClanData = new PlayerClanData(this);
      
      public const dailyBonus:PlayerDailyBonusData = new PlayerDailyBonusData();
      
      public const dungeon:PlayerDungeonData = new PlayerDungeonData(this);
      
      public const easterEggs:PlayerEasterEggData = new PlayerEasterEggData();
      
      public const expedition:PlayerExpeditionData = new PlayerExpeditionData();
      
      public const flags:PlayerFlagData = new PlayerFlagData();
      
      public const freeGiftData:PlayerFreeGiftData = new PlayerFreeGiftData();
      
      public const friends:PlayerFriendData = new PlayerFriendData();
      
      public const grand:PlayerGrandData = new PlayerGrandData(this);
      
      public const heroes:PlayerHeroData = new PlayerHeroData();
      
      public const titans:PlayerTitanData = new PlayerTitanData();
      
      public const titanArenaData:PlayerTitanArenaData = new PlayerTitanArenaData(this);
      
      public const inventory:PlayerInventory = new PlayerInventory();
      
      public const mail:PlayerMailData = new PlayerMailData(this);
      
      public const missions:PlayerMissionData = new PlayerMissionData();
      
      public const questData:PlayerQuestData = new PlayerQuestData();
      
      public const quizData:PlayerQuizData = new PlayerQuizData();
      
      public const refillable:PlayerRefillableData = new PlayerRefillableData();
      
      public const socialQuestData:PlayerSocialQuestData = new PlayerSocialQuestData();
      
      public const sharedObjectStorage:PlayerSharedObjectStorage = new PlayerSharedObjectStorage();
      
      public const settings:PlayerSettingsData = new PlayerSettingsData();
      
      public const specialOffer:PlayerSpecialOfferData = new PlayerSpecialOfferData(this);
      
      public const specialShop:SpecialShopManager = new SpecialShopManager();
      
      public const subscription:PlayerSubscriptionData = new PlayerSubscriptionData();
      
      public const tower:PlayerTowerData = new PlayerTowerData();
      
      public const tutorial:PlayerTutorialData = new PlayerTutorialData();
      
      public const eventBox:PlayerEventBoxData = new PlayerEventBoxData();
      
      public const artifactChest:PlayerArtifactChest = new PlayerArtifactChest();
      
      public const titanArtifactChest:PlayerTitanArtifactChest = new PlayerTitanArtifactChest();
      
      public const titanSummoningCircle:PlayerTitanSummoningCircle = new PlayerTitanSummoningCircle();
      
      public const ny:NewYearData = new NewYearData();
      
      public const clientOffer:PlayerClientOffer = new PlayerClientOffer(this);
      
      private var dataFactory:InventoryItemInfoTooltipDataFactory;
      
      private var _signal_spendCost:Signal;
      
      private var _signal_takeReward:Signal;
      
      protected var _nickname:String;
      
      private var _isChatModerator:Boolean;
      
      private var _serverId:int;
      
      protected var _id:String;
      
      protected var _lastLoginTime:int;
      
      protected var _registrationTime:int;
      
      protected var _timeZone:int;
      
      public function Player()
      {
         dataFactory = new InventoryItemInfoTooltipDataFactory();
         _signal_takeReward = new Signal(RewardData);
         super();
         _signal_spendCost = new Signal(CostData);
      }
      
      public function init(param1:Object) : void
      {
         sharedObjectStorage.initialize();
         _isChatModerator = param1.isChatModerator;
         _nickname = param1.name;
         _id = param1.id;
         _registrationTime = param1.registrationTime;
         _lastLoginTime = param1.lastLoginTime;
         _timeZone = param1.timeZone;
         _gold = param1.gold;
         _starmoney = param1.starMoney;
         _vip.init(param1.vipPoints);
         _level.init(param1.level,param1.experience);
         refillable.init(param1.refillable,this);
         refillable.setEnergyBuyLimit(param1.useEnergyBuyLimit);
         flags.init(param1.flags);
         _level.signal_levelUp.add(handler_levelUp);
         avatarData.initAvatarId(param1.avatarId);
         avatarFrame.initFrameId(param1.frameId);
         clientOffer.init();
         arena.signal_rewardTimeAlarm.add(handler_arenaRewardTimeAlarm);
         _serverId = param1.serverId;
         refillable.stamina.signal_update.add(handler_staminaUpdate);
         _vip.signal_vipLevelUpdate.add(handler_vipLevelUpdate);
         heroes.signal_newHeroObtained.add(handler_heroObtain);
         dataFactory.init(this);
      }
      
      public function get signal_spendCost() : Signal
      {
         return _signal_spendCost;
      }
      
      public function get signal_takeReward() : Signal
      {
         return _signal_takeReward;
      }
      
      public function get nickname() : String
      {
         return _nickname;
      }
      
      public function get isChatModerator() : Boolean
      {
         return _isChatModerator;
      }
      
      public function get male() : Boolean
      {
         return GameModel.instance.context.platformFacade.user.male;
      }
      
      public function get serverId() : int
      {
         return _serverId;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get lastLoginTime() : int
      {
         return _lastLoginTime;
      }
      
      public function get registrationTime() : int
      {
         return _registrationTime;
      }
      
      public function get timeZone() : int
      {
         return _timeZone;
      }
      
      public function get stamina() : int
      {
         if(refillable.stamina)
         {
            return refillable.stamina.value;
         }
         return 0;
      }
      
      public function get starmoney() : int
      {
         return _starmoney;
      }
      
      public function get gold() : int
      {
         return _gold;
      }
      
      public function get vipLevel() : VIPLevel
      {
         return _vip.level;
      }
      
      public function get vipPoints() : int
      {
         return _vip.vipPoints;
      }
      
      public function get experience() : int
      {
         return _level.experience;
      }
      
      public function get levelData() : PlayerTeamLevelData
      {
         return _level;
      }
      
      public function get isInited() : Boolean
      {
         return _id != null;
      }
      
      public function canSpend(param1:CostData) : Boolean
      {
         var _loc2_:CostData = getInsufficientCost(param1);
         return _loc2_.isEmpty;
      }
      
      public function unsafeCanSpendFast(param1:CostData) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.stamina > stamina)
         {
            return false;
         }
         if(param1.gold > gold)
         {
            return false;
         }
         if(param1.starmoney > starmoney)
         {
            return false;
         }
         if(!inventory.getFragmentCollection().contains(param1.fragmentCollection))
         {
            return false;
         }
         if(!inventory.getItemCollection().contains(param1.inventoryCollection))
         {
            return false;
         }
         return true;
      }
      
      public function getInsufficientCost(param1:CostData) : CostData
      {
         var _loc2_:CostData = new CostData();
         if(!param1)
         {
            return _loc2_;
         }
         if(param1.stamina > stamina)
         {
            _loc2_.stamina = param1.stamina - stamina;
         }
         if(param1.gold > gold)
         {
            _loc2_.gold = param1.gold - gold;
         }
         if(param1.starmoney > starmoney)
         {
            _loc2_.starmoney = param1.starmoney - starmoney;
         }
         var _loc4_:FragmentInventory = param1.fragmentCollection.getInsufficient(inventory.getFragmentCollection()) as FragmentInventory;
         if(!_loc4_.isEmpty)
         {
            _loc2_.fragmentCollection.add(_loc4_);
         }
         var _loc3_:Inventory = param1.inventoryCollection.getInsufficient(inventory.getItemCollection());
         if(!_loc3_.isEmpty)
         {
            _loc2_.inventoryCollection.add(_loc3_);
         }
         return _loc2_;
      }
      
      public function takeReward(param1:RewardData) : void
      {
         var _loc12_:* = undefined;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc11_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         logger.debug("takeReward",param1);
         if(param1.starmoney)
         {
            _starmoney = _starmoney + param1.starmoney;
            signal_update.starmoney.dispatch();
         }
         if(param1.gold)
         {
            _gold = _gold + param1.gold;
            signal_update.gold.dispatch();
         }
         if(param1.experience)
         {
            _level.experience = _level.experience + param1.experience;
            signal_update.xp.dispatch();
         }
         if(param1.stamina)
         {
            refillable.add(refillable.stamina,param1.stamina);
         }
         if(param1.heroes)
         {
            heroes.addRewardHeroes(param1.heroes);
         }
         if(param1.heroExperience)
         {
            heroes.addRewardExp(param1.heroExperience);
         }
         if(param1.titans)
         {
            titans.addRewardTitans(param1.titans);
         }
         if(param1.titanExperience)
         {
            titans.addRewardExp(param1.titanExperience);
         }
         if(param1.vipPoints)
         {
            _vip.addPoints(param1.vipPoints);
            signal_update.vip_points.dispatch();
         }
         if(param1.skill_point)
         {
            refillable.add(refillable.skillpoints,param1.skill_point);
         }
         if(param1.bundleHeroReward)
         {
            _loc12_ = heroes.addBundleHeroes(param1.bundleHeroReward);
            if(_loc12_)
            {
               _loc3_ = _loc12_.length;
               _loc6_ = 0;
               while(_loc6_ < _loc3_)
               {
                  param1.fragmentCollection.addItem(_loc12_[_loc6_].item,_loc12_[_loc6_].amount);
                  _loc6_++;
               }
            }
         }
         if(param1.fragmentCollection)
         {
            _loc2_ = param1.fragmentCollection.getCollectionByType(InventoryItemType.SKIN);
            if(_loc2_)
            {
               _loc4_ = _loc2_.getArray();
               if(_loc4_ && _loc4_.length)
               {
                  _loc9_ = 0;
                  while(_loc9_ < _loc4_.length)
                  {
                     _loc5_ = _loc4_[_loc9_];
                     _loc8_ = _loc5_.item as SkinDescription;
                     _loc11_ = heroes.getById(_loc8_.heroId);
                     if(_loc11_)
                     {
                        heroes.heroUpgradeSkin(_loc11_,_loc8_,_loc5_.amount);
                        heroes.heroChangeSkin(_loc11_,_loc8_);
                        _loc2_.disposeItem(_loc5_.item);
                        _loc9_--;
                     }
                     _loc9_++;
                  }
               }
            }
         }
         if(param1.refillables)
         {
            _loc10_ = 0;
            while(_loc10_ < param1.refillables.length)
            {
               refillable.add(refillable.getById(param1.refillables[_loc10_].id),param1.refillables[_loc10_].value);
               _loc10_++;
            }
         }
         if(param1.clanActivity || int(param1.dungeonActivity))
         {
            if(clan && clan.clan)
            {
               clan.clan.activityUpdateManager.requestUpdate();
            }
         }
         if(param1.eventBox)
         {
            _loc7_ = 0;
            while(_loc7_ < param1.eventBox.length)
            {
               if(param1.eventBox[_loc7_].item is NYGiftDescription)
               {
                  ny.giftsToOpen++;
               }
               _loc7_++;
            }
         }
         if(param1.quizPoints)
         {
            quizData.action_addPoints(param1.quizPoints);
         }
         inventory.getFragmentCollection().add(param1.fragmentCollection);
         inventory.getItemCollection().add(param1.inventoryCollection);
         _signal_takeReward.dispatch(param1);
      }
      
      public function renewStarmoneySum(param1:int) : void
      {
         _starmoney = param1;
         signal_update.starmoney.dispatch();
      }
      
      public function spendCost(param1:CostData) : void
      {
         logger.debug("spendCost",param1);
         if(param1.gold)
         {
            _gold = _gold - param1.gold;
            signal_update.gold.dispatch();
         }
         if(param1.starmoney)
         {
            _starmoney = _starmoney - param1.starmoney;
            signal_update.starmoney.dispatch();
         }
         if(param1.stamina)
         {
            refillable.spend(refillable.stamina,param1.stamina);
         }
         inventory.getFragmentCollection().subtract(param1.fragmentCollection);
         inventory.getItemCollection().subtract(param1.inventoryCollection);
         _signal_spendCost.dispatch(param1);
      }
      
      public function checkRequirement(param1:CommandRequirement) : CommandRequirementCheckResult
      {
         var _loc3_:* = null;
         var _loc2_:CommandRequirementCheckResult = new CommandRequirementCheckResult(param1);
         if(param1.cost)
         {
            _loc3_ = getInsufficientCost(param1.cost);
            if(!_loc3_.isEmpty)
            {
               _loc2_.insufficientCost = _loc3_;
            }
         }
         if(vipLevel.level < param1.vipLevel)
         {
            _loc2_.insufficientVipLevel = param1.vipLevel;
         }
         return _loc2_;
      }
      
      public function changeNickname(param1:String) : void
      {
         _nickname = param1;
         signal_update.nickname.dispatch();
      }
      
      public function changeAvatar(param1:int) : void
      {
         avatarData.changeAvatar(param1);
      }
      
      private function handler_levelUp(param1:PlayerTeamLevel) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _level.level.level;
         _loc4_ = param1.level + 1;
         while(_loc4_ <= _loc3_)
         {
            _loc2_ = DataStorage.level.getTeamLevelByLevel(_loc4_);
            refillable.add(refillable.stamina,_loc2_.levelUpRewardStamina);
            _loc4_++;
         }
         signal_update.level.dispatch();
      }
      
      private function handler_staminaUpdate() : void
      {
         signal_update.stamina.dispatch();
      }
      
      private function handler_vipLevelUpdate() : void
      {
         signal_update.vip_level.dispatch();
      }
      
      private function handler_heroObtain(param1:PlayerHeroEntry) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc2_:Inventory = inventory.getFragmentCollection();
         if(_loc2_)
         {
            _loc3_ = _loc2_.getCollectionByType(InventoryItemType.SKIN);
            if(_loc3_)
            {
               _loc4_ = _loc3_.getArray();
               if(_loc4_ && _loc4_.length)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc4_.length)
                  {
                     _loc5_ = _loc4_[_loc7_];
                     _loc6_ = _loc5_.item as SkinDescription;
                     if(_loc6_.heroId == param1.hero.id)
                     {
                        heroes.heroUpgradeSkin(param1,_loc6_,_loc5_.amount,true);
                        _loc3_.disposeItem(_loc5_.item);
                        _loc7_--;
                     }
                     _loc7_++;
                  }
               }
            }
         }
      }
      
      public function getUserInfo() : UserInfo
      {
         var _loc1_:UserInfo = new UserInfo();
         var _loc2_:Object = {};
         _loc2_.id = id;
         _loc2_.name = nickname;
         _loc2_.level = levelData.level.level;
         _loc2_.avatarId = avatarData.avatarId;
         _loc2_.frameId = avatarFrame.frameId;
         if(clan.clan)
         {
            _loc2_.clanId = clan.clan.id;
            _loc2_.clanIcon = clan.clan.icon.serialize();
            _loc2_.clanTitle = clan.clan.title;
         }
         _loc1_.parse(_loc2_);
         return _loc1_;
      }
      
      private function handler_arenaRewardTimeAlarm() : void
      {
         mail.action_addUnknownMessage();
      }
   }
}
