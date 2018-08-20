package game.command.rpc.enum
{
   public class RpcCommandName
   {
      
      public static const REGISTRATION:String = "registration";
      
      public static const MOBILE_LOGIN:String = "mobileLogin";
      
      public static const LIB_GET_VERSION:String = "getLibVersion";
      
      public static const MOBILE_GET_PUSHD_CREDENTIALS:String = "getPushdCredentials";
      
      public static const MOBILE_PUSH_SEND_TEST:String = "pushSend";
      
      public static const USER_GET_INFO:String = "userGetInfo";
      
      public static const USER_SET_NAME:String = "setName";
      
      public static const USER_GET_AVAILABLE_AVATARS:String = "userGetAvailableAvatars";
      
      public static const USER_SET_AVATAR:String = "userSetAvatar";
      
      public static const USER_SETTINGS_GET_ALL:String = "settingsGetAll";
      
      public static const USER_SETTINGS_SET:String = "settingsSet";
      
      public static const USER_SET_TIME_ZONE:String = "setTimeZone";
      
      public static const USER_GET_INFO_BY_IDS:String = "userGetInfoByIds";
      
      public static const SERVER_GET_ALL:String = "serverGetAll";
      
      public static const SERVER_USER_CREATE:String = "userCreate";
      
      public static const SERVER_USER_CHANGE:String = "userChange";
      
      public static const SERVER_USER_MIGRATE:String = "userMigrate";
      
      public static const SERVER_GET_MAX:String = "userMaxMigrateServer";
      
      public static const RATING_TOP_GET:String = "topGet";
      
      public static const STASH_CLIENT:String = "stashClient";
      
      public static const SUBSCRIPTION_GET_INFO:String = "subscriptionGetInfo";
      
      public static const SUBSCRIPTION_FARM:String = "subscriptionFarm";
      
      public static const ZEPPELIN_GIFT_GET:String = "zeppelinGiftGet";
      
      public static const ZEPPELIN_GIFT_FARM:String = "zeppelinGiftFarm";
      
      public static const FRIENDS_GET_INFO:String = "friendsGetInfo";
      
      public static const FRIENDS_SEND_DAILY_GIFT:String = "friendsSendDailyGift";
      
      public static const FRIENDS_SET_INVITED_BY:String = "friendsSetInvitedBy";
      
      public static const SOCIAL_QUEST_GET_INFO:String = "socialQuestGetInfo";
      
      public static const SOCIAL_QUEST_GROUP_JOIN:String = "socialQuestGroupJoin";
      
      public static const SOCIAL_QUEST_POST:String = "socialQuestPost";
      
      public static const MAIL_GET_ALL:String = "mailGetAll";
      
      public static const MAIL_READ:String = "mailRead";
      
      public static const MAIL_FARM:String = "mailFarm";
      
      public static const MAIL_SEND:String = "mailSend";
      
      public static const BILLINGS_GET:String = "billingGetAll";
      
      public static const BILLING_COMPLETE_MOBILE_TRANSACTION:String = "billingCompleteMobileTransaction";
      
      public static const BILLING_GET_LAST:String = "billingGetLast";
      
      public static const BILLING_CHOOSE_HERO:String = "billingChooseHero";
      
      public static const BILLINGS_BUNDLE_DROP:String = "bundleDrop";
      
      public static const BUNDLE_GET_ALL_AVAILABLE_ID:String = "bundleGetAllAvailableId";
      
      public static const BUNDLE_PAUSE:String = "bundlePause";
      
      public static const GET_TIME:String = "getTime";
      
      public static const INVENTORY_GET:String = "inventoryGet";
      
      public static const INVENTORY_SELL:String = "inventorySell";
      
      public static const INVENTORY_BUY:String = "inventoryBuy";
      
      public static const INVENTORY_CRAFT_FRAGMENTS:String = "inventoryCraftFragments";
      
      public static const INVENTORY_CRAFT_RECIPE:String = "inventoryCraftRecipe";
      
      public static const INVENTORY_EXCHANGE_STONES:String = "inventoryExchangeStones";
      
      public static const INVENTORY_EXCHANGE_TITAN_STONES:String = "inventoryExchangeTitanStones";
      
      public static const HERO_GET_ALL:String = "heroGetAll";
      
      public static const HERO_CRAFT:String = "heroCraft";
      
      public static const HERO_EVOLVE:String = "heroEvolve";
      
      public static const HERO_INSERT_ITEM:String = "heroInsertItem";
      
      public static const HERO_ENCHANT_ITEM:String = "heroEnchantItem";
      
      public static const HERO_ENCHANT_RUNE:String = "heroEnchantRune";
      
      public static const HERO_ENCHANT_RUNE_STARMONEY:String = "heroEnchantRuneStarmoney";
      
      public static const HERO_PROMOTE:String = "heroPromote";
      
      public static const HERO_UPGRADE_SKILL:String = "heroUpgradeSkill";
      
      public static const HERO_CONSUMABLE_USE_XP:String = "consumableUseHeroXp";
      
      public static const HERO_SKIN_UPGRADE:String = "heroSkinUpgrade";
      
      public static const HERO_SKIN_CHANGE:String = "heroSkinChange";
      
      public static const HERO_TITAN_GIFT_LEVEL_UP:String = "heroTitanGiftLevelUp";
      
      public static const HERO_TITAN_GIFT_DROP:String = "heroTitanGiftDrop";
      
      public static const HERO_ARTIFACT_EVOLVE:String = "heroArtifactEvolve";
      
      public static const HERO_ARTIFACT_LEVEL_UP:String = "heroArtifactLevelUp";
      
      public static const ARTIFACT_FRAGMENT_BUY:String = "artifactFragmentBuy";
      
      public static const ARTIFACT_CHEST_OPEN:String = "artifactChestOpen";
      
      public static const ARTIFACT_GET_CHEST_LEVEL:String = "artifactGetChestLevel";
      
      public static const TITAN_ARTIFACT_CHEST_OPEN:String = "titanArtifactChestOpen";
      
      public static const TITAN_ARTIFACT_EVOLVE:String = "titanArtifactEvolve";
      
      public static const TITAN_ARTIFACT_LEVEL_UP:String = "titanArtifactLevelUp";
      
      public static const TITAN_ARTIFACT_LEVEL_UP_STARMONEY:String = "titanArtifactLevelUpStarmoney";
      
      public static const TITAN_GET_ALL:String = "titanGetAll";
      
      public static const TITAN_CRAFT:String = "titanCraft";
      
      public static const TITAN_EVOLVE:String = "titanEvolve";
      
      public static const TITAN_CONSUMABLE_USE_XP:String = "consumableUseTitanXp";
      
      public static const TITAN_LEVEL_UP:String = "titanLevelUp";
      
      public static const TITAN_USE_SUMMON_CIRCLE:String = "titanUseSummonCircle";
      
      public static const TITAN_GET_SUMMON_CIRCLE:String = "titanGetSummoningCircle";
      
      public static const TITAN_SPIRIT_GET_ALL:String = "titanSpiritGetAll";
      
      public static const TITAN_SPIRIT_LEVEL_UP:String = "titanSpiritLevelUp";
      
      public static const TITAN_SPIRIT_EVOLVE:String = "titanSpiritEvolve";
      
      public static const TITAN_ARENA_GET_CHEST_REWARD:String = "titanArenaGetChestReward";
      
      public static const TITAN_ARENA_GET_STATUS:String = "titanArenaGetStatus";
      
      public static const TITAN_ARENA_SET_DEFENDERS:String = "titanArenaSetDefenders";
      
      public static const TITAN_ARENA_START_BATTLE:String = "titanArenaStartBattle";
      
      public static const TITAN_ARENA_END_BATTLE:String = "titanArenaEndBattle";
      
      public static const TITAN_ARENA_COMPLETE_TIER:String = "titanArenaCompleteTier";
      
      public static const TITAN_ARENA_FARM_DAILY_REWARD:String = "titanArenaFarmDailyReward";
      
      public static const TITAN_ARENA_GET_RATING_HISTORY:String = "titanArenaGetRatingHistory";
      
      public static const TITAN_ARENA_HALL_OF_FAME_GET:String = "hallOfFameGet";
      
      public static const TITAN_ARENA_HALL_OF_FAME_GET_TROPHIES:String = "hallOfFameGetTrophies";
      
      public static const TITAN_ARENA_HALL_OF_FAME_FARM_TROPHY_REWARD:String = "hallOfFameFarmTrophyReward";
      
      public static const TITAN_ARENA_GET_DAYLY_REWARD:String = "titanArenaGetDailyReward";
      
      public static const TITAN_ARTIFACT_GET_CHEST:String = "titanArtifactGetChest";
      
      public static const TITAN_ARENA_START_RAID:String = "titanArenaStartRaid";
      
      public static const TITAN_ARENA_END_RAID:String = "titanArenaEndRaid";
      
      public static const TEAM_GET_ALL:String = "teamGetAll";
      
      public static const MISSION_GET_ALL:String = "missionGetAll";
      
      public static const MISSION_START:String = "missionStart";
      
      public static const MISSION_END:String = "missionEnd";
      
      public static const MISSION_RAID:String = "missionRaid";
      
      public static const MISSION_BUY_TRIES:String = "missionBuyTries";
      
      public static const MISSION_GET_REPLACE:String = "missionGetReplace";
      
      public static const BATTLE_GET_REPLAY:String = "battleGetReplay";
      
      public static const BATTLE_GET_BY_TYPE:String = "battleGetByType";
      
      public static const CHEST_BUY:String = "chestBuy";
      
      public static const DAILY_BONUS_GET_INFO:String = "dailyBonusGetInfo";
      
      public static const DAILY_BONUS_FARM:String = "dailyBonusFarm";
      
      public static const DUNGEON_GET_INFO:String = "dungeonGetInfo";
      
      public static const DUNGEON_NEXT_FLOOR:String = "dungeonNextFloor";
      
      public static const DUNGEON_START_BATTLE:String = "dungeonStartBattle";
      
      public static const DUNGEON_END_BATTLE:String = "dungeonEndBattle";
      
      public static const DUNGEON_SAVE_PROGRESS:String = "dungeonSaveProgress";
      
      public static const REFILLABLE_BUY_STAMINA:String = "refillableBuyStamina";
      
      public static const REFILLABLE_BUY_SKILLPOINTS:String = "refillableBuySkillpoints";
      
      public static const REFILLABLE_ALCHEMY_USE:String = "refillableAlchemyUse";
      
      public static const SHOP_GET:String = "shopGet";
      
      public static const SHOP_BUY:String = "shopBuy";
      
      public static const SHOP_REFRESH:String = "shopRefresh";
      
      public static const PERSONAL_MERCHANT_GET_ALL:String = "personalMerchantGetAll";
      
      public static const PERSONAL_MERCHANT_GET:String = "personalMerchantGet";
      
      public static const PERSONAL_MERCHANT_BUY:String = "personalMerchantBuy";
      
      public static const HEROES_MERCHANT_GET:String = "heroesMerchantGet";
      
      public static const HEROES_MERCHANT_BUY:String = "heroesMerchantBuy";
      
      public static const QUEST_GET_ALL:String = "questGetAll";
      
      public static const QUEST_GET_PAYMENT_DEPENDENT:String = "questGetPaymentDependent";
      
      public static const QUEST_GET_SOME:String = "questGetSome";
      
      public static const QUEST_FARM:String = "questFarm";
      
      public static const QUEST_GET_EVENTS:String = "questGetEvents";
      
      public static var QUIZ_GET_INFO:String = "quizGetInfo";
      
      public static var QUIZ_GET_NEW_QUESTION:String = "quizGetNewQuestion";
      
      public static var QUIZ_ANSWER:String = "quizAnswer";
      
      public static const OFFER_GET_ALL:String = "offerGetAll";
      
      public static const OFFER_FARM_REWAR:String = "offerFarmReward";
      
      public static const LOOT_BOX_BUY:String = "lootBoxBuy";
      
      public static const TUTORIAL_GET_INFO:String = "tutorialGetInfo";
      
      public static const TUTORIAL_SAVE_PROGRESS:String = "tutorialSaveProgress";
      
      public static const ARENA_GET_ALL:String = "arenaGetAll";
      
      public static const ARENA_FIND_ENEMIES:String = "arenaFindEnemies";
      
      public static const ARENA_ATTACK:String = "arenaAttack";
      
      public static const ARENA_SKIP_COOLDOWN:String = "arenaSkipCooldown";
      
      public static const ARENA_BUY_BATTLES:String = "arenaBuyBattles";
      
      public static const ARENA_SET_HEROES:String = "arenaSetHeroes";
      
      public static const ARENA_CHECK_TARGET_RANGE:String = "arenaCheckTargetRange";
      
      public static const GRAND_FIND_ENEMIES:String = "grandFindEnemies";
      
      public static const GRAND_ATTACK:String = "grandAttack";
      
      public static const GRAND_SKIP_COOLDOWN:String = "grandSkipCooldown";
      
      public static const GRAND_BUY_BATTLES:String = "grandBuyBattles";
      
      public static const GRAND_SET_HEROES:String = "grandSetHeroes";
      
      public static const GRAND_FARM_COINS:String = "grandFarmCoins";
      
      public static const GRAND_CHECK_TARGET_RANGE:String = "grandCheckTargetRange";
      
      public static const CHAT_GET_ALL:String = "chatGetAll";
      
      public static const CHAT_SEND_TEXT:String = "chatSendText";
      
      public static const CHAT_SEND_REPLAY:String = "chatSendReplay";
      
      public static const CHAT_SEND_CHALLENGE:String = "chatSendChallenge";
      
      public static const CHAT_ACCEPT_CHALLENGE:String = "chatAcceptChallenge";
      
      public static const CHAT_GET_INFO:String = "chatGetInfo";
      
      public static const CHAT_BLACK_LIST_ADD:String = "chatBlackListAdd";
      
      public static const CHAT_BLACK_LIST_REMOVE:String = "chatBlackListRemove";
      
      public static const CHAT_BLACK_LIST_DROP:String = "chatBlackListDrop";
      
      public static const CHAT_SERVER_SUBSCRIBE:String = "chatServerSubscribe";
      
      public static const CHAT_SERVER_UNSUBSCRIBE:String = "chatServerUnsubscribe";
      
      public static const CHAT_BAN:String = "chatBan";
      
      public static const CHAT_SET_SETTINGS:String = "chatSetSettings";
      
      public static const CLAN_GET_INFO:String = "clanGetInfo";
      
      public static const CLAN_GET_INFO_BY_IDS:String = "clanGetInfoByIds";
      
      public static const CLAN_FIND:String = "clanFind";
      
      public static const CLAN_FIND_BY_TITLE:String = "clanFindByTitle";
      
      public static const CLAN_IS_TITLE_UNIQUE:String = "clanIsTitleUnique";
      
      public static const CLAN_CREATE:String = "clanCreate";
      
      public static const CLAN_UPDATE:String = "clanUpdate";
      
      public static const CLAN_UPDATE_ICON:String = "clanUpdateIcon";
      
      public static const CLAN_UPDATE_ROLE_NAMES:String = "clanUpdateRoleNames";
      
      public static const CLAN_LEVEL_UP:String = "clanLevelUp";
      
      public static const CLAN_DISBAND:String = "clanDisband";
      
      public static const CLAN_JOIN:String = "clanJoin";
      
      public static const CLAN_GET_STAT:String = "clanGetStat";
      
      public static const CLAN_DISMISS_MEMBER:String = "clanDismissMember";
      
      public static const CLAN_CHANGE_ROLE:String = "clanChangeRole";
      
      public static const CLAN_ITEMS_FOR_ACTIVITY:String = "clanItemsForActivity";
      
      public static const CLAN_ADD_TO_BLACK_LIST:String = "clanAddToBlackList";
      
      public static const CLAN_REMOVE_FROM_BLACK_LIST:String = "clanRemoveFromBlackList";
      
      public static const CLAN_UPDATE_TITLE:String = "clanUpdateTitle";
      
      public static const CLAN_SKIP_ENTER_COOLDOWN:String = "refillableSkipClanCooldown";
      
      public static const CLAN_GET_ACTIVITY_STAT:String = "clanGetActivityStat";
      
      public static const CLAN_GET_LOG:String = "clanGetLog";
      
      public static const CLAN_GET_WEEKLY_STAT:String = "clanGetWeeklyStat";
      
      public static const CLAN_SEND_GIFTS:String = "clanSendGifts";
      
      public static const CLAN_WAR_GET_DEFENCE:String = "clanWarGetDefence";
      
      public static const CLAN_WAR_GET_BRIEF_INFO:String = "clanWarGetBriefInfo";
      
      public static const CLAN_WAR_GET_WARLORD_INFO:String = "clanWarGetWarlordInfo";
      
      public static const CLAN_WAR_GET_INFO:String = "clanWarGetInfo";
      
      public static const CLAN_WAR_FILL_FORTIFICATION:String = "clanWarFillFortification";
      
      public static const CLAN_WAR_SET_DEFENCE_TEAM:String = "clanWarSetDefenceTeam";
      
      public static const CLAN_WAR_ENABLE_WARRIOR:String = "clanWarEnableWarrior";
      
      public static const CLAN_WAR_TEST_START:String = "testClanWarMakeWar";
      
      public static const CLAN_WAR_ATTACK:String = "clanWarAttack";
      
      public static const CLAN_WAR_END_BATTLE:String = "clanWarEndBattle";
      
      public static const CLAN_WAR_TAKE_EMPTY_SLOTS:String = "clanWarTakeEmptySlots";
      
      public static const CLAN_WAR_GET_AVAILABLE_HISTORY:String = "clanWarGetAvailableHistory";
      
      public static const CLAN_WAR_GET_DAY_HISTORY:String = "clanWarGetDayHistory";
      
      public static const CLAN_WAR_GET_LEAGUE_TOP:String = "clanWarGetLeagueTop";
      
      public static const CLAN_WAR_GET_LEAGUE_INFO:String = "clanWarGetLeagueInfo";
      
      public static const TOWER_GET_INFO:String = "towerGetInfo";
      
      public static const TOWER_NEXT_FLOOR:String = "towerNextFloor";
      
      public static const TOWER_CHOOSE_DIFFICULTY:String = "towerChooseDifficulty";
      
      public static const TOWER_START_BATTLE:String = "towerStartBattle";
      
      public static const TOWER_END_BATTLE:String = "towerEndBattle";
      
      public static const TOWER_OPEN_CHEST:String = "towerOpenChest";
      
      public static const TOWER_BUY_BUFF:String = "towerBuyBuff";
      
      public static const TOWER_SKIP_FLOOR:String = "towerSkipFloor";
      
      public static const TOWER_RESET:String = "towerReset";
      
      public static const TOWER_BUY_SKIP:String = "towerBuySkip";
      
      public static const TOWER_NEXT_CHEST:String = "towerNextChest";
      
      public static const TOWER_FULL_SKIP:String = "towerFullSkip";
      
      public static const BOSS_GET_ALL:String = "bossGetAll";
      
      public static const BOSS_ATTACK:String = "bossAttack";
      
      public static const BOSS_RAID:String = "bossRaid";
      
      public static const BOSS_END_BATTLE:String = "bossEndBattle";
      
      public static const BOSS_OPEN_CHEST:String = "bossOpenChest";
      
      public static const BOSS_BUY_TRIES:String = "bossBuyTries";
      
      public static const BOSS_SKIP_COOLDOWN:String = "bossSkipColldown";
      
      public static const PIRATE_TREASURE_IS_AVAILABLE:String = "pirateTreasureIsAvailable";
      
      public static const PIRATE_TREASURE_FARM:String = "pirateTreasureFarm";
      
      public static const OFFER_OK_VIP:String = "offerOkVip";
      
      public static const OFFER_VK:String = "offerVk";
      
      public static const OFFER_FB_TRIALPAY:String = "offerTrialPay";
      
      public static const OFFER_ADVGAME:String = "offerAdvGame";
      
      public static const OFFER_ADMITAD:String = "offerAdmitad";
      
      public static const OFFER_GMR_GIFT_CODE:String = "redeemGmrGiftCode";
      
      public static const FREEBIE_LINK_CHECK:String = "freebieCheck";
      
      public static const FREEBIE_HAVE_GROUP:String = "freebieHaveGroup";
      
      public static const SPLIT_GET_ALL:String = "splitGetAll";
      
      public static const CONSUMABLE_USE_LOOT_BOX:String = "consumableUseLootBox";
      
      public static const CONSUMABLE_USE_STAMINA:String = "consumableUseStamina";
      
      public static const EVENT_BOX_GET_ALL:String = "eventBoxGetAll";
      
      public static const EVENT_BOX_BUY:String = "eventBoxBuy";
      
      public static const EVENT_BOX_OPEN:String = "eventBoxOpen";
      
      public static const USER_MERGE_GET_MERGE_DATA:String = "userMergeGetMergeData";
      
      public static const USER_MERGE_SELECT_USER:String = "userMergeSelectUser";
      
      public static const USER_MERGE_GET_STATUS:String = "userMergeGetStatus";
      
      public static const EXPEDITION_GET:String = "expeditionGet";
      
      public static const EXPEDITION_SEND_HEROES:String = "expeditionSendHeroes";
      
      public static const EXPEDITION_FARM:String = "expeditionFarm";
      
      public static const NEW_YEAR_GET_INFO:String = "newYearGetInfo";
      
      public static const NEW_YEAR_GIFT_GET:String = "newYearGiftGet";
      
      public static const NEW_YEAR_GIFT_OPEN:String = "newYearGiftOpen";
      
      public static const NEW_YEAR_GIFT_SEND:String = "newYearGiftSend";
      
      public static const NEW_YEAR_DECORATE_TREE:String = "newYearDecorateTree";
      
      public static const NEW_YEAR_FIREWORKS_LAUNCH:String = "fireworksLaunch";
       
      
      public function RpcCommandName()
      {
         super();
      }
   }
}
