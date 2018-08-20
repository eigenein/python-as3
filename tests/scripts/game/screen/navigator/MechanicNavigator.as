package game.screen.navigator
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.social.GMRSocialAdapter;
   import com.progrestar.common.social.SocialAdapter;
   import flash.utils.Dictionary;
   import game.command.rpc.clan.CommandClanGetInfo;
   import game.data.storage.DataStorage;
   import game.data.storage.level.LevelRequirement;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.tutorial.TutorialTaskDescription;
   import game.mechanics.MechanicNotEnoughLevelPopupMediator;
   import game.mechanics.boss.mediator.BossMapScreenMediator;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mechanics.clan_war.mediator.ClanWarStartScreenMediator;
   import game.mechanics.dungeon.mediator.DungeonScreenMediator;
   import game.mechanics.expedition.mediator.ExpeditionMapPopupMediator;
   import game.mechanics.expedition.mediator.SubscriptionPopupMediator;
   import game.mechanics.grand.mediator.GrandPopupMediator;
   import game.mechanics.titan_arena.mediator.TitanArenaPopupMediator;
   import game.mechanics.titan_arena.mediator.TitanValleyPopupMediator;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestPopupMediator;
   import game.mechanics.titan_arena.mediator.halloffame.TitanArenaHallOfFamePopupMediator;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaRewardPopupMediator;
   import game.mechanics.zeppelin.mediator.ZeppelinPopupMediator;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.arena.ArenaPopupMediator;
   import game.mediator.gui.popup.chest.ChestPopupMediator;
   import game.mediator.gui.popup.clan.ClanInfoPopupMediator;
   import game.mediator.gui.popup.clan.ClanPublicInfoPopupMediator;
   import game.mediator.gui.popup.clan.ClanSearchPopupMediator;
   import game.mediator.gui.popup.friends.FriendsDailyGiftGMRPopupMediator;
   import game.mediator.gui.popup.friends.FriendsDailyGiftPopupMediator;
   import game.mediator.gui.popup.hero.HeroArtifactListPopupMediator;
   import game.mediator.gui.popup.hero.HeroRuneListPopupMediator;
   import game.mediator.gui.popup.rating.RatingPopupMediator;
   import game.mediator.gui.popup.titan.TitanArtifactListPopupMediator;
   import game.mediator.gui.popup.titanspiritartifact.TitanSpiritArtifactPopupMediator;
   import game.mediator.gui.popup.tower.TowerScreenMediator;
   import game.mediator.gui.worldmap.WorldMapViewMediator;
   import game.mediator.gui.worldmap.WorldMapViewMediatorInitParams;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaData;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialTask;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.dialogs.TutorialMessageEntry;
   import game.view.popup.artifactchest.ArtifactChestPopupMediator;
   import game.view.popup.artifactstore.ArtifactStorePopupMediator;
   import game.view.popup.ny.gifts.NYGiftsPopupMediator;
   import game.view.popup.ny.treeupgrade.NYTreeUpgradePopupMediator;
   import game.view.popup.ny.welcome.NYWelcomePopupMediator;
   import game.view.popup.resource.CopyofNotEnoughResourcePopupMediator;
   import game.view.popup.summoningcircle.SummoningCirclePopUpMediator;
   
   public class MechanicNavigator extends NavigatorBase
   {
       
      
      protected var methodList:Dictionary;
      
      private var notEnoughLevelMethodList:Dictionary;
      
      public function MechanicNavigator(param1:GameNavigator, param2:Player)
      {
         methodList = new Dictionary();
         notEnoughLevelMethodList = new Dictionary();
         super(param1,param2);
         methodList[MechanicStorage.CLAN] = clan;
         methodList[MechanicStorage.CLAN_DUNGEON] = clan_dungeon;
         methodList[MechanicStorage.CLAN_CHEST] = clan_chest;
         methodList[MechanicStorage.ENCHANT] = enchant;
         methodList[MechanicStorage.ARENA] = arena;
         methodList[MechanicStorage.GRAND] = grand;
         methodList[MechanicStorage.CHEST] = chest;
         methodList[MechanicStorage.SKILLS] = skills;
         methodList[MechanicStorage.SOCIAL_GIFT] = social_gift;
         methodList[MechanicStorage.MISSION] = mission;
         methodList[MechanicStorage.TOWER] = tower;
         methodList[MechanicStorage.RATING] = rating;
         methodList[MechanicStorage.BOSS] = boss;
         methodList[MechanicStorage.TITAN_GIFT] = titan_gift;
         methodList[MechanicStorage.CLAN_PVP] = clan_pvp;
         methodList[MechanicStorage.ARTIFACT] = artifact;
         methodList[MechanicStorage.ARTIFACT_MERCHANT] = artifact_merchant;
         methodList[MechanicStorage.ARTIFACT_CHEST] = artifact_chest;
         methodList[MechanicStorage.EXPEDITIONS] = expeditions;
         methodList[MechanicStorage.ZEPPELIN] = zeppelin;
         methodList[MechanicStorage.SUBSCRIPTION] = subscription;
         methodList[MechanicStorage.NY2018_GIFTS] = ny2018_gifts;
         methodList[MechanicStorage.NY2018_TREE] = ny2018_tree;
         methodList[MechanicStorage.NY2018_WELCOME] = ny2018_welcome;
         methodList[MechanicStorage.TITAN_VALLEY] = titan_valley;
         methodList[MechanicStorage.TITAN_ARTIFACT] = titan_artifacts;
         methodList[MechanicStorage.TITAN_ARTIFACT_CHEST] = titan_artifact_chest;
         methodList[MechanicStorage.TITAN_SPIRITS] = titan_artifact_spirits;
         methodList[MechanicStorage.TITAN_ARENA] = titan_arena;
         methodList[MechanicStorage.TITAN_ARENA_HALL_OF_FAME] = titan_arena_hall_of_fame;
         methodList[MechanicStorage.TITAN_ARTIFACT_MERCHANT] = titan_artifact_merchant;
         notEnoughLevelMethodList[MechanicStorage.BOSS] = notEnoughLevel_boss;
         notEnoughLevelMethodList[MechanicStorage.ARENA] = notEnoughLevel_arena;
         notEnoughLevelMethodList[MechanicStorage.GRAND] = notEnoughLevel_grand;
         notEnoughLevelMethodList[MechanicStorage.CLAN] = notEnoughLevel_clan;
         notEnoughLevelMethodList[MechanicStorage.TOWER] = notEnoughLevel_tower;
         notEnoughLevelMethodList[MechanicStorage.TITAN_ARENA] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.TITAN_VALLEY] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.TITAN_ARENA_HALL_OF_FAME] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.TITAN_ARTIFACT] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.TITAN_ARTIFACT_CHEST] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.TITAN_ARTIFACT_MERCHANT] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.TITAN_SPIRITS] = notEnoughLevel_titanValley;
         notEnoughLevelMethodList[MechanicStorage.ARTIFACT] = notEnoughLevel_artifact;
         notEnoughLevelMethodList[MechanicStorage.ARTIFACT_CHEST] = notEnoughLevel_artifact;
         notEnoughLevelMethodList[MechanicStorage.ZEPPELIN] = notEnoughLevel_artifact;
         notEnoughLevelMethodList[MechanicStorage.EXPEDITIONS] = notEnoughLevel_artifact;
         notEnoughLevelMethodList[MechanicStorage.NY2018_GIFTS] = notEnoughLevel_ny2018;
         notEnoughLevelMethodList[MechanicStorage.NY2018_TREE] = notEnoughLevel_ny2018;
      }
      
      function notEnoughLevel_ny2018() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.NY2018_TREE);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_artifact() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.ARTIFACT);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_boss() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.BOSS);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_arena() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.ARENA);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_grand() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.GRAND);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_clan() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.CLAN);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_titanValley() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.TITAN_VALLEY);
         _loc1_.open(null);
      }
      
      function notEnoughLevel_tower() : void
      {
         var _loc1_:MechanicNotEnoughLevelPopupMediator = new MechanicNotEnoughLevelPopupMediator(player,MechanicStorage.TOWER);
         _loc1_.open(null);
      }
      
      function titan_gift(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:HeroRuneListPopupMediator = new HeroRuneListPopupMediator(player,"tab_elements");
         _loc2_.open(param1);
      }
      
      private function artifact(param1:PopupStashEventParams) : void
      {
         var _loc2_:HeroArtifactListPopupMediator = new HeroArtifactListPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      private function artifact_merchant(param1:PopupStashEventParams) : void
      {
         var _loc2_:ArtifactStorePopupMediator = new ArtifactStorePopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      private function artifact_chest(param1:PopupStashEventParams) : void
      {
         var _loc2_:ArtifactChestPopupMediator = new ArtifactChestPopupMediator(GameModel.instance.player,DataStorage.rule.artifactChestRule);
         _loc2_.open(param1);
      }
      
      private function expeditions(param1:PopupStashEventParams) : void
      {
         var _loc2_:ExpeditionMapPopupMediator = new ExpeditionMapPopupMediator(player);
         _loc2_.open(param1);
      }
      
      private function zeppelin(param1:PopupStashEventParams) : void
      {
         var _loc2_:ZeppelinPopupMediator = new ZeppelinPopupMediator(player);
         _loc2_.open(param1);
      }
      
      private function subscription(param1:PopupStashEventParams) : void
      {
         var _loc2_:SubscriptionPopupMediator = new SubscriptionPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function boss(param1:PopupStashEventParams) : void
      {
         var _loc2_:BossMapScreenMediator = new BossMapScreenMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function bossById(param1:int, param2:PopupStashEventParams) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(checkTeamLevel(MechanicStorage.BOSS))
         {
            _loc3_ = DataStorage.boss.getByType(param1);
            _loc4_ = new BossMapScreenMediator(GameModel.instance.player,_loc3_);
            _loc4_.open(param2);
         }
      }
      
      function mission(param1:PopupStashEventParams) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         _loc3_ = WorldMapViewMediatorInitParams.createDefault(player);
         if(_loc3_)
         {
            _loc2_ = new WorldMapViewMediator(GameModel.instance.player,_loc3_);
            _loc2_.open(param1);
         }
      }
      
      function mission_by_desc(param1:MissionDescription, param2:PopupStashEventParams) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:WorldMapViewMediatorInitParams = null;
         if(!param1)
         {
            _loc5_ = WorldMapViewMediatorInitParams.createDefault(player);
         }
         else if(player.missions.isMissionAvailable(param1))
         {
            _loc5_ = WorldMapViewMediatorInitParams.createWithMission(param1);
         }
         else
         {
            _loc4_ = new CopyofNotEnoughResourcePopupMediator(MechanicStorage.MISSION,Translate.translate("UI_MECHANIC_NAVIGATOR_MISSION_NOT_AVAILABLE"),Translate.translate("UI_MECHANIC_NAVIGATOR_MISSION_NOT_AVAILABLE_DESC"));
            _loc4_.open(param2);
         }
         if(_loc5_)
         {
            _loc3_ = new WorldMapViewMediator(GameModel.instance.player,_loc5_);
            _loc3_.open(param2);
         }
      }
      
      function arena(param1:PopupStashEventParams) : void
      {
         var _loc2_:* = null;
         if(!PlayerArenaData.hasHeroesToParticipateInArena(player))
         {
            PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_ARENA_NO_VALID_HEROES",MechanicStorage.ARENA.minHeroLevel));
         }
         else
         {
            _loc2_ = new ArenaPopupMediator(GameModel.instance.player);
            _loc2_.open(param1);
         }
      }
      
      function grand(param1:PopupStashEventParams) : void
      {
         var _loc2_:* = null;
         if(!PlayerArenaData.hasHeroesToParticipateInGrand(player))
         {
            PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_ARENA_NO_VALID_HEROES",MechanicStorage.GRAND.minHeroLevel));
         }
         else
         {
            _loc2_ = new GrandPopupMediator(GameModel.instance.player);
            _loc2_.open(param1);
         }
      }
      
      function tower(param1:PopupStashEventParams) : void
      {
         var _loc2_:TowerScreenMediator = new TowerScreenMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function chest(param1:PopupStashEventParams) : void
      {
         var _loc2_:ChestPopupMediator = new ChestPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function skills(param1:PopupStashEventParams) : void
      {
         PopupList.instance.dialog_hero_list(param1);
      }
      
      function social_gift(param1:PopupStashEventParams) : void
      {
         if(SocialAdapter.instance is GMRSocialAdapter)
         {
            new FriendsDailyGiftGMRPopupMediator(player).open(param1);
         }
         else
         {
            new FriendsDailyGiftPopupMediator(player).open(param1);
         }
      }
      
      function clan(param1:PopupStashEventParams) : void
      {
         var _loc2_:* = null;
         if(!checkTeamLevel(MechanicStorage.CLAN))
         {
            return;
         }
         if(player.clan.clan)
         {
            GamePopupManager.closeAll();
            Game.instance.screen.getMainScreen().toClanScreen();
         }
         else
         {
            _loc2_ = new ClanSearchPopupMediator(player);
            _loc2_.open(Stash.click("clan_search",param1));
         }
      }
      
      function clan_dungeon(param1:PopupStashEventParams) : void
      {
         var _loc2_:* = null;
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(player.titans.getAmount() >= 2)
         {
            if(DungeonScreenMediator.current)
            {
               GamePopupManager.instance.removePopUp(DungeonScreenMediator.current.popup);
               GamePopupManager.instance.addPopUp(DungeonScreenMediator.current.popup);
            }
            else
            {
               _loc2_ = new DungeonScreenMediator(GameModel.instance.player);
               DungeonScreenMediator.current = _loc2_;
               _loc2_.open(Stash.click("clan_dungeon",param1));
            }
         }
         else
         {
            PopupList.instance.dialog_no_titans(Stash.click("clan_dungeon",param1));
         }
      }
      
      function titan_artifact_chest(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         var _loc2_:TitanArtifactChestPopupMediator = new TitanArtifactChestPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("titan_artifact_chest",param1));
      }
      
      function titan_artifact_spirits(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         var _loc2_:TitanSpiritArtifactPopupMediator = new TitanSpiritArtifactPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("titan_artifact_spirits",param1));
      }
      
      function titan_artifacts(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         var _loc2_:TitanArtifactListPopupMediator = new TitanArtifactListPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("titan_artifacts",param1));
      }
      
      function titan_arena(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         var _loc2_:TitanArenaPopupMediator = new TitanArenaPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("titan_arena",param1));
      }
      
      function titan_arena_hall_of_fame(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         if(GameModel.instance.player.titanArenaData.trophyWithNotFarmedReward)
         {
            new TitanArenaRewardPopupMediator(GameModel.instance.player).open(Stash.click("titan_arena_reward",param1));
         }
         else
         {
            new TitanArenaHallOfFamePopupMediator(GameModel.instance.player).open(Stash.click("titan_arena_hall_of_fame",param1));
         }
      }
      
      function titan_artifact_merchant(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         var _loc2_:ShopDescription = DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_TITAN_ARTIFACT_SHOP);
         Game.instance.navigator.navigateToShop(_loc2_,Stash.click("titan_artifact_merchant",param1));
      }
      
      function titan_valley(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(!checkFor5Titans())
         {
            return;
         }
         var _loc2_:TitanValleyPopupMediator = new TitanValleyPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("titan_valley",param1));
      }
      
      function clan_pvp(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:ClanWarStartScreenMediator = new ClanWarStartScreenMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("clan_war",param1));
      }
      
      function clan_chest(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:SummoningCirclePopUpMediator = new SummoningCirclePopUpMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("clan_chest",param1));
      }
      
      function clanById(param1:int = -1) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(player.clan.clan && (player.clan.clan.id == param1 || param1 == -1))
         {
            _loc2_ = new ClanInfoPopupMediator(player);
            _loc2_.open();
         }
         else
         {
            _loc3_ = GameModel.instance.actionManager.clan.clanGetInfo(param1);
            _loc3_.onClientExecute(handler_commandClanGetInfo);
         }
      }
      
      function enchant(param1:PopupStashEventParams) : void
      {
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:HeroRuneListPopupMediator = new HeroRuneListPopupMediator(player);
         _loc2_.open(param1);
      }
      
      function rating(param1:PopupStashEventParams) : void
      {
         if(!checkTeamLevel(MechanicStorage.RATING))
         {
            return;
         }
         var _loc2_:RatingPopupMediator = new RatingPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function ny2018_gifts(param1:PopupStashEventParams) : void
      {
         if(!checkTeamLevel(MechanicStorage.NY2018_GIFTS))
         {
            return;
         }
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:NYGiftsPopupMediator = new NYGiftsPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function ny2018_tree(param1:PopupStashEventParams) : void
      {
         if(!checkTeamLevel(MechanicStorage.NY2018_GIFTS))
         {
            return;
         }
         if(!checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:NYTreeUpgradePopupMediator = new NYTreeUpgradePopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function ny2018_welcome(param1:PopupStashEventParams) : void
      {
         var _loc2_:NYWelcomePopupMediator = new NYWelcomePopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      function navigate(param1:MechanicDescription, param2:PopupStashEventParams) : void
      {
         if(checkTeamLevel(param1))
         {
            if(methodList[param1])
            {
               methodList[param1](param2);
            }
         }
      }
      
      function checkFor5Titans() : Boolean
      {
         if(player.titans.getAmount() < 5)
         {
            PopupList.instance.message(Translate.translate("UI_TITAN_ARENA_NEGATIVE_TEXT_VALLEY"));
            return false;
         }
         return true;
      }
      
      function checkIfInClanAndSearchForClanIfNot(param1:PopupStashEventParams) : Boolean
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!checkTeamLevel(MechanicStorage.CLAN))
         {
            return false;
         }
         if(player.clan.clan)
         {
            if(Tutorial.flags.clanScreenIsIntroduced || Tutorial.inputIsBlocked)
            {
               return true;
            }
            GamePopupManager.closeAll();
            _loc4_ = new TutorialTaskDescription({});
            _loc2_ = new TutorialTask(_loc4_,null);
            _loc2_.setGuiTarget(TutorialNavigator.CLAN_SCREEN);
            _loc2_.completeCondition = new TutorialCondition("navigationCompleteAny");
            _loc2_.message = new TutorialMessageEntry(null);
            _loc2_.message.text = Translate.translate("UI_TUTORIAL_CLAN_SCREEN_PROMPT");
            _loc2_.message.icon = "hero7";
            _loc2_.message.position = "center";
            Tutorial.startCustomTask(_loc2_);
            return false;
         }
         _loc3_ = new ClanSearchPopupMediator(player);
         _loc3_.open(Stash.click("clan_search",param1));
         return false;
      }
      
      function hasNavigatorForMechanic(param1:MechanicDescription) : Boolean
      {
         return methodList[param1] != null;
      }
      
      function internal_checkTeamLevel(param1:LevelRequirement) : Boolean
      {
         return checkTeamLevel(param1);
      }
      
      override protected function checkTeamLevel(param1:LevelRequirement) : Boolean
      {
         if(player.levelData.level.level < param1.teamLevel)
         {
            if(notEnoughLevelMethodList[param1])
            {
               notEnoughLevelMethodList[param1]();
            }
            else
            {
               1;
               PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",param1.teamLevel));
            }
            return false;
         }
         return true;
      }
      
      private function handler_commandClanGetInfo(param1:CommandClanGetInfo) : void
      {
         var _loc2_:* = null;
         if(param1.clanValueObject)
         {
            _loc2_ = new ClanPublicInfoPopupMediator(param1.clanValueObject,GameModel.instance.player);
            _loc2_.open();
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_MECHANIC_NAVIGATOR_UNDEFINED_CLAN"));
         }
      }
   }
}
