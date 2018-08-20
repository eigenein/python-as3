package game.data.storage
{
   import engine.loader.ClientVersion;
   import flash.utils.getTimer;
   import game.data.storage.admiration.AdmirationDescriptionStorage;
   import game.data.storage.arena.ArenaDescriptionStorage;
   import game.data.storage.artifact.ArtifactStorage;
   import game.data.storage.artifact.TitanArtifactStorage;
   import game.data.storage.battle.BattleConfigStorage;
   import game.data.storage.battle.BattlePrototypeStorrage;
   import game.data.storage.bundle.BundleDescriptionStorage;
   import game.data.storage.chest.ChestDescriptionStorage;
   import game.data.storage.clan.ClanActivityRewardStorage;
   import game.data.storage.clan.ClanDungeonActivityRewardStorage;
   import game.data.storage.clan.ClanIconStorage;
   import game.data.storage.clan.ClanRoleStorage;
   import game.data.storage.clan.ClanSummoningCircleStorage;
   import game.data.storage.dailybonus.DailyBonusDescriptionStorage;
   import game.data.storage.enum.lib.EnumStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.gear.GearDescriptionStorage;
   import game.data.storage.hero.HeroDescriptionStorage;
   import game.data.storage.hero.HeroObtainType;
   import game.data.storage.level.LevelStorage;
   import game.data.storage.loot.LootBoxRewardGroupStorage;
   import game.data.storage.loot.LootBoxStorage;
   import game.data.storage.mailtype.MailTypeStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.notification.NotificationStorage;
   import game.data.storage.nygifts.NYGiftsStorage;
   import game.data.storage.particle.ParticleDataStorage;
   import game.data.storage.playeravatar.PlayerAvatarStorage;
   import game.data.storage.posting.SocialGraphStorage;
   import game.data.storage.pve.mission.MissionStorage;
   import game.data.storage.pve.trial.TrialStorage;
   import game.data.storage.quest.QuestDescriptionStorage;
   import game.data.storage.quest.SpecialQuestEventStorage;
   import game.data.storage.refillable.RefillableDescriptionStorage;
   import game.data.storage.resource.CoinDescriptionStorage;
   import game.data.storage.resource.ConsumableDescriptionStorage;
   import game.data.storage.resource.InventoryItemObtainType;
   import game.data.storage.resource.PseudoResourceStorage;
   import game.data.storage.resource.ScrollDescriptionStorage;
   import game.data.storage.rewardmodifier.RewardModifierStorage;
   import game.data.storage.rule.RuleStorage;
   import game.data.storage.rune.RuneDescriptionStorage;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.skills.SkillDescriptionStorage;
   import game.data.storage.skin.SkinDescriptionStorage;
   import game.data.storage.subscription.SubscriptionDescriptionStorage;
   import game.data.storage.titan.TitanDescriptionStorage;
   import game.data.storage.titan.TitanGiftDescriptionStorage;
   import game.data.storage.titanarenaleague.TitanArenaStorage;
   import game.data.storage.tower.TowerStorage;
   import game.data.storage.tutorial.TutorialDescriptionStorage;
   import game.data.storage.world.WorldMapStorage;
   import game.mechanics.boss.storage.BossStorage;
   import game.mechanics.clan_war.storage.ClanWarStorage;
   import game.mechanics.dungeon.storage.DungeonDescriptionStorage;
   import game.mechanics.expedition.storage.ExpeditionSlotStorage;
   
   public class DataStorage
   {
      
      public static const enum:EnumStorage = new EnumStorage();
      
      public static const level:LevelStorage = new LevelStorage();
      
      public static const particle:ParticleDataStorage = new ParticleDataStorage();
      
      public static const gear:GearDescriptionStorage = new GearDescriptionStorage();
      
      public static const scroll:ScrollDescriptionStorage = new ScrollDescriptionStorage();
      
      public static const consumable:ConsumableDescriptionStorage = new ConsumableDescriptionStorage();
      
      public static const coin:CoinDescriptionStorage = new CoinDescriptionStorage();
      
      public static const pseudo:PseudoResourceStorage = new PseudoResourceStorage();
      
      public static const rune:RuneDescriptionStorage = new RuneDescriptionStorage();
      
      public static const hero:HeroDescriptionStorage = new HeroDescriptionStorage();
      
      public static const skill:SkillDescriptionStorage = new SkillDescriptionStorage();
      
      public static const skin:SkinDescriptionStorage = new SkinDescriptionStorage();
      
      public static const titan:TitanDescriptionStorage = new TitanDescriptionStorage();
      
      public static const titanGift:TitanGiftDescriptionStorage = new TitanGiftDescriptionStorage();
      
      public static const refillable:RefillableDescriptionStorage = new RefillableDescriptionStorage();
      
      public static const rewardModifier:RewardModifierStorage = new RewardModifierStorage();
      
      public static const rule:RuleStorage = new RuleStorage();
      
      public static const battleConfig:BattleConfigStorage = new BattleConfigStorage();
      
      public static const world:WorldMapStorage = new WorldMapStorage();
      
      public static const chest:ChestDescriptionStorage = new ChestDescriptionStorage();
      
      public static const dailyBonus:DailyBonusDescriptionStorage = new DailyBonusDescriptionStorage();
      
      public static const mission:MissionStorage = new MissionStorage();
      
      public static const trial:TrialStorage = new TrialStorage();
      
      public static const tower:TowerStorage = new TowerStorage();
      
      public static const boss:BossStorage = new BossStorage();
      
      public static const dungeon:DungeonDescriptionStorage = new DungeonDescriptionStorage();
      
      public static const shop:ShopDescriptionStorage = new ShopDescriptionStorage();
      
      public static const quest:QuestDescriptionStorage = new QuestDescriptionStorage();
      
      public static const specialQuestEvent:SpecialQuestEventStorage = new SpecialQuestEventStorage();
      
      public static const arena:ArenaDescriptionStorage = new ArenaDescriptionStorage();
      
      public static const bundle:BundleDescriptionStorage = new BundleDescriptionStorage();
      
      public static const playerAvatar:PlayerAvatarStorage = new PlayerAvatarStorage();
      
      public static const admiration:AdmirationDescriptionStorage = new AdmirationDescriptionStorage();
      
      public static const subscription:SubscriptionDescriptionStorage = new SubscriptionDescriptionStorage();
      
      public static const nickname:NicknameStorage = new NicknameStorage();
      
      public static const mailType:MailTypeStorage = new MailTypeStorage();
      
      public static const mechanic:MechanicStorage = new MechanicStorage();
      
      public static const tutorial:TutorialDescriptionStorage = new TutorialDescriptionStorage();
      
      public static const notification:NotificationStorage = new NotificationStorage();
      
      public static const nyGifts:NYGiftsStorage = new NYGiftsStorage();
      
      public static const specialOffer:SpecialOfferDescriptionStorage = new SpecialOfferDescriptionStorage();
      
      public static const battlePrototype:BattlePrototypeStorrage = new BattlePrototypeStorrage();
      
      public static const clanIcon:ClanIconStorage = new ClanIconStorage();
      
      public static const clanRole:ClanRoleStorage = new ClanRoleStorage();
      
      public static const clanActivityReward:ClanActivityRewardStorage = new ClanActivityRewardStorage();
      
      public static const clanDungeonActivityReward:ClanDungeonActivityRewardStorage = new ClanDungeonActivityRewardStorage();
      
      public static const clanSummoningCircle:ClanSummoningCircleStorage = new ClanSummoningCircleStorage();
      
      public static const clanWar:ClanWarStorage = new ClanWarStorage();
      
      public static const posting:SocialGraphStorage = new SocialGraphStorage();
      
      public static const lootBoxRewardGroup:LootBoxRewardGroupStorage = new LootBoxRewardGroupStorage();
      
      public static const lootBox:LootBoxStorage = new LootBoxStorage();
      
      public static const artifact:ArtifactStorage = new ArtifactStorage();
      
      public static const titanArtifact:TitanArtifactStorage = new TitanArtifactStorage();
      
      public static const expeditionSlot:ExpeditionSlotStorage = new ExpeditionSlotStorage();
      
      public static const titanArena:TitanArenaStorage = new TitanArenaStorage();
       
      
      public function DataStorage(param1:Object)
      {
         super();
         var _loc2_:int = getTimer();
         ClientVersion.lib_ver = param1.version;
         InventoryItemType.GEAR.storage = gear;
         InventoryItemType.CONSUMABLE.storage = consumable;
         InventoryItemType.SCROLL.storage = scroll;
         InventoryItemType.HERO.storage = hero;
         InventoryItemType.TITAN.storage = titan;
         InventoryItemType.COIN.storage = coin;
         InventoryItemType.PSEUDO.storage = pseudo;
         InventoryItemType.SKIN.storage = skin;
         InventoryItemType.ARTIFACT.storage = artifact;
         InventoryItemType.TITAN_ARTIFACT.storage = titanArtifact;
         enum.init(param1["enum"]);
         particle.init(param1.particle);
         level.init(param1.level);
         mechanic.init(param1.mechanic);
         gear.init(param1.inventoryItem[InventoryItemType.GEAR.type]);
         scroll.init(param1.inventoryItem[InventoryItemType.SCROLL.type]);
         consumable.init(param1.inventoryItem[InventoryItemType.CONSUMABLE.type]);
         coin.init(param1.inventoryItem[InventoryItemType.COIN.type]);
         pseudo.init(param1.inventoryItem[InventoryItemType.PSEUDO.type]);
         gear.initCraftRecipe(param1.inventoryItem[InventoryItemType.GEAR.type]);
         scroll.updateGear(gear);
         clanIcon.initialize(param1.clan.icon);
         clanRole.init(param1.clan.role);
         clanActivityReward.init(param1.clan.activityReward);
         clanDungeonActivityReward.init(param1.clan.dungeonActivityReward);
         clanSummoningCircle.init(param1.clan.summoningCircle);
         clanWar.init(param1.clanWar);
         artifact.init(param1.artifact);
         rune.init(param1.rune);
         hero.init(param1.hero);
         skill.init(param1.skill);
         skin.init(param1.skin);
         titanArtifact.init(param1.titanArtifact);
         titan.init(param1.titan);
         titanGift.init(param1.titanGift);
         titanArena.init(param1.titanArena);
         refillable.init(param1.refillable);
         rewardModifier.init(param1.rewardModifier);
         rule.init(param1.rule);
         battleConfig.init(param1.battleConfig);
         mailType.init(param1.mail.type);
         bundle.initBundleReward(param1.bundleHeroReward);
         bundle.init(param1.bundle);
         world.init(param1.world);
         chest.init(param1.chest);
         dailyBonus.init(param1.dailyBonusStatic);
         mission.init(param1.mission);
         trial.init(param1.trial);
         tower.init(param1.tower);
         boss.init(param1.boss);
         dungeon.init(param1.dungeon);
         shop.init(param1.shop);
         quest.init(param1.quest);
         specialQuestEvent.init(param1.specialQuestEvent);
         arena.init(param1.arena);
         playerAvatar.init(param1.playerAvatar);
         admiration.init(param1.admiration);
         subscription.init(param1.subscription);
         nickname.init(param1.nickname);
         tutorial.init(param1.tutorial);
         notification.init(param1.notification);
         specialOffer.init(param1.specialOffer);
         battlePrototype.init(param1.battlePrototype);
         posting.init(param1.socialGraph);
         lootBoxRewardGroup.init(param1.lootBoxRewardGroup);
         lootBox.init(param1.lootBox);
         nyGifts.init(param1.eventBox);
         expeditionSlot.init(param1.expedition.slot);
         expeditionSlot.initStories(param1.expedition.story);
      }
      
      public static function applyLocale() : void
      {
         chest.applyLocale();
         coin.applyLocale();
         consumable.applyLocale();
         gear.applyLocale();
         HeroObtainType.applyLocale();
         InventoryItemObtainType.applyLocale();
         mission.applyLocale();
         pseudo.applyLocale();
         scroll.applyLocale();
         shop.applyLocale();
         skill.applyLocale();
         skin.applyLocale();
         enum.applyLocale();
         world.applyLocale();
         notification.applyLocale();
         tower.applyLocale();
         boss.applyLocale();
         hero.applyLocale();
         quest.applyLocale();
         playerAvatar.applyLocale();
         clanWar.applyLocale();
         artifact.applyLocale();
         titanArtifact.applyLocale();
         nyGifts.applyLocale();
      }
   }
}
